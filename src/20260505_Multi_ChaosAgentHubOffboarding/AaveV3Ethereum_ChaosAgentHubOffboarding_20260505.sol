// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IACLManager} from 'aave-address-book/AaveV3.sol';
import {IAgentHub} from '../interfaces/chaos-agents/IAgentHub.sol';
/**
 * @title Chaos AgentHub Offboarding
 * @author Aave Labs
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/orderly-transition-and-offboarding-plan-for-chaos-labs/24399
 */
contract AaveV3Ethereum_ChaosAgentHubOffboarding_20260505 is IProposalGenericExecutor {
  uint256 public constant PREVIOUS_STREAM = 100073;

  function execute() external {
    uint256 agentCount = IAgentHub(MiscEthereum.AGENT_HUB).getAgentCount();
    for (uint256 i = 0; i < agentCount; i++) {
      IAgentHub(MiscEthereum.AGENT_HUB).setAgentEnabled(i, false);
      address agent = IAgentHub(MiscEthereum.AGENT_HUB).getAgentAddress(i);
      IACLManager(AaveV3Ethereum.ACL_MANAGER).removeRiskAdmin(agent);
      IACLManager(AaveV3EthereumLido.ACL_MANAGER).removeRiskAdmin(agent);
    }

    // we try to cancel the stream if not done already
    try AaveV3EthereumLido.COLLECTOR.cancelStream(PREVIOUS_STREAM) {} catch {
      // stream may already be cancelled, ignore failure
    }
  }
}
