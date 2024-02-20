// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3_20240206} from './AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3_20240206.sol';

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240206_AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3/MaticXSupplyCapIncreaseInPolygonV3_20240206.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/MaticXSupplyCapIncreaseInPolygonV3_20240206.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3_20240206).creationCode
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
 * command: make deploy-ledger contract=src/20240206_AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3/MaticXSupplyCapIncreaseInPolygonV3_20240206.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3_20240206).creationCode
    );
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240206_AaveV3Polygon_MaticXSupplyCapIncreaseInPolygonV3/MaticXSupplyCapIncreaseInPolygonV3.md'
      )
    );
  }
}
