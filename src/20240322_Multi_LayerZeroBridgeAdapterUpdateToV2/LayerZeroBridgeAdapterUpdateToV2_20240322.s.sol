// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, AvalancheScript, GnosisScript, BNBScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';
import {AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';
import {AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';
import {AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';
import {AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
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
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
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
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol:DeployAvalanche chain=avalanche
 * verify-command: npx catapulta-verify -b broadcast/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
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
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol:DeployGnosis chain=gnosis
 * verify-command: npx catapulta-verify -b broadcast/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
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
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol:DeployBNB chain=bnb
 * verify-command: npx catapulta-verify -b broadcast/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
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
 * command: make deploy-ledger contract=src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/LayerZeroBridgeAdapterUpdateToV2_20240322.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](5);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
    );
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      type(AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
    );
    payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
    );
    payloads[3] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(
      type(AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322).creationCode
    );
    payloads[4] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240322_Multi_LayerZeroBridgeAdapterUpdateToV2/LayerZeroBridgeAdapterUpdateToV2.md'
      )
    );
  }
}
