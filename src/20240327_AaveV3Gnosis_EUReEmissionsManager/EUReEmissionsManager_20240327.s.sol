// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, GnosisScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Gnosis_EUReEmissionsManager_20240327} from './AaveV3Gnosis_EUReEmissionsManager_20240327.sol';

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20240327_AaveV3Gnosis_EUReEmissionsManager/EUReEmissionsManager_20240327.s.sol:DeployGnosis chain=gnosis
 * verify-command: npx catapulta-verify -b broadcast/EUReEmissionsManager_20240327.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_EUReEmissionsManager_20240327).creationCode
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
 * command: make deploy-ledger contract=src/20240327_AaveV3Gnosis_EUReEmissionsManager/EUReEmissionsManager_20240327.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Gnosis_EUReEmissionsManager_20240327).creationCode
    );
    payloads[0] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240327_AaveV3Gnosis_EUReEmissionsManager/EUReEmissionsManager.md'
      )
    );
  }
}
