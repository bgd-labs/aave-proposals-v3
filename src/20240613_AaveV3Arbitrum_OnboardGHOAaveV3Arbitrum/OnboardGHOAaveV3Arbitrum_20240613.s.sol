// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Arbitrum_OnboardGHOAaveV3Arbitrum_20240613} from './AaveV3Arbitrum_OnboardGHOAaveV3Arbitrum_20240613.sol';

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20240613_AaveV3Arbitrum_OnboardGHOAaveV3Arbitrum/OnboardGHOAaveV3Arbitrum_20240613.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=arbitrum npx catapulta-verify -b broadcast/OnboardGHOAaveV3Arbitrum_20240613.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_OnboardGHOAaveV3Arbitrum_20240613).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240613_AaveV3Arbitrum_OnboardGHOAaveV3Arbitrum/OnboardGHOAaveV3Arbitrum_20240613.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_OnboardGHOAaveV3Arbitrum_20240613).creationCode
    );
    payloads[0] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240613_AaveV3Arbitrum_OnboardGHOAaveV3Arbitrum/OnboardGHOAaveV3Arbitrum.md'
      )
    );
  }
}
