// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, GnosisScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_AprilFinanceUpdate_20240421} from './AaveV2Ethereum_AprilFinanceUpdate_20240421.sol';
import {AaveV2Polygon_AprilFinanceUpdate_20240421} from './AaveV2Polygon_AprilFinanceUpdate_20240421.sol';
import {AaveV2Polygon_AprilFinanceUpdate_20240421_PartB} from './AaveV2Polygon_AprilFinanceUpdate_20240421_PartB.sol';
import {AaveV3Gnosis_AprilFinanceUpdate_20240421} from './AaveV3Gnosis_AprilFinanceUpdate_20240421.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240421_Multi_AprilFinanceUpdate/AprilFinanceUpdate_20240421.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/AprilFinanceUpdate_20240421.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV2Ethereum_AprilFinanceUpdate_20240421).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240421_Multi_AprilFinanceUpdate/AprilFinanceUpdate_20240421.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/AprilFinanceUpdate_20240421.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV2Polygon_AprilFinanceUpdate_20240421).creationCode
    );

    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV2Polygon_AprilFinanceUpdate_20240421_PartB).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsTwo = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsTwo[0] = GovV3Helpers.buildAction(payload1);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
    GovV3Helpers.createPayload(actionsTwo);
  }
}

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20240421_Multi_AprilFinanceUpdate/AprilFinanceUpdate_20240421.s.sol:DeployGnosis chain=gnosis
 * verify-command: npx catapulta-verify -b broadcast/AprilFinanceUpdate_20240421.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_AprilFinanceUpdate_20240421).creationCode
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
 * command: make deploy-ledger contract=src/20240421_Multi_AprilFinanceUpdate/AprilFinanceUpdate_20240421.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV2Ethereum_AprilFinanceUpdate_20240421).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV2Polygon_AprilFinanceUpdate_20240421).creationCode
    );
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygonTwo = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygonTwo[0] = GovV3Helpers.buildAction(
      type(AaveV2Polygon_AprilFinanceUpdate_20240421_PartB).creationCode
    );
    payloads[2] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygonTwo);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Gnosis_AprilFinanceUpdate_20240421).creationCode
    );
    payloads[3] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(vm, 'src/20240421_Multi_AprilFinanceUpdate/AprilFinanceUpdate.md')
    );
  }
}
