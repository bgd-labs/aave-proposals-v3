// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3BNB_PendlePTDiscountRateRiskOracleActivation_20250606 is IProposalGenericExecutor {
  address public constant NEW_RISK_STEWARD = 0x87F4aDD5425f566F156af5074BaD2dFFCd20C594;

  function execute() external {
    AaveV3BNB.ACL_MANAGER.removeRiskAdmin(AaveV3BNB.RISK_STEWARD);
    AaveV3BNB.ACL_MANAGER.removeRiskAdmin(AaveV3BNB.CAPS_PLUS_RISK_STEWARD);
    AaveV3BNB.ACL_MANAGER.removeRiskAdmin(AaveV3BNB.FREEZING_STEWARD);

    AaveV3BNB.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
