// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, BaseScript, GnosisScript, ScrollScript, ChainIds} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV2Ethereum_ConfigurationMaintenance_20250519} from './AaveV2Ethereum_ConfigurationMaintenance_20250519.sol';
import {AaveV3Ethereum_ConfigurationMaintenance_20250519} from './AaveV3Ethereum_ConfigurationMaintenance_20250519.sol';
import {AaveV3Polygon_ConfigurationMaintenance_20250519} from './AaveV3Polygon_ConfigurationMaintenance_20250519.sol';
import {AaveV3Avalanche_ConfigurationMaintenance_20250519} from './AaveV3Avalanche_ConfigurationMaintenance_20250519.sol';
import {AaveV3Optimism_ConfigurationMaintenance_20250519} from './AaveV3Optimism_ConfigurationMaintenance_20250519.sol';
import {AaveV3Arbitrum_ConfigurationMaintenance_20250519} from './AaveV3Arbitrum_ConfigurationMaintenance_20250519.sol';
import {AaveV3Base_ConfigurationMaintenance_20250519} from './AaveV3Base_ConfigurationMaintenance_20250519.sol';
import {AaveV3Gnosis_ConfigurationMaintenance_20250519} from './AaveV3Gnosis_ConfigurationMaintenance_20250519.sol';
import {AaveV3Scroll_ConfigurationMaintenance_20250519} from './AaveV3Scroll_ConfigurationMaintenance_20250519.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance_20250519.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ConfigurationMaintenance_20250519.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV2Ethereum_ConfigurationMaintenance_20250519).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_ConfigurationMaintenance_20250519).creationCode
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
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance_20250519.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ConfigurationMaintenance_20250519.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_ConfigurationMaintenance_20250519).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance_20250519.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ConfigurationMaintenance_20250519.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_ConfigurationMaintenance_20250519).creationCode
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
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance_20250519.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ConfigurationMaintenance_20250519.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_ConfigurationMaintenance_20250519).creationCode
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
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance_20250519.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ConfigurationMaintenance_20250519.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_ConfigurationMaintenance_20250519).creationCode
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
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance_20250519.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ConfigurationMaintenance_20250519.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_ConfigurationMaintenance_20250519).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance_20250519.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ConfigurationMaintenance_20250519.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_ConfigurationMaintenance_20250519).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance_20250519.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/ConfigurationMaintenance_20250519.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Scroll_ConfigurationMaintenance_20250519).creationCode
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
 * command: make deploy-ledger contract=src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance_20250519.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](9);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](2);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV2Ethereum_ConfigurationMaintenance_20250519).creationCode
    );
    actionsEthereum[1] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_ConfigurationMaintenance_20250519).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_ConfigurationMaintenance_20250519).creationCode
    );
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      type(AaveV3Avalanche_ConfigurationMaintenance_20250519).creationCode
    );
    payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(
      type(AaveV3Optimism_ConfigurationMaintenance_20250519).creationCode
    );
    payloads[3] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_ConfigurationMaintenance_20250519).creationCode
    );
    payloads[4] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(AaveV3Base_ConfigurationMaintenance_20250519).creationCode
    );
    payloads[5] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Gnosis_ConfigurationMaintenance_20250519).creationCode
    );
    payloads[6] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(
      type(AaveV3Scroll_ConfigurationMaintenance_20250519).creationCode
    );
    payloads[7] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    payloads[8] = PayloadsControllerUtils.Payload({
      chain: ChainIds.ZKSYNC,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
      payloadId: 24
    });

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250519_Multi_ConfigurationMaintenance/ConfigurationMaintenance.md'
      )
    );
  }
}
