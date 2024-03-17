// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {ArbitrumScript, EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Arbitrum_ARBRemoveIsolation_20240315} from './AaveV3Arbitrum_ARBRemoveIsolation_20240315.sol';

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/src/20240315_AaveV3Arbitrum_ARBRemoveIsolation/AaveV3Arbitrum_ARBRemoveIsolation_20240315.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: npx catapulta-verify -b broadcast/AaveV3Arbitrum_ARBRemoveIsolation_20240315.s.sol/1/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_ARBRemoveIsolation_20240315).creationCode
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
 * command: make deploy-ledger contract=src/20240315_AaveV3Arbitrum_ARBRemoveIsolation/AaveV3Arbitrum_ARBRemoveIsolation_20240315.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_ARBRemoveIsolation_20240315).creationCode
    );
    payloads[0] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240315_AaveV3Arbitrum_ARBRemoveIsolation/ARBRemoveIsolation.md'
      )
    );
  }
}
