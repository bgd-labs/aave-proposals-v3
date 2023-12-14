// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, GnosisScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213} from './AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213.sol';

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20231213_AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool/UpdateGNORiskParametersOnAaveV3GnosisPool_20231213.s.sol:DeployGnosis chain=gnosis
 * verify-command: npx catapulta-verify -b broadcast/UpdateGNORiskParametersOnAaveV3GnosisPool_20231213.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213).creationCode
    );

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
 * command: make deploy-ledger contract=src/20231213_AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool/UpdateGNORiskParametersOnAaveV3GnosisPool_20231213.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213).creationCode
    );
    payloads[0] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231213_AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool/UpdateGNORiskParametersOnAaveV3GnosisPool.md'
      )
    );
  }
}
