// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_JuneFundingUpdate_20250616} from './AaveV3Ethereum_JuneFundingUpdate_20250616.sol';

/**
 * @dev Test for AaveV3Ethereum_JuneFundingUpdate_20250616
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250616_AaveV3Ethereum_JuneFundingUpdate/AaveV3Ethereum_JuneFundingUpdate_20250616.t.sol -vv
 */
contract AaveV3Ethereum_JuneFundingUpdate_20250616_Test is ProtocolV3TestBase {
  AaveV3Ethereum_JuneFundingUpdate_20250616 internal proposal;

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
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22719440);
    proposal = new AaveV3Ethereum_JuneFundingUpdate_20250616();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_JuneFundingUpdate_20250616',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_AHAB_SAFE()
      ),
      0
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_AHAB_SAFE()
      ),
      0
    );

    uint256 allowanceAEthUSDCBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AFC_SAFE()
      ),
      0
    );

    uint256 allowanceAEthUSDTBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.AFC_SAFE()
      ),
      0
    );

    executePayload(vm, address(proposal));

    uint256 allowanceGhoAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_AHAB_SAFE()
    );

    uint256 allowanceWethAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_AHAB_SAFE()
    );

    uint256 allowanceAEthUSDCAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE()
    );

    uint256 allowanceAEthUSDTAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE()
    );

    assertEq(allowanceGhoAfter, proposal.MERIT_LIDO_GHO_ALLOWANCE());
    assertEq(allowanceWethAfter, proposal.AHAB_WETH_ALLOWANCE());
    assertEq(allowanceAEthUSDCAfter, allowanceAEthUSDCBefore + proposal.AFC_USDC_ALLOWANCE());
    assertEq(allowanceAEthUSDTAfter, allowanceAEthUSDTBefore + proposal.AFC_USDT_ALLOWANCE());

    vm.startPrank(proposal.MERIT_AHAB_SAFE());
    IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_AHAB_SAFE(),
      proposal.MERIT_LIDO_GHO_ALLOWANCE()
    );
    IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_AHAB_SAFE(),
      proposal.AHAB_WETH_ALLOWANCE()
    );
    vm.stopPrank();

    vm.startPrank(proposal.AFC_SAFE());
    IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE(),
      proposal.AFC_USDC_ALLOWANCE()
    );

    IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AFC_SAFE(),
      proposal.AFC_USDT_ALLOWANCE()
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
      proposal.GHO_USD_FEED(),
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
      proposal.GHO_USD_FEED(),
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
