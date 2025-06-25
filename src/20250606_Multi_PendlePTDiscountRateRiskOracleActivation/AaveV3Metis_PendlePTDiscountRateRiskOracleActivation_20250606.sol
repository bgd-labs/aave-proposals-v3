// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Metis_PendlePTDiscountRateRiskOracleActivation_20250606 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x97CB9e81d480A2AB03299760654C1DDC0C16bE07;

  function execute() external {
    AaveV3Metis.ACL_MANAGER.removeRiskAdmin(AaveV3Metis.RISK_STEWARD);
    AaveV3Metis.ACL_MANAGER.removeRiskAdmin(AaveV3Metis.CAPS_PLUS_RISK_STEWARD);
    AaveV3Metis.ACL_MANAGER.removeRiskAdmin(AaveV3Metis.FREEZING_STEWARD);

    AaveV3Metis.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
