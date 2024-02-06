// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

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
    uint256 collectorBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    // Validate the Collector has enough aUSDC v3
    assertGe(collectorBalanceBefore, proposal.TOTAL_AMOUNT());

    uint256 recipientBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(proposal.BGD_RECIPIENT()),
      recipientBalanceBefore + proposal.TOTAL_AMOUNT(),
      1
    );

    uint256 collectorBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    // Checking worst case scenario of 3 wei imprecision, but probabilistically pretty rare
    assertApproxEqAbs(collectorBalanceAfter, collectorBalanceBefore - proposal.TOTAL_AMOUNT(), 3);
  }
}
