// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AprilFundingUpdate_20250328} from './AaveV3Ethereum_AprilFundingUpdate_20250328.sol';

/**
 * @dev Test for AaveV3Ethereum_AprilFundingUpdate_20250328
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250328_Multi_AprilFundingUpdate/AaveV3Ethereum_AprilFundingUpdate_20250328.t.sol -vv
 */
contract AaveV3Ethereum_AprilFundingUpdate_20250328_Test is ProtocolV3TestBase {
  event SwapRequested(
    address milkman,
    address indexed fromToken,
    address indexed toToken,
    address fromOracle,
    address toOracle,
    uint256 amount,
    address indexed recipient,
    uint256 slippage
  );

  AaveV3Ethereum_AprilFundingUpdate_20250328 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22145727);
    proposal = new AaveV3Ethereum_AprilFundingUpdate_20250328();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AprilFundingUpdate_20250328',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_withdrawAndSwap() public {
    uint256 usdcAmountBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 usdtAmountBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.USDC_SWAP_AMOUNT(),
      address(AaveV3Ethereum.COLLECTOR),
      75
    );
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.USDT_SWAP_AMOUNT(),
      address(AaveV3Ethereum.COLLECTOR),
      75
    );
    executePayload(vm, address(proposal));

    uint256 usdcAmountAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 usdtAmountAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(usdcAmountBefore, usdcAmountAfter + proposal.USDC_SWAP_AMOUNT(), 800_000e6);
    assertApproxEqAbs(usdtAmountBefore, usdtAmountAfter + proposal.USDT_SWAP_AMOUNT(), 800_000e6);
  }

  function test_transferAndApprove() public {
    uint256 fluidCollectorBalanceBefore = IERC20(proposal.FLUID()).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 fluidEmbassyBalanceBefore = IERC20(proposal.FLUID()).balanceOf(proposal.EMBASSY_SAFE());

    executePayload(vm, address(proposal));

    uint256 fluidCollectorBalanceAfter = IERC20(proposal.FLUID()).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 fluidEmbassyBalanceAfter = IERC20(proposal.FLUID()).balanceOf(proposal.EMBASSY_SAFE());
    uint256 aUsdcAllowance = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_SAFE()
    );

    assertEq(fluidCollectorBalanceAfter, 0);
    assertEq(fluidCollectorBalanceBefore, fluidEmbassyBalanceAfter - fluidEmbassyBalanceBefore);
    assertEq(aUsdcAllowance, proposal.MERIT_ALLOWANCE());
  }
}
