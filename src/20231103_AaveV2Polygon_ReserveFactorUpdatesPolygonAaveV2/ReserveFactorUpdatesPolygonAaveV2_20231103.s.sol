// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103} from './AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103.sol';

/**
 * @dev Deploy Polygon
 * command: make deploy-ledger contract=src/20231103_AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2/ReserveFactorUpdatesPolygonAaveV2_20231103.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103 payload0 = new AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103();

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
 * command: make deploy-ledger contract=src/20231103_AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2/ReserveFactorUpdatesPolygonAaveV2_20231103.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(0x3aE999AEf88072aC7fB702af1C362f47647962FC);
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231103_AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2/ReserveFactorUpdatesPolygonAaveV2.md'
      )
    );
  }
}
