// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {SafeCast} from 'solidity-utils/contracts/oz-common/SafeCast.sol';

/**
 * @title Update PoR Executor V3 Robot
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/42
 */
contract AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  uint256 public constant OLD_POR_ROBOT_ID =
    26365172985027002678612464504385127359853428975895609819521748772469113961166;

  address public constant PROOF_OF_RESERVE_ROBOT_ADDRESS =
    0x7aE2930B50CFEbc99FE6DB16CE5B9C7D8d09332C;
  address public constant PROOF_OF_RESERVE_EXECUTOR_V3 = 0xB94e515615c244Ab25f7A6e592e3Cb7EE31E99F4;
  uint256 public constant LINK_AMOUNT = 15 ether;

  function execute() external {
    AaveV3Avalanche.ACL_MANAGER.addRiskAdmin(PROOF_OF_RESERVE_EXECUTOR_V3);

    // register new PoR robot
    IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR).withdrawLink(OLD_POR_ROBOT_ID);

    AaveV3Avalanche.COLLECTOR.transfer(
      AaveV3AvalancheAssets.LINKe_UNDERLYING,
      address(this),
      LINK_AMOUNT
    );

    IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).forceApprove(
      MiscAvalanche.AAVE_CL_ROBOT_OPERATOR,
      LINK_AMOUNT
    );

    IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR).register(
      'Proof Of Reserve Robot V3',
      PROOF_OF_RESERVE_ROBOT_ADDRESS,
      abi.encode(PROOF_OF_RESERVE_EXECUTOR_V3),
      2_500_000,
      LINK_AMOUNT.toUint96(),
      0,
      ''
    );
  }
}
