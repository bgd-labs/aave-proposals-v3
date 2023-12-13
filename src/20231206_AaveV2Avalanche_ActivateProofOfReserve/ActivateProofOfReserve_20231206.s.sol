// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, AvalancheScript, Create2Utils} from 'aave-helpers/ScriptUtils.sol';

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20231206_AaveV2Avalanche_ActivateProofOfReserve/ActivateProofOfReserve_20231206.s.sol:DeployAvalanche chain=avalanche
 * verify-command: npx catapulta-verify -b broadcast/ActivateProofOfReserve_20231206.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  address constant payload = 0xE3Ce388aaA268781B34A6ad5b87d81e81E52f3f4;

  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231206_AaveV2Avalanche_ActivateProofOfReserve/ActivateProofOfReserve_20231206.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  address constant payload = 0xE3Ce388aaA268781B34A6ad5b87d81e81E52f3f4;

  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      address(0xE3Ce388aaA268781B34A6ad5b87d81e81E52f3f4)
    );

    payloads[0] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231206_AaveV2Avalanche_ActivateProofOfReserve/ActivateProofOfReserveV2.md'
      )
    );
  }
}
