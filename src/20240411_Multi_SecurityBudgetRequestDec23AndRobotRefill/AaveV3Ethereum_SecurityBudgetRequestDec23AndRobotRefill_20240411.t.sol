// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411} from './AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411
 * command: make test-contract filter=AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411
 */
contract AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411 internal proposal;

  event KeeperRefilled(uint256 indexed id, address indexed from, uint96 indexed amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19631594);
    proposal = new AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_consistentBalances() public {
    uint256 collectorAUsdcBalanceBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAUsdtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorALinkBalanceBefore = IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    // Validate the Collector has enough aUSDC v2
    assertGe(collectorAUsdcBalanceBefore, proposal.USDC_AMOUNT_REIMBURSEMENT());

    // Validate the Collector has enough aUSDT v2
    assertGe(collectorAUsdtBalanceBefore, proposal.USDT_AMOUNT_REIMBURSEMENT());

    // Validate the Collector has enough aLINK v2
    assertGe(
      collectorALinkBalanceBefore,
      proposal.LINK_AMOUNT_ROBOT_1_REFILL() +
        proposal.LINK_AMOUNT_ROBOT_2_REFILL() +
        proposal.LINK_AMOUNT_REIMBURSEMENT()
    );

    uint256 recipientAUsdcBalanceBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientAUsdtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientALinkBalanceBefore = IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    executePayload(vm, address(proposal));

    uint256 recipientAUsdcBalanceAfter = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientAUsdtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 recipientALinkBalanceAfter = IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    assertApproxEqAbs(
      recipientAUsdcBalanceAfter,
      recipientAUsdcBalanceBefore + proposal.USDC_AMOUNT_REIMBURSEMENT(),
      1
    );
    assertApproxEqAbs(
      recipientAUsdtBalanceAfter,
      recipientAUsdtBalanceBefore + proposal.USDT_AMOUNT_REIMBURSEMENT(),
      1
    );
    assertApproxEqAbs(
      recipientALinkBalanceAfter,
      recipientALinkBalanceBefore + proposal.LINK_AMOUNT_REIMBURSEMENT(),
      1
    );

    uint256 collectorAUsdcBalanceAfter = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAUsdtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorALinkBalanceAfter = IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(
      collectorAUsdcBalanceAfter,
      collectorAUsdcBalanceBefore - proposal.USDC_AMOUNT_REIMBURSEMENT(),
      3
    );
    assertApproxEqAbs(
      collectorAUsdtBalanceAfter,
      collectorAUsdtBalanceBefore - proposal.USDT_AMOUNT_REIMBURSEMENT(),
      3
    );

    // high delta is because when withdrawing LINK from collector on aave v2, the state update causes claiming rewards to treasury
    assertApproxEqAbs(
      collectorALinkBalanceAfter,
      collectorALinkBalanceBefore -
        (proposal.LINK_AMOUNT_REIMBURSEMENT() +
          proposal.LINK_AMOUNT_ROBOT_1_REFILL() +
          proposal.LINK_AMOUNT_ROBOT_2_REFILL()),
      0.3 ether
    );
  }

  function test_robot_refilled() public {
    vm.expectEmit();
    emit KeeperRefilled(
      proposal.ROBOT_1_ID(),
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      uint96(proposal.LINK_AMOUNT_ROBOT_1_REFILL())
    );

    vm.expectEmit();
    emit KeeperRefilled(
      proposal.ROBOT_2_ID(),
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      uint96(proposal.LINK_AMOUNT_ROBOT_2_REFILL())
    );

    executePayload(vm, address(proposal));
  }
}
