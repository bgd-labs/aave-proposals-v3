// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {ChainlinkEthereum} from 'aave-address-book/ChainlinkEthereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3EthereumLido_CEXEarnFundingProposal_20250625} from './AaveV3EthereumLido_CEXEarnFundingProposal_20250625.sol';

/**
 * @dev Test for AaveV3EthereumLido_CEXEarnFundingProposal_20250625
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250625_AaveV3EthereumLido_CEXEarnFundingProposal/AaveV3EthereumLido_CEXEarnFundingProposal_20250625.t.sol -vv
 */
contract AaveV3EthereumLido_CEXEarnFundingProposal_20250625_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_CEXEarnFundingProposal_20250625 internal proposal;

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

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22796230);
    proposal = new AaveV3EthereumLido_CEXEarnFundingProposal_20250625();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_CEXEarnFundingProposal_20250625',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
        address(AaveV3EthereumLido.COLLECTOR),
        proposal.AFC_SAFE()
      ),
      0
    );

    executePayload(vm, address(proposal));

    uint256 allowanceGhoAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3EthereumLido.COLLECTOR),
      proposal.AFC_SAFE()
    );

    assertEq(allowanceGhoAfter, proposal.CEX_EARN_AMOUNT());

    vm.startPrank(proposal.AFC_SAFE());
    IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE(),
      3_000_000 ether // Only so much available right now, will deposit via stewards post swaps
    );
    vm.stopPrank();
  }

  function test_swaps() public {
    uint256 usdcAmountBefore = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 usdtAmountBefore = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      ChainlinkEthereum.GHO_USD,
      proposal.USDC_SWAP_AMOUNT(),
      address(AaveV3Ethereum.COLLECTOR),
      75
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      ChainlinkEthereum.GHO_USD,
      proposal.USDT_SWAP_AMOUNT(),
      address(AaveV3Ethereum.COLLECTOR),
      75
    );

    executePayload(vm, address(proposal));

    uint256 usdcAmountAfter = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 usdtAmountAfter = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(usdtAmountAfter, usdtAmountBefore - proposal.USDT_SWAP_AMOUNT());
    assertEq(usdcAmountAfter, usdcAmountBefore - proposal.USDC_SWAP_AMOUNT());
  }
}
