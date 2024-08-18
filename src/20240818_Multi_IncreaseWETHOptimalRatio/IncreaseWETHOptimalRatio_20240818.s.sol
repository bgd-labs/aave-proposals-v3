// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, PolygonScript, AvalancheScript, MetisScript, BaseScript, GnosisScript, ScrollScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Polygon_IncreaseWETHOptimalRatio_20240818} from './AaveV3Polygon_IncreaseWETHOptimalRatio_20240818.sol';
import {AaveV3Avalanche_IncreaseWETHOptimalRatio_20240818} from './AaveV3Avalanche_IncreaseWETHOptimalRatio_20240818.sol';
import {AaveV3Metis_IncreaseWETHOptimalRatio_20240818} from './AaveV3Metis_IncreaseWETHOptimalRatio_20240818.sol';
import {AaveV3Base_IncreaseWETHOptimalRatio_20240818} from './AaveV3Base_IncreaseWETHOptimalRatio_20240818.sol';
import {AaveV3Gnosis_IncreaseWETHOptimalRatio_20240818} from './AaveV3Gnosis_IncreaseWETHOptimalRatio_20240818.sol';
import {AaveV3Scroll_IncreaseWETHOptimalRatio_20240818} from './AaveV3Scroll_IncreaseWETHOptimalRatio_20240818.sol';

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240818_Multi_IncreaseWETHOptimalRatio/IncreaseWETHOptimalRatio_20240818.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=polygon npx catapulta-verify -b broadcast/IncreaseWETHOptimalRatio_20240818.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_IncreaseWETHOptimalRatio_20240818).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240818_Multi_IncreaseWETHOptimalRatio/IncreaseWETHOptimalRatio_20240818.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=avalanche npx catapulta-verify -b broadcast/IncreaseWETHOptimalRatio_20240818.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_IncreaseWETHOptimalRatio_20240818).creationCode
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
 * @dev Deploy Metis
 * deploy-command: make deploy-ledger contract=src/20240818_Multi_IncreaseWETHOptimalRatio/IncreaseWETHOptimalRatio_20240818.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=metis npx catapulta-verify -b broadcast/IncreaseWETHOptimalRatio_20240818.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Metis_IncreaseWETHOptimalRatio_20240818).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240818_Multi_IncreaseWETHOptimalRatio/IncreaseWETHOptimalRatio_20240818.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=base npx catapulta-verify -b broadcast/IncreaseWETHOptimalRatio_20240818.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_IncreaseWETHOptimalRatio_20240818).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240818_Multi_IncreaseWETHOptimalRatio/IncreaseWETHOptimalRatio_20240818.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=gnosis npx catapulta-verify -b broadcast/IncreaseWETHOptimalRatio_20240818.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_IncreaseWETHOptimalRatio_20240818).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240818_Multi_IncreaseWETHOptimalRatio/IncreaseWETHOptimalRatio_20240818.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=scroll npx catapulta-verify -b broadcast/IncreaseWETHOptimalRatio_20240818.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Scroll_IncreaseWETHOptimalRatio_20240818).creationCode
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
 * command: make deploy-ledger contract=src/20240818_Multi_IncreaseWETHOptimalRatio/IncreaseWETHOptimalRatio_20240818.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](6);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_IncreaseWETHOptimalRatio_20240818).creationCode
    );
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      type(AaveV3Avalanche_IncreaseWETHOptimalRatio_20240818).creationCode
    );
    payloads[1] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(
      type(AaveV3Metis_IncreaseWETHOptimalRatio_20240818).creationCode
    );
    payloads[2] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(AaveV3Base_IncreaseWETHOptimalRatio_20240818).creationCode
    );
    payloads[3] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Gnosis_IncreaseWETHOptimalRatio_20240818).creationCode
    );
    payloads[4] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(
      type(AaveV3Scroll_IncreaseWETHOptimalRatio_20240818).creationCode
    );
    payloads[5] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240818_Multi_IncreaseWETHOptimalRatio/IncreaseWETHOptimalRatio.md'
      )
    );
  }
}
