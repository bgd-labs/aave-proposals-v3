// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, GnosisScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Gnosis_AaveV3GnosisActivation_20231026} from './AaveV3Gnosis_AaveV3GnosisActivation_20231026.sol';

/**
 * @dev Deploy Gnosis
 * command: make deploy-ledger contract=src/20231026_AaveV3Gnosis_AaveV3GnosisActivation/AaveV3GnosisActivation_20231026.s.sol:DeployGnosis chain=gnosis
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Gnosis_AaveV3GnosisActivation_20231026 payload0 = new AaveV3Gnosis_AaveV3GnosisActivation_20231026();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231026_AaveV3Gnosis_AaveV3GnosisActivation/AaveV3GnosisActivation_20231026.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(0x6Cf806CF51749bE514B7055b6fDBe346aee47B7b);
    payloads[0] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231026_AaveV3Gnosis_AaveV3GnosisActivation/AaveV3GnosisActivation.md'
      )
    );
  }
}
