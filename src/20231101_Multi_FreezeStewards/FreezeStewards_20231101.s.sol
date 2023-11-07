// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, AvalancheScript, MetisScript, BaseScript} from 'aave-helpers/ScriptUtils.sol';

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231101_Multi_FreezeStewards/FreezeStewards_20231101.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](3);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(0xa3255CfE96D192dDe036c30b10AF9a29bb358157);
    payloads[0] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(0x0f24aF3ea7460E09E33B2e9814Df5856433BE80D);
    payloads[1] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(0x889c0cc3283DB588A34E89Ad1E8F25B0fc827b4b);
    payloads[2] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      payloads,
      GovV3Helpers.ipfsHashFile(vm, 'src/20231101_Multi_FreezeStewards/FreezeStewards.md')
    );
  }
}
