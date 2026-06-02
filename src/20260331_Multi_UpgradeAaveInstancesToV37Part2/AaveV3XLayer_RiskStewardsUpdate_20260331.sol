// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3XLayer, AaveV3XLayerAssets} from 'aave-address-book/AaveV3XLayer.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';

/**
 * @title Aave V3.7 RiskSteward Update on XLayer
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3XLayer_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x7D0219C7037819B3F5d73E235C595189C3F8c224;

  function execute() external {
    AaveV3XLayer.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3XLayer.ACL_MANAGER.removeRiskAdmin(AaveV3XLayer.RISK_STEWARD);

    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3XLayerAssets.GHO_UNDERLYING, true);
  }
}
