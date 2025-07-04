// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import {IRiskSteward} from './interfaces/IRiskSteward.sol';

/**
 * @title Discount Rate Risk Oracle Activation and update manual AGRS
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: Direct To AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/93
 */
contract AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606 is
  IProposalGenericExecutor
{
  address public constant NEW_RISK_STEWARD = 0x365d47ceD3D7Eb6a9bdB3814aA23cc06B2D33Ef8;

  function execute() external {
    AaveV3Arbitrum.ACL_MANAGER.removeRiskAdmin(AaveV3Arbitrum.RISK_STEWARD);
    AaveV3Arbitrum.ACL_MANAGER.removeRiskAdmin(AaveV3Arbitrum.CAPS_PLUS_RISK_STEWARD);
    AaveV3Arbitrum.ACL_MANAGER.removeRiskAdmin(AaveV3Arbitrum.FREEZING_STEWARD);

    AaveV3Arbitrum.ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD);
    IRiskSteward(NEW_RISK_STEWARD).setAddressRestricted(AaveV3ArbitrumAssets.GHO_UNDERLYING, true);
  }
}
