// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206} from './AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206.sol';

/**
 * @dev Test for AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206
 * command: make test-contract filter=AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206
 */
contract AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19167318);
    proposal = new AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SecurityBudgetRequestDecember2023_20240206',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_consistentBalances() public {
    uint256 collectorUsdcBalanceBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 collectorUsdtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    // Validate the Collector has enough aUSDC v2
    assertGe(collectorUsdcBalanceBefore, proposal.USDC_AMOUNT());

    // Validate the Collector has enough aUSDT v2
    assertGe(collectorUsdtBalanceBefore, proposal.USDT_AMOUNT());

    uint256 recipientUsdcBalanceBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientUsdtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    executePayload(vm, address(proposal));

    uint256 recipientUsdcBalanceAfter = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientUsdtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    assertApproxEqAbs(
      recipientUsdcBalanceAfter,
      recipientUsdcBalanceBefore + proposal.USDC_AMOUNT(),
      1
    );
    assertApproxEqAbs(
      recipientUsdtBalanceAfter,
      recipientUsdtBalanceBefore + proposal.USDT_AMOUNT(),
      1
    );

    uint256 collectorUsdcBalanceAfter = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 collectorUsdtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(
      collectorUsdcBalanceAfter,
      collectorUsdcBalanceBefore - proposal.USDC_AMOUNT(),
      3
    );
    assertApproxEqAbs(
      collectorUsdtBalanceAfter,
      collectorUsdtBalanceBefore - proposal.USDT_AMOUNT(),
      3
    );
  }
}
