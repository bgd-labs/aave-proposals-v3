// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411} from './AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411.sol';
import {AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411} from './AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240411_Multi_SecurityBudgetRequestDec23AndRobotRefill/SecurityBudgetRequestDec23AndRobotRefill_20240411.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/SecurityBudgetRequestDec23AndRobotRefill_20240411.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240411_Multi_SecurityBudgetRequestDec23AndRobotRefill/SecurityBudgetRequestDec23AndRobotRefill_20240411.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/SecurityBudgetRequestDec23AndRobotRefill_20240411.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411).creationCode
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
 * command: make deploy-ledger contract=src/20240411_Multi_SecurityBudgetRequestDec23AndRobotRefill/SecurityBudgetRequestDec23AndRobotRefill_20240411.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_SecurityBudgetRequestDec23AndRobotRefill_20240411).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_SecurityBudgetRequestDec23AndRobotRefill_20240411).creationCode
    );
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240411_Multi_SecurityBudgetRequestDec23AndRobotRefill/SecurityBudgetRequestDec23AndRobotRefill.md'
      )
    );
  }
}
