// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Base
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Base_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x494bcfd3937aBdebEF3D2c2eae1CE8A2Fb629032;

  function execute() external {
    AaveV3Base.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Base.ACL_MANAGER.removeRiskAdmin(AaveV3Base.RISK_STEWARD);

    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3BaseAssets.GHO_UNDERLYING, true);
  }
}
