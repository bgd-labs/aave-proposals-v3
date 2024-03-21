// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, AvalancheScript, BNBScript, BaseScript, GnosisScript, OptimismScript, ArbitrumScript, MetisScript, ScrollScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Scroll_V3PeripheryMaintenance_20240314} from './AaveV3Scroll_V3PeripheryMaintenance_20240314.sol';

library StataPayloads {
  // https://etherscan.io/address/0xaddb96fb6a795faf042dd25bd4710267c41d1f74#code
  address internal constant MAINNET = 0xAdDb96Fb6A795faf042DD25BD4710267C41D1F74;

  // https://polygonscan.com/address/0x045950811ed7b157158b4316f0e2f04726e3b4fa#code
  address internal constant POLYGON = 0x045950811Ed7B157158B4316F0e2F04726E3b4fa;

  // https://snowtrace.io/address/0x0e26e0bf83b4ec2cb0dcbc037bb01da5bb352eae#code
  address internal constant AVALANCHE = 0x0E26E0bf83b4ec2cb0dcbC037bb01dA5BB352eAE;

  // https://optimistic.etherscan.io/address/0xbe8554762a7a6d4343ea30954e2dbc5c638626a7#code
  address internal constant OPTIMISM = 0xbe8554762a7A6D4343eA30954E2DbC5C638626a7;

  // https://arbiscan.io/address/0xb660d9f9745575b19a09fe0556c1b4c160966a32#code
  address internal constant ARBITRUM = 0xB660d9F9745575B19a09fe0556c1b4C160966a32;

  // https://bscscan.com/address/0x8be473dCfA93132658821E67CbEB684ec8Ea2E74#code
  address internal constant BNB = 0x8be473dCfA93132658821E67CbEB684ec8Ea2E74;

  // https://scrollscan.com/address/0x70bf6ec6fca41a7d08dcbb9909985ac0a4510b5e#code
  address internal constant SCROLL = 0x70Bf6EC6Fca41a7d08dCBB9909985AC0A4510B5E;

  // https://explorer.metis.io/address/0xe427FCbD54169136391cfEDf68E96abB13dA87A0/contract/1088/code
  address internal constant METIS = 0xe427FCbD54169136391cfEDf68E96abB13dA87A0;

  // https://basescan.org/address/0x31a239f3e39c5d8ba6b201ba81ed584492ae960f#code
  address internal constant BASE = 0x31A239f3e39c5D8BA6B201bA81ed584492Ae960F;

  // https://gnosisscan.io/address/0x15196d30bc37d2fc5c718ffcd9d7687d76f3ad1f#code
  address internal constant GNOSIS = 0x15196D30Bc37d2fc5C718ffCd9d7687D76f3Ad1f;
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = StataPayloads.MAINNET;

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
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = StataPayloads.POLYGON;

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
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployAvalanche chain=avalanche
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = StataPayloads.AVALANCHE;

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
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployBNB chain=bnb
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = StataPayloads.BNB;

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
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployBase chain=base
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = StataPayloads.BASE;

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
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployGnosis chain=gnosis
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = StataPayloads.GNOSIS;

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
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployOptimism chain=optimism
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = StataPayloads.OPTIMISM;

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
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = StataPayloads.ARBITRUM;

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
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployMetis chain=metis
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = StataPayloads.METIS;

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
 * deploy-command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:DeployScroll chain=scroll
 * verify-command: npx catapulta-verify -b broadcast/V3PeripheryMaintenance_20240314.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Scroll_V3PeripheryMaintenance_20240314).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(StataPayloads.SCROLL);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance_20240314.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](10);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(StataPayloads.MAINNET);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(StataPayloads.POLYGON);
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(StataPayloads.AVALANCHE);
    payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(StataPayloads.BNB);
    payloads[3] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(StataPayloads.BASE);
    payloads[4] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(StataPayloads.GNOSIS);
    payloads[5] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(StataPayloads.OPTIMISM);
    payloads[6] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(StataPayloads.ARBITRUM);
    payloads[7] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(StataPayloads.METIS);
    payloads[8] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](2);
    actionsScroll[0] = GovV3Helpers.buildAction(
      type(AaveV3Scroll_V3PeripheryMaintenance_20240314).creationCode
    );
    actionsScroll[1] = GovV3Helpers.buildAction(StataPayloads.SCROLL);
    payloads[9] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240314_Multi_V3PeripheryMaintenance/V3PeripheryMaintenance.md'
      )
    );
  }
}
