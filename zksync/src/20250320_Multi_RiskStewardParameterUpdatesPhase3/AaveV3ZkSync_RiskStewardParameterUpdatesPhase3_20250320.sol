// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {IRiskSteward} from '../../../src/interfaces/IRiskSteward.sol';
import {GetRiskConfig} from '../../../src/20250320_Multi_RiskStewardParameterUpdatesPhase3/GetRiskConfig.sol';

/**
 * @title Risk Steward Parameter Updates Phase 3
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x29d176e4d36f38c665ac39775577982339c6a3fcc488a36af73fbd5edfd422ff
 * - Discussion: https://governance.aave.com/t/arfc-risk-steward-parameter-updates-phase-3/21135
 */
contract AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320 is IProposalGenericExecutor {
  function execute() external {
    // custom code goes here
    IRiskSteward(AaveV3ZkSync.RISK_STEWARD).setRiskConfig(GetRiskConfig._getRiskConfig());
  }
}
