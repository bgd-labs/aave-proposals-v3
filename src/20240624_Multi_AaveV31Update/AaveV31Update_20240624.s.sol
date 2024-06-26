// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript, ScrollScript, BNBScript} from 'aave-helpers/ScriptUtils.sol';

library Payloads {
  address public constant AaveV3Ethereum = 0x4D9BDcA8978b7b6EBa62815B8529Aa8a10fac4a4;
  address public constant AaveV3Polygon = 0xC563b2c1600CFf529A0C1241DAa3364Cb27eDE0F;
  address public constant AaveV3Avalanche = 0x7C521cE62971AE63aae01352bA7Dc2EC10d06D20;
  address public constant AaveV3Optimism = 0x6134F654EddA20eaCCe3Ac49953EE74A8fF5c735;
  address public constant AaveV3Arbitrum = 0x6134F654EddA20eaCCe3Ac49953EE74A8fF5c735;
  address public constant AaveV3Metis = address(0);
  address public constant AaveV3Base = 0x7a43bc8f885A12565610fa619e8d82FFDebc24a7;
  address public constant AaveV3Gnosis = 0x50dEC67723575bC037E9957a4d582CB7616eB01F;
  address public constant AaveV3Scroll = 0xF826087F0511C45aD6A9f4b5245bcb25B524cd43;
  address public constant AaveV3BNB = 0x0abBFea3e6921B405Cb205648bff1236bbfA316A;
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3Ethereum;

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=polygon npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3Polygon;

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
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=avalanche npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3Avalanche;

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
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=optimism npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3Optimism;

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
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=arbitrum npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3Arbitrum;

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
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=metis npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3Metis;

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
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=base npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3Base;

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
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=gnosis npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3Gnosis;

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
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=scroll npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3Scroll;

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=bnb npx catapulta-verify -b broadcast/AaveV31Update_20240624.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Payloads.AaveV3BNB;

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
 * command: make deploy-ledger contract=src/20240624_Multi_AaveV31Update/AaveV31Update_20240624.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](10);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(Payloads.AaveV3Ethereum);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(Payloads.AaveV3Polygon);
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(Payloads.AaveV3Avalanche);
    payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(Payloads.AaveV3Optimism);
    payloads[3] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(Payloads.AaveV3Arbitrum);
    payloads[4] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(Payloads.AaveV3Metis);
    payloads[5] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(Payloads.AaveV3Base);
    payloads[6] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(Payloads.AaveV3Gnosis);
    payloads[7] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(Payloads.AaveV3Scroll);
    payloads[8] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(Payloads.AaveV3BNB);
    payloads[9] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(vm, 'src/20240624_Multi_AaveV31Update/AaveV31Update.md')
    );
  }
}
