// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_Disable_Stable_Borrows_20231104} from './AaveV2Ethereum_Disable_Stable_Borrows_20231104.sol';
import {AaveV3Polygon_Disable_Stable_Borrows_20231104} from './AaveV3Polygon_Disable_Stable_Borrows_20231104.sol';
import {AaveV3Avalanche_Disable_Stable_Borrows_20231104} from './AaveV3Avalanche_Disable_Stable_Borrows_20231104.sol';
import {AaveV3Optimism_Disable_Stable_Borrows_20231104} from './AaveV3Optimism_Disable_Stable_Borrows_20231104.sol';
import {AaveV3Arbitrum_Disable_Stable_Borrows_20231104} from './AaveV3Arbitrum_Disable_Stable_Borrows_20231104.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231104_Multi_Disable_Stable_Borrows/Disable_Stable_Borrows_20231104.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV2Ethereum_Disable_Stable_Borrows_20231104 payload0 = new AaveV2Ethereum_Disable_Stable_Borrows_20231104();

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
 * command: make deploy-ledger contract=src/20231104_Multi_Disable_Stable_Borrows/Disable_Stable_Borrows_20231104.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Polygon_Disable_Stable_Borrows_20231104 payload0 = new AaveV3Polygon_Disable_Stable_Borrows_20231104();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * command: make deploy-ledger contract=src/20231104_Multi_Disable_Stable_Borrows/Disable_Stable_Borrows_20231104.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Avalanche_Disable_Stable_Borrows_20231104 payload0 = new AaveV3Avalanche_Disable_Stable_Borrows_20231104();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Optimism
 * command: make deploy-ledger contract=src/20231104_Multi_Disable_Stable_Borrows/Disable_Stable_Borrows_20231104.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Optimism_Disable_Stable_Borrows_20231104 payload0 = new AaveV3Optimism_Disable_Stable_Borrows_20231104();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Arbitrum
 * command: make deploy-ledger contract=src/20231104_Multi_Disable_Stable_Borrows/Disable_Stable_Borrows_20231104.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Arbitrum_Disable_Stable_Borrows_20231104 payload0 = new AaveV3Arbitrum_Disable_Stable_Borrows_20231104();

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
 * command: make deploy-ledger contract=src/20231104_Multi_Disable_Stable_Borrows/Disable_Stable_Borrows_20231104.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](5);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(0x60b2345a6B7132917151Fc1f30FE46558FEaDE69);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(0xE2a33403eaD139873820da597531f07f65ED0E3c);
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(0xf5aF461B7c21E1B4874409682313Ed0db8583848);
    payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(0x6d4F341d8Bb3Dc5ABe822Aa940F1884508C13f99);
    payloads[3] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(0xa3255CfE96D192dDe036c30b10AF9a29bb358157);
    payloads[4] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231104_Multi_Disable_Stable_Borrows/Disable_Stable_Borrows.md'
      )
    );
  }
}
