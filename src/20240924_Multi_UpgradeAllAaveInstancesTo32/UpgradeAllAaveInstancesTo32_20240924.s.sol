// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript, ScrollScript, BNBScript, ChainIds} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924} from './AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924.sol';

library Payloads {
  address internal constant POLYGON = 0x78DFB8b12bbCc65f415284f3C1ffA412678a725d;
  address internal constant GNOSIS = 0xe427FCbD54169136391cfEDf68E96abB13dA87A0;
  address internal constant OPTIMISM = 0x09B5429d2c70b31379dAfAdC3F0fa015306a8d04;
  address internal constant ARBITRUM = 0xAdDb96Fb6A795faf042DD25BD4710267C41D1F74;
  address internal constant AVALANCHE = 0x09262648Fce84992B68AbF216BfC47731F154462;
  address internal constant BASE = 0x84B08568906ee891de1c23175E5B92d7Df7DDCc4;
  address internal constant SCROLL = 0x89654c66A6abd7174b525D05C2f4c442a615cee8;
  address internal constant BNB = 0xe88fb4EAf67Ea87BB458e24C94BEf0EB02b5F449;
  address internal constant PROTO = 0xb08c48659d6035698B0f1a61deA9C14a59f89622;
  address internal constant ZKSYNC = 0x9c0429dC6a8aA591B4d8bA0f3724987F5fB118E6;
  address internal constant METIS = 0x84B08568906ee891de1c23175E5B92d7Df7DDCc4;
  address internal constant LIDO = 0xf519083f06D2cD0Aa6dd780f0D06b2987a77F290;
  address internal constant ETHERFI = 0x4E48C38a08388c29d9b71c657367e0D0cEf3A790;
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    address payload4 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](4);
    actions[0] = GovV3Helpers.buildAction(Payloads.PROTO);
    actions[1] = GovV3Helpers.buildAction(Payloads.LIDO);
    actions[2] = GovV3Helpers.buildAction(Payloads.ETHERFI);
    actions[3] = GovV3Helpers.buildAction(payload4);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=polygon npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.POLYGON);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=avalanche npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.AVALANCHE);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=optimism npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.OPTIMISM);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=arbitrum npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.ARBITRUM);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Metis
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=metis npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.METIS);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=base npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.BASE);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=gnosis npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.GNOSIS);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Scroll
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=scroll npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.SCROLL);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=bnb npx catapulta-verify -b broadcast/UpgradeAllAaveInstancesTo32_20240924.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.BNB);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32_20240924.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](11);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](4);
    actionsEthereum[0] = GovV3Helpers.buildAction(Payloads.PROTO);
    actionsEthereum[1] = GovV3Helpers.buildAction(Payloads.LIDO);
    actionsEthereum[2] = GovV3Helpers.buildAction(Payloads.ETHERFI);
    actionsEthereum[3] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_UpgradeAllAaveInstancesTo32_20240924).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(Payloads.POLYGON);
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(Payloads.AVALANCHE);
    payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(Payloads.OPTIMISM);
    payloads[3] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(Payloads.ARBITRUM);
    payloads[4] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(Payloads.METIS);
    payloads[5] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(Payloads.BASE);
    payloads[6] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(Payloads.GNOSIS);
    payloads[7] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(Payloads.SCROLL);
    payloads[8] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(Payloads.BNB);
    payloads[9] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    payloads[10] = PayloadsControllerUtils.Payload({
      chain: ChainIds.ZKSYNC,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
      payloadId: 6
    });

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240924_Multi_UpgradeAllAaveInstancesTo32/UpgradeAllAaveInstancesTo32.md'
      )
    );
  }
}
