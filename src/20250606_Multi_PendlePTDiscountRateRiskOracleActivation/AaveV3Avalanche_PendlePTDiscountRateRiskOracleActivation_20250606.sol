// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Avalanche_PendlePTDiscountRateRiskOracleActivation_20250606 is
  IProposalGenericExecutor
{
  address public constant NEW_RISK_STEWARD = 0x23AceD103f5E22bD22B9272c82f29C0E51abC5c2;

  function execute() external {
    AaveV3Avalanche.ACL_MANAGER.removeRiskAdmin(AaveV3Avalanche.RISK_STEWARD);
    AaveV3Avalanche.ACL_MANAGER.removeRiskAdmin(AaveV3Avalanche.CAPS_PLUS_RISK_STEWARD);
    AaveV3Avalanche.ACL_MANAGER.removeRiskAdmin(AaveV3Avalanche.FREEZING_STEWARD);

    AaveV3Avalanche.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
