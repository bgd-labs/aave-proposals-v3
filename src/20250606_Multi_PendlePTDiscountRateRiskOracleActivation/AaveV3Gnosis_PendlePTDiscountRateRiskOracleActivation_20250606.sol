// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606 is
  IProposalGenericExecutor
{
  address public constant NEW_RISK_STEWARD = 0x1AA25FdD7d55FA8a401D6EFba8e48874Ef730E55;

  function execute() external {
    AaveV3Gnosis.ACL_MANAGER.removeRiskAdmin(AaveV3Gnosis.RISK_STEWARD);
    AaveV3Gnosis.ACL_MANAGER.removeRiskAdmin(AaveV3Gnosis.CAPS_PLUS_RISK_STEWARD);
    AaveV3Gnosis.ACL_MANAGER.removeRiskAdmin(AaveV3Gnosis.FREEZING_STEWARD);

    AaveV3Gnosis.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
