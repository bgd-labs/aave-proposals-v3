// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';

/**
 * @title Aave V3.7 RiskSteward Update on Linea
 * @author BGD Labs @bgdlabs
 * - Discussion: https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075
 */
contract AaveV3Linea_RiskStewardsUpdate_20260331 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xE77aF99210AC55939e1ba0bFC6A9a20E1Da73b25;

  function execute() external {
    AaveV3Linea.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    AaveV3Linea.ACL_MANAGER.removeRiskAdmin(AaveV3Linea.RISK_STEWARD);
  }
}
