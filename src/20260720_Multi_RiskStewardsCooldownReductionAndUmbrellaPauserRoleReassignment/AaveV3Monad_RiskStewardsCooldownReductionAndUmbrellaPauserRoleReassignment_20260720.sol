// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {RiskStewardCooldownReduction} from './RiskStewardCooldownReduction.sol';

/**
 * @title Risk Stewards Cooldown Reduction & Umbrella Pauser Role Reassignment
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2
 * - Discussion: https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068
 */
contract AaveV3Monad_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720 is
  IProposalGenericExecutor
{
  function execute() external {
    RiskStewardCooldownReduction.setRiskStewardMinDelay(AaveV3Monad.RISK_STEWARD);
  }
}
