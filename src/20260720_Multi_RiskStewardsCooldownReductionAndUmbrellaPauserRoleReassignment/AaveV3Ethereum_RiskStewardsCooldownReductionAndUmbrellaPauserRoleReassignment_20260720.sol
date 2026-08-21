// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {UmbrellaEthereum} from 'aave-address-book/UmbrellaEthereum.sol';
import {IUmbrella} from 'aave-address-book/common/IUmbrella.sol';

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {RiskStewardCooldownReduction} from './RiskStewardCooldownReduction.sol';

/**
 * @title Risk Stewards Cooldown Reduction & Umbrella Pauser Role Reassignment
 * @author Llama Risk (implemented by Aave Labs)
 * - Snapshot: https://snapshot.org/#/aavedao.eth/proposal/0x7083921f2f549ffa2cdc294c8ff60fdc82af0becbb7b2f20f4f296c34694aaf2
 * - Discussion: https://governance.aave.com/t/arfc-risk-stewards-cooldown-reduction-umbrella-pauser-role-reassignment/25068
 */
contract AaveV3Ethereum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720 is
  IProposalGenericExecutor
{
  function execute() external {
    RiskStewardCooldownReduction.setRiskStewardMinDelay(AaveV3Ethereum.RISK_STEWARD);

    IUmbrella umbrella = UmbrellaEthereum.UMBRELLA;
    umbrella.grantRole(umbrella.PAUSE_GUARDIAN_ROLE(), MiscEthereum.PROTOCOL_GUARDIAN);
  }
}
