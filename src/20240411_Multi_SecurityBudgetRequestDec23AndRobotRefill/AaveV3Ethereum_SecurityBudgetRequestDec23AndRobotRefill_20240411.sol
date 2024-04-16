// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeCast} from 'solidity-utils/contracts/oz-common/SafeCast.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Security Budget Request Dec 23 and Robot Refill
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xf95bc210e3e93c2112c694cb158db22c93504155b48c03d9358e4c41c33ee782
 * - Discussion: https://governance.aave.com/t/arfc-bgd-security-budget-request-december-2023/15783
 */
contract AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411 is
  IProposalGenericExecutor
{
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  address public constant BGD_RECIPIENT = 0xb812d0944f8F581DfAA3a93Dda0d22EcEf51A9CF;
  uint256 public constant USDC_AMOUNT_REIMBURSEMENT = 42_000e6;
  uint256 public constant USDT_AMOUNT_REIMBURSEMENT = 109_200e6;
  uint256 public constant LINK_AMOUNT_REIMBURSEMENT = 1640 ether;
  uint256 public constant LINK_AMOUNT_ROBOT_1_REFILL = 500 ether; // ROBOT_1: Execution Chain Aave Robot
  uint256 public constant LINK_AMOUNT_ROBOT_2_REFILL = 500 ether; // ROBOT_2: Governance Chain Aave Robot

  address public constant ROBOT_OPERATOR = 0x020E452b463568f55BAc6Dc5aFC8F0B62Ea5f0f3;
  uint256 public constant ROBOT_1_ID =
    103962992988872542945147446194468190544109628047207929929141163121857186570465; // Chainlink Automation Id of Execution Chain Aave Robot
  uint256 public constant ROBOT_2_ID =
    2651260633509968244842245718659958660539758109819220392919944208741153930322; // Chainlink Automation Id of Governance Chain Aave Robot

  function execute() external {
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      BGD_RECIPIENT,
      USDC_AMOUNT_REIMBURSEMENT
    );
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      BGD_RECIPIENT,
      USDT_AMOUNT_REIMBURSEMENT
    );
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.LINK_A_TOKEN,
      BGD_RECIPIENT,
      LINK_AMOUNT_REIMBURSEMENT
    );

    // refill aave robot
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.LINK_A_TOKEN,
      address(this),
      LINK_AMOUNT_ROBOT_1_REFILL + LINK_AMOUNT_ROBOT_2_REFILL
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 linkBalance = IERC20(AaveV2EthereumAssets.LINK_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV2EthereumAssets.LINK_UNDERLYING).forceApprove(ROBOT_OPERATOR, linkBalance);

    IAaveCLRobotOperator(ROBOT_OPERATOR).refillKeeper(
      ROBOT_1_ID,
      (LINK_AMOUNT_ROBOT_1_REFILL).toUint96()
    );
    IAaveCLRobotOperator(ROBOT_OPERATOR).refillKeeper(
      ROBOT_2_ID,
      (linkBalance - LINK_AMOUNT_ROBOT_1_REFILL).toUint96()
    );
  }
}
