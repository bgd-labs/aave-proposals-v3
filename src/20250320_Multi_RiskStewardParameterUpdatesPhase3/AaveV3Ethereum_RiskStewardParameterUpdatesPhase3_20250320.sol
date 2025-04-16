// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';
import {GetRiskConfig} from './GetRiskConfig.sol';
/**
 * @title Risk Steward Parameter Updates Phase 3
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x29d176e4d36f38c665ac39775577982339c6a3fcc488a36af73fbd5edfd422ff
 * - Discussion: https://governance.aave.com/t/arfc-risk-steward-parameter-updates-phase-3/21135
 */
contract AaveV3Ethereum_RiskStewardParameterUpdatesPhase3_20250320 is IProposalGenericExecutor {
  function execute() external {
    IRiskSteward(AaveV3Ethereum.RISK_STEWARD).setRiskConfig(GetRiskConfig._getRiskConfig());
  }
}
