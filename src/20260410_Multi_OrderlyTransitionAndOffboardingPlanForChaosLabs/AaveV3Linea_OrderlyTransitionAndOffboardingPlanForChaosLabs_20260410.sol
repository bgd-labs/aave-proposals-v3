// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscLinea} from 'aave-address-book/MiscLinea.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {DelistAllAgents} from './DelistAllAgents.sol';
/**
 * @title Orderly Transition and Offboarding Plan for Chaos Labs
 * @author ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3Linea_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410 is
  IProposalGenericExecutor
{
  function execute() external {
    DelistAllAgents.delist(MiscLinea.AGENT_HUB, address(AaveV3Linea.ACL_MANAGER));
  }
}
