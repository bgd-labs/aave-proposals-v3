// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, PolygonScript, OptimismScript, ArbitrumScript, GnosisScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Polygon_ChaosLabsRiskParameterUpdatesAaveV3_20240530} from './AaveV3Polygon_ChaosLabsRiskParameterUpdatesAaveV3_20240530.sol';
import {AaveV3Optimism_ChaosLabsRiskParameterUpdatesAaveV3_20240530} from './AaveV3Optimism_ChaosLabsRiskParameterUpdatesAaveV3_20240530.sol';
import {AaveV3Arbitrum_ChaosLabsRiskParameterUpdatesAaveV3_20240530} from './AaveV3Arbitrum_ChaosLabsRiskParameterUpdatesAaveV3_20240530.sol';
import {AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530} from './AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530.sol';

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/ChaosLabsRiskParameterUpdatesAaveV3_20240530.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=polygon npx catapulta-verify -b broadcast/ChaosLabsRiskParameterUpdatesAaveV3_20240530.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_ChaosLabsRiskParameterUpdatesAaveV3_20240530).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/ChaosLabsRiskParameterUpdatesAaveV3_20240530.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=optimism npx catapulta-verify -b broadcast/ChaosLabsRiskParameterUpdatesAaveV3_20240530.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_ChaosLabsRiskParameterUpdatesAaveV3_20240530).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/ChaosLabsRiskParameterUpdatesAaveV3_20240530.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=arbitrum npx catapulta-verify -b broadcast/ChaosLabsRiskParameterUpdatesAaveV3_20240530.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_ChaosLabsRiskParameterUpdatesAaveV3_20240530).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/ChaosLabsRiskParameterUpdatesAaveV3_20240530.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=gnosis npx catapulta-verify -b broadcast/ChaosLabsRiskParameterUpdatesAaveV3_20240530.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530).creationCode
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
 * command: make deploy-ledger contract=src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/ChaosLabsRiskParameterUpdatesAaveV3_20240530.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_ChaosLabsRiskParameterUpdatesAaveV3_20240530).creationCode
    );
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(
      type(AaveV3Optimism_ChaosLabsRiskParameterUpdatesAaveV3_20240530).creationCode
    );
    payloads[1] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_ChaosLabsRiskParameterUpdatesAaveV3_20240530).creationCode
    );
    payloads[2] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530).creationCode
    );
    payloads[3] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/ChaosLabsRiskParameterUpdatesAaveV3.md'
      )
    );
  }
}
