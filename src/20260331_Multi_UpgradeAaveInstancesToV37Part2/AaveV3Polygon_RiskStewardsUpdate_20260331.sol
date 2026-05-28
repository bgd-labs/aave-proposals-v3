// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Polygon
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Polygon_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x8F3537814430829Ca6760C92859F1A3cE235049A;

  function execute() external {
    AaveV3Polygon.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Polygon.ACL_MANAGER.removeRiskAdmin(AaveV3Polygon.RISK_STEWARD);
  }
}
