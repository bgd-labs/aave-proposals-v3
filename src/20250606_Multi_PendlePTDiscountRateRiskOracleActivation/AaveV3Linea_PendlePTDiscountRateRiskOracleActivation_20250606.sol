// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Linea_PendlePTDiscountRateRiskOracleActivation_20250606 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0xBDF2e1A49894A306Eb76b89504928b3f509A3a16;

  function execute() external {
    AaveV3Linea.ACL_MANAGER.removeRiskAdmin(AaveV3Linea.RISK_STEWARD);
    AaveV3Linea.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
