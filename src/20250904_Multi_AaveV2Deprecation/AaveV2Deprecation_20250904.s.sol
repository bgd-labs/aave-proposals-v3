// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';

import {EthereumScript, PolygonScript, AvalancheScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

import {ClinicStewardV2Activation_20250904} from './ClinicStewardV2Activation_20250904.sol';

import {AaveV2DeprecationPayloadDeployments, ClinicStewardV2Deployments} from './Deployments.sol';

address constant BOT = 0x9148eCDA02859142D06B1591a4C2d6702d4C214D;

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250904_Multi_AaveV2Deprecation/AaveV2Deprecation_20250904.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV2Deprecation_20250904.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = AaveV2DeprecationPayloadDeployments.MAINNET_CORE;
    address payload1 = AaveV2DeprecationPayloadDeployments.MAINNET_AMM;
    address payload2 = GovV3Helpers.deployDeterministic(
      type(ClinicStewardV2Activation_20250904).creationCode,
      abi.encode(AaveV2Ethereum.COLLECTOR, ClinicStewardV2Deployments.MAINNET_CORE, BOT)
    );
    address payload3 = GovV3Helpers.deployDeterministic(
      type(ClinicStewardV2Activation_20250904).creationCode,
      abi.encode(AaveV2EthereumAMM.COLLECTOR, ClinicStewardV2Deployments.MAINNET_AMM, BOT)
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](4);
    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(payload1);
    actions[2] = GovV3Helpers.buildAction(payload2);
    actions[3] = GovV3Helpers.buildAction(payload3);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20250904_Multi_AaveV2Deprecation/AaveV2Deprecation_20250904.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV2Deprecation_20250904.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = AaveV2DeprecationPayloadDeployments.POLYGON;
    address payload1 = GovV3Helpers.deployDeterministic(
      type(ClinicStewardV2Activation_20250904).creationCode,
      abi.encode(AaveV2Polygon.COLLECTOR, ClinicStewardV2Deployments.POLYGON, BOT)
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(payload1);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20250904_Multi_AaveV2Deprecation/AaveV2Deprecation_20250904.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV2Deprecation_20250904.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = AaveV2DeprecationPayloadDeployments.AVALANCHE;
    address payload1 = GovV3Helpers.deployDeterministic(
      type(ClinicStewardV2Activation_20250904).creationCode,
      abi.encode(AaveV2Avalanche.COLLECTOR, ClinicStewardV2Deployments.AVALANCHE, BOT)
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(payload1);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20250904_Multi_AaveV2Deprecation/AaveV2Deprecation_20250904.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](3);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](4);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        AaveV2DeprecationPayloadDeployments.MAINNET_CORE
      );
      actionsEthereum[1] = GovV3Helpers.buildAction(
        AaveV2DeprecationPayloadDeployments.MAINNET_AMM
      );
      actionsEthereum[2] = GovV3Helpers.buildAction(
        type(ClinicStewardV2Activation_20250904).creationCode,
        abi.encode(AaveV2Ethereum.COLLECTOR, ClinicStewardV2Deployments.MAINNET_CORE, BOT)
      );
      actionsEthereum[3] = GovV3Helpers.buildAction(
        type(ClinicStewardV2Activation_20250904).creationCode,
        abi.encode(AaveV2EthereumAMM.COLLECTOR, ClinicStewardV2Deployments.MAINNET_AMM, BOT)
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsPolygon[0] = GovV3Helpers.buildAction(AaveV2DeprecationPayloadDeployments.POLYGON);
      actionsPolygon[1] = GovV3Helpers.buildAction(
        type(ClinicStewardV2Activation_20250904).creationCode,
        abi.encode(AaveV2Polygon.COLLECTOR, ClinicStewardV2Deployments.POLYGON, BOT)
      );
      payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsAvalanche[0] = GovV3Helpers.buildAction(AaveV2DeprecationPayloadDeployments.AVALANCHE);
      actionsAvalanche[1] = GovV3Helpers.buildAction(
        type(ClinicStewardV2Activation_20250904).creationCode,
        abi.encode(AaveV2Avalanche.COLLECTOR, ClinicStewardV2Deployments.AVALANCHE, BOT)
      );
      payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(vm, 'src/20250904_Multi_AaveV2Deprecation/AaveV2Deprecation.md')
    );
  }
}
