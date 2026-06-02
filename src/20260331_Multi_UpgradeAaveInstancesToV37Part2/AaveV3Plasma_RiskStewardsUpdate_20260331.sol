// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Plasma
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Plasma_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xdDE20B20E21a6F3b7080e740b684CDf5b764B80D;

  function execute() external {
    AaveV3Plasma.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Plasma.ACL_MANAGER.removeRiskAdmin(AaveV3Plasma.RISK_STEWARD);
    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3PlasmaAssets.GHO_UNDERLYING, true);
  }
}
