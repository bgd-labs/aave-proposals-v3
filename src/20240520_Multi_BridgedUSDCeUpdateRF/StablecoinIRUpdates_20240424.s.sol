// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, AvalancheScript, PolygonScript, OptimismScript, ArbitrumScript, BaseScript, GnosisScript, ScrollScript, BNBScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_StablecoinIRUpdates_20240424} from './AaveV2Ethereum_StablecoinIRUpdates_20240424.sol';
import {AaveV2Avalanche_StablecoinIRUpdates_20240424} from './AaveV2Avalanche_StablecoinIRUpdates_20240424.sol';
import {AaveV3Ethereum_StablecoinIRUpdates_20240424} from './AaveV3Ethereum_StablecoinIRUpdates_20240424.sol';
import {AaveV3Polygon_StablecoinIRUpdates_20240424} from './AaveV3Polygon_StablecoinIRUpdates_20240424.sol';
import {AaveV3Avalanche_StablecoinIRUpdates_20240424} from './AaveV3Avalanche_StablecoinIRUpdates_20240424.sol';
import {AaveV3Optimism_StablecoinIRUpdates_20240424} from './AaveV3Optimism_StablecoinIRUpdates_20240424.sol';
import {AaveV3Arbitrum_StablecoinIRUpdates_20240424} from './AaveV3Arbitrum_StablecoinIRUpdates_20240424.sol';
import {AaveV3Base_StablecoinIRUpdates_20240424} from './AaveV3Base_StablecoinIRUpdates_20240424.sol';
import {AaveV3Gnosis_StablecoinIRUpdates_20240424} from './AaveV3Gnosis_StablecoinIRUpdates_20240424.sol';
import {AaveV3Scroll_StablecoinIRUpdates_20240424} from './AaveV3Scroll_StablecoinIRUpdates_20240424.sol';
import {AaveV3BNB_StablecoinIRUpdates_20240424} from './AaveV3BNB_StablecoinIRUpdates_20240424.sol';

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240424_Multi_StablecoinIRUpdates/StablecoinIRUpdates_20240424.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/StablecoinIRUpdates_20240424.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_StablecoinIRUpdates_20240424).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240424_Multi_StablecoinIRUpdates/StablecoinIRUpdates_20240424.s.sol:DeployOptimism chain=optimism
 * verify-command: npx catapulta-verify -b broadcast/StablecoinIRUpdates_20240424.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_StablecoinIRUpdates_20240424).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240424_Multi_StablecoinIRUpdates/StablecoinIRUpdates_20240424.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: npx catapulta-verify -b broadcast/StablecoinIRUpdates_20240424.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_StablecoinIRUpdates_20240424).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20240424_Multi_StablecoinIRUpdates/StablecoinIRUpdates_20240424.s.sol:DeployBase chain=base
 * verify-command: npx catapulta-verify -b broadcast/StablecoinIRUpdates_20240424.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_StablecoinIRUpdates_20240424).creationCode
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
 * command: make deploy-ledger contract=src/20240424_Multi_StablecoinIRUpdates/StablecoinIRUpdates_20240424.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_StablecoinIRUpdates_20240424).creationCode
    );
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(
      type(AaveV3Optimism_StablecoinIRUpdates_20240424).creationCode
    );
    payloads[1] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_StablecoinIRUpdates_20240424).creationCode
    );
    payloads[2] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(AaveV3Base_StablecoinIRUpdates_20240424).creationCode
    );
    payloads[3] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(vm, 'src/20240424_Multi_StablecoinIRUpdates/StablecoinIRUpdates.md')
    );
  }
}
