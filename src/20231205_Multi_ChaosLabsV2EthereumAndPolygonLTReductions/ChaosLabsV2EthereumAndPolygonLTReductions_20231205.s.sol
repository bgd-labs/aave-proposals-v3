// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_ChaosLabsV2EthereumAndPolygonLTReductions_20231205} from './AaveV2Ethereum_ChaosLabsV2EthereumAndPolygonLTReductions_20231205.sol';
import {AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205} from './AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231205_Multi_ChaosLabsV2EthereumAndPolygonLTReductions/ChaosLabsV2EthereumAndPolygonLTReductions_20231205.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV2Ethereum_ChaosLabsV2EthereumAndPolygonLTReductions_20231205 payload0 = new AaveV2Ethereum_ChaosLabsV2EthereumAndPolygonLTReductions_20231205();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * command: make deploy-ledger contract=src/20231205_Multi_ChaosLabsV2EthereumAndPolygonLTReductions/ChaosLabsV2EthereumAndPolygonLTReductions_20231205.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205 payload0 = new AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205();

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
 * command: make deploy-ledger contract=src/20231205_Multi_ChaosLabsV2EthereumAndPolygonLTReductions/ChaosLabsV2EthereumAndPolygonLTReductions_20231205.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(0x41b08a9C1dddBfdBFBb46973A17f76FF06A7d3D6);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(0xf64C196f2Cd0D00D280140a138674EFbacE18572);
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231205_Multi_ChaosLabsV2EthereumAndPolygonLTReductions/ChaosLabsV2EthereumAndPolygonLTReductions.md'
      )
    );
  }
}
