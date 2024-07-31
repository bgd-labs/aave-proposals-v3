// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, AvalancheScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617} from './AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617.sol';
import {AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617} from './AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617.sol';

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/UpdatePoRExecutorV3Robot_20240617.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=avalanche npx catapulta-verify -b broadcast/UpdatePoRExecutorV3Robot_20240617.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617).creationCode
    );

    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617).creationCode
    );

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload1));
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/UpdatePoRExecutorV3Robot_20240617.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalancheOne = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalancheOne[0] = GovV3Helpers.buildAction(
      type(AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617).creationCode
    );
    payloads[0] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalancheOne);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalancheTwo = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalancheTwo[0] = GovV3Helpers.buildAction(
      type(AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617).creationCode
    );
    payloads[1] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalancheTwo);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/UpdatePoRExecutorV3Robot.md'
      )
    );
  }
}
