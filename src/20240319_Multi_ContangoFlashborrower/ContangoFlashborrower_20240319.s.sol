// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, BaseScript, AvalancheScript, PolygonScript, MetisScript, GnosisScript, BNBScript, ScrollScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Base_ContangoFlashborrower_20240319} from './AaveV3Base_ContangoFlashborrower_20240319.sol';
import {AaveV3Avalanche_ContangoFlashborrower_20240319} from './AaveV3Avalanche_ContangoFlashborrower_20240319.sol';
import {AaveV3Polygon_ContangoFlashborrower_20240319} from './AaveV3Polygon_ContangoFlashborrower_20240319.sol';
import {AaveV3Gnosis_ContangoFlashborrower_20240319} from './AaveV3Gnosis_ContangoFlashborrower_20240319.sol';
import {AaveV3BNB_ContangoFlashborrower_20240319} from './AaveV3BNB_ContangoFlashborrower_20240319.sol';
import {AaveV3Scroll_ContangoFlashborrower_20240319} from './AaveV3Scroll_ContangoFlashborrower_20240319.sol';

/**
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20240319_Multi_ContangoFlashborrower/ContangoFlashborrower_20240319.s.sol:DeployBase chain=base
 * verify-command: npx catapulta-verify -b broadcast/ContangoFlashborrower_20240319.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_ContangoFlashborrower_20240319).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240319_Multi_ContangoFlashborrower/ContangoFlashborrower_20240319.s.sol:DeployAvalanche chain=avalanche
 * verify-command: npx catapulta-verify -b broadcast/ContangoFlashborrower_20240319.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_ContangoFlashborrower_20240319).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240319_Multi_ContangoFlashborrower/ContangoFlashborrower_20240319.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/ContangoFlashborrower_20240319.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_ContangoFlashborrower_20240319).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240319_Multi_ContangoFlashborrower/ContangoFlashborrower_20240319.s.sol:DeployGnosis chain=gnosis
 * verify-command: npx catapulta-verify -b broadcast/ContangoFlashborrower_20240319.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_ContangoFlashborrower_20240319).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240319_Multi_ContangoFlashborrower/ContangoFlashborrower_20240319.s.sol:DeployBNB chain=bnb
 * verify-command: npx catapulta-verify -b broadcast/ContangoFlashborrower_20240319.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_ContangoFlashborrower_20240319).creationCode
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
 * @dev Deploy Scroll
 * deploy-command: make deploy-ledger contract=src/20240319_Multi_ContangoFlashborrower/ContangoFlashborrower_20240319.s.sol:DeployScroll chain=scroll
 * verify-command: npx catapulta-verify -b broadcast/ContangoFlashborrower_20240319.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Scroll_ContangoFlashborrower_20240319).creationCode
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
 * command: make deploy-ledger contract=src/20240319_Multi_ContangoFlashborrower/ContangoFlashborrower_20240319.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](6);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(AaveV3Base_ContangoFlashborrower_20240319).creationCode
    );
    payloads[0] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      type(AaveV3Avalanche_ContangoFlashborrower_20240319).creationCode
    );
    payloads[1] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_ContangoFlashborrower_20240319).creationCode
    );
    payloads[2] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Gnosis_ContangoFlashborrower_20240319).creationCode
    );
    payloads[3] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(
      type(AaveV3BNB_ContangoFlashborrower_20240319).creationCode
    );
    payloads[4] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(
      type(AaveV3Scroll_ContangoFlashborrower_20240319).creationCode
    );
    payloads[5] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240319_Multi_ContangoFlashborrower/ContangoFlashborrower.md'
      )
    );
  }
}
