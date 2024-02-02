// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, ScrollScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Scroll_AaveV3ScrollActivation_20240122} from './AaveV3Scroll_AaveV3ScrollActivation_20240122.sol';

/**
 * @dev Deploy Scroll
 * deploy-command: make deploy-ledger contract=src/20240122_AaveV3Scroll_AaveV3ScrollActivation/AaveV3ScrollActivation_20240122.s.sol:DeployScroll chain=scroll
 * verify-command: npx catapulta-verify -b broadcast/AaveV3ScrollActivation_20240122.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Scroll_AaveV3ScrollActivation_20240122).creationCode
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
 * command: make deploy-ledger contract=src/20240122_AaveV3Scroll_AaveV3ScrollActivation/AaveV3ScrollActivation_20240122.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(
      type(AaveV3Scroll_AaveV3ScrollActivation_20240122).creationCode
    );
    payloads[0] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240122_AaveV3Scroll_AaveV3ScrollActivation/AaveV3ScrollActivation.md'
      )
    );
  }
}
