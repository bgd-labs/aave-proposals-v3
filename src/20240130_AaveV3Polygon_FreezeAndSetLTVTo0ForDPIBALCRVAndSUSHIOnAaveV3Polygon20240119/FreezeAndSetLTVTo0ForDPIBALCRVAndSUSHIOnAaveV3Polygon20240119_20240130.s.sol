// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130} from './AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130.sol';

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240130_AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119/FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130)
        .creationCode
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
 * command: make deploy-ledger contract=src/20240130_AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119/FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130)
        .creationCode
    );
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240130_AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119/FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119.md'
      )
    );
  }
}
