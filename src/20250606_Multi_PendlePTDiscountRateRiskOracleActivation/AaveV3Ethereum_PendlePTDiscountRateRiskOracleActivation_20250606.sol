// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets, ICollector} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/interfaces/IERC20.sol';

import {IRiskSteward} from './interfaces/IRiskSteward.sol';
import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606 is
  IProposalGenericExecutor
{
  using SafeCast for uint256;
  using CollectorUtils for ICollector;
  using SafeERC20 for IERC20;

  address public constant NEW_RISK_STEWARD = 0xFCE597866Ffaf617EFdcA1C1Ad50eBCB16B5171E;

  address public constant EDGE_RISK_STEWARD = 0x9F76954f5b55B4908d178f31C07F9537AC8328E7;
  address public constant AAVE_STEWARD_INJECTOR = 0x15885A83936EB943e98EeFFb91e9A49040d93993;
  uint96 public constant LINK_AMOUNT = 200 ether;

  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.removeRiskAdmin(AaveV3Ethereum.RISK_STEWARD);
    AaveV3Ethereum.ACL_MANAGER.removeRiskAdmin(AaveV3Ethereum.CAPS_PLUS_RISK_STEWARD);
    AaveV3Ethereum.ACL_MANAGER.removeRiskAdmin(AaveV3Ethereum.FREEZING_STEWARD);

    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD); // manual risk-steward
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(EDGE_RISK_STEWARD);

    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3EthereumAssets.GHO_UNDERLYING, true);

    uint256 linkAmountWithdrawn = AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.LINK_UNDERLYING,
        amount: LINK_AMOUNT
      }),
      address(this)
    );
    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      MiscEthereum.AAVE_CL_ROBOT_OPERATOR,
      linkAmountWithdrawn
    );

    IAaveCLRobotOperator(MiscEthereum.AAVE_CL_ROBOT_OPERATOR).register(
      'Pendle PT DiscountRate AGRS Injector',
      AAVE_STEWARD_INJECTOR,
      '',
      5_000_000,
      linkAmountWithdrawn.toUint96(),
      0,
      ''
    );
  }
}
