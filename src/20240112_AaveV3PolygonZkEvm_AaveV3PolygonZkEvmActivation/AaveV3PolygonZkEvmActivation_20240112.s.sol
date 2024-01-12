// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonZkEvmScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112} from './AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112.sol';

/**
 * @dev Deploy PolygonZkEvm
 * deploy-command: make deploy-ledger contract=src/20240112_AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation/AaveV3PolygonZkEvmActivation_20240112.s.sol:DeployPolygonZkEvm chain=polygonzkevm
 * verify-command: npx catapulta-verify -b broadcast/AaveV3PolygonZkEvmActivation_20240112.s.sol/1101/run-latest.json
 */
contract DeployPolygonZkEvm is PolygonZkEvmScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112).creationCode
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
 * command: make deploy-ledger contract=src/20240112_AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation/AaveV3PolygonZkEvmActivation_20240112.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygonZkEvm = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygonZkEvm[0] = GovV3Helpers.buildAction(
      type(AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation_20240112).creationCode
    );
    payloads[0] = GovV3Helpers.buildPolygonZkEvmPayload(vm, actionsPolygonZkEvm);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240112_AaveV3PolygonZkEvm_AaveV3PolygonZkEvmActivation/AaveV3PolygonZkEvmActivation.md'
      )
    );
  }
}
