// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3ZkSync_PendlePTDiscountRateRiskOracleActivation_20250606 is
  IProposalGenericExecutor
{
  address public constant NEW_RISK_STEWARD = 0x528a1036C8450464f8a00A0A8c2f517595E44169;

  function execute() external {
    AaveV3ZkSync.ACL_MANAGER.removeRiskAdmin(AaveV3ZkSync.RISK_STEWARD);
    AaveV3ZkSync.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
  }
}
