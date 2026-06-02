// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Avalanche
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Avalanche_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x43632469e02CDAaEB4dE3DcBfCAaBEf310975729;

  function execute() external {
    AaveV3Avalanche.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Avalanche.ACL_MANAGER.removeRiskAdmin(AaveV3Avalanche.RISK_STEWARD);

    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3AvalancheAssets.GHO_UNDERLYING, true);
  }
}
