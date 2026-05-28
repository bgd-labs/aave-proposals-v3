// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Gnosis
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Gnosis_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xd7f6CbA78FcE1799C29460765c97D7792eeD0756;

  function execute() external {
    AaveV3Gnosis.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Gnosis.ACL_MANAGER.removeRiskAdmin(AaveV3Gnosis.RISK_STEWARD);

    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3GnosisAssets.GHO_UNDERLYING, true);
  }
}
