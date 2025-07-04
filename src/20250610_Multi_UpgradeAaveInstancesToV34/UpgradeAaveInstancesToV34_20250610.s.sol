// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {ChainIds, EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript, ScrollScript, BNBScript, LineaScript, CeloScript, SonicScript, SoneiumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AuditReimbursement} from './AuditReimbursement.sol';

library Deployments {
  address public constant BASE = 0x41d7188B68A6b334071DB5A1D33Ce4b9109899B3;
  address public constant GNOSIS = 0x6f6A25C4D03EdA3800863522d1340954021046F5;
  address public constant POLYGON = 0x864fe2B34b6066e3D14FC1FB460Faf2B1b069d64;
  address public constant ARBITRUM = 0x8B5Ff77430E2c7e5f46ACD1318c0b5b5d43ef379;
  address public constant OPTIMISM = 0xB8a29caf8Cd73Db3CDA8f294b2a0d2933C2fc62f;
  address public constant AVALANCHE = 0xcD21f2532d3c8AcAACC5217F50d5be4F611bbC12;
  address public constant SONIC = 0xF90c3AB36F17574F2A490e9D98b0B5301332BBFa;
  address public constant METIS = 0xf527fF293EA12320E5246B2668937D0A694EA46D;
  address public constant BNB = 0xFA6a2793c50fD498ff8d53510d6EFfB66C7A03C4;
  address public constant CELO = 0x1E2a398AAe0FF798953603f774aC1143EA0ba545;
  address public constant SCROLL = 0x5914AB024e4D730886ad2f2aF8790C466b0c2868;
  address public constant LINEA = 0xe3DE4BA75c667b86FC82f4C0Db0aF83Dd9626346;
  address public constant ZKSYNC = 0xE7dBD6023B9c7eD90f65CE61458B7b4A5c22A1Fa;
  address public constant SONEIUM = 0x334bA9f803e77Fb68c4849d6C51345af2D563Ff7;
  address public constant MAINNET_CORE = 0xC2584B9cA7759FE1ac48D8aE38aeAFE12dbC9876;
  address public constant MAINNET_LIDO = 0x028229cdAADa074A17980B4d69A1483a738D24cA;
  address public constant MAINNET_ETHERFI = 0x1FaaB253f2cb5462eac72BCE7a379D3fc5A17E10;
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployEthereumReimbursement chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MayFundingPartB_20250524.s.sol/1/run-latest.json
 */
contract DeployEthereumReimbursement is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(type(AuditReimbursement).creationCode);

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.MAINNET_CORE;
    address payload1 = Deployments.MAINNET_LIDO;
    address payload2 = Deployments.MAINNET_ETHERFI;

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](3);
    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(payload1);
    actions[2] = GovV3Helpers.buildAction(payload2);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.POLYGON;

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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.AVALANCHE;

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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.OPTIMISM;

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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.ARBITRUM;

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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.METIS;

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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.BASE;

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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.GNOSIS;

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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.SCROLL;

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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.BNB;

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Linea
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.LINEA;

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Celo
 * deploy-command: FOUNDRY_PROFILE=celo make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployCelo chain=celo
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/42220/run-latest.json
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.CELO;

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Sonic
 * deploy-command: FOUNDRY_PROFILE=sonic make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeploySonic chain=sonic
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/146/run-latest.json
 */
contract DeploySonic is SonicScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.SONIC;

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Soneium
 * deploy-command: FOUNDRY_PROFILE=soneium make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeploySoneium chain=soneium
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/1868/run-latest.json
 */
contract DeploySoneium is SoneiumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = Deployments.SONEIUM;

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
 * command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](16);

    {
      // compose actions for validation
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](3);
      actionsEthereum[0] = GovV3Helpers.buildAction(Deployments.MAINNET_CORE);
      actionsEthereum[1] = GovV3Helpers.buildAction(Deployments.MAINNET_LIDO);
      actionsEthereum[2] = GovV3Helpers.buildAction(Deployments.MAINNET_ETHERFI);
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum2 = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum2[0] = GovV3Helpers.buildAction(type(AuditReimbursement).creationCode);
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
      payloads[1] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum2);
    }

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(Deployments.POLYGON);
    payloads[2] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(Deployments.AVALANCHE);
    payloads[3] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(Deployments.OPTIMISM);
    payloads[4] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(Deployments.ARBITRUM);
    payloads[5] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(Deployments.METIS);
    payloads[6] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(Deployments.BASE);
    payloads[7] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(Deployments.GNOSIS);
    payloads[8] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(Deployments.SCROLL);
    payloads[9] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(Deployments.BNB);
    payloads[10] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    payloads[11] = PayloadsControllerUtils.Payload({
      chain: ChainIds.ZKSYNC,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
      payloadId: 28
    });

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsLinea = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsLinea[0] = GovV3Helpers.buildAction(Deployments.LINEA);
    payloads[12] = GovV3Helpers.buildLineaPayload(vm, actionsLinea);

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsCelo[0] = GovV3Helpers.buildAction(Deployments.CELO);
      payloads[13] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsSonic = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsSonic[0] = GovV3Helpers.buildAction(Deployments.SONIC);
      payloads[14] = GovV3Helpers.buildSonicPayload(vm, actionsSonic);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsSoneium = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsSoneium[0] = GovV3Helpers.buildAction(Deployments.SONEIUM);
      payloads[15] = GovV3Helpers.buildSoneiumPayload(vm, actionsSoneium);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34.md'
      )
    );
  }
}
