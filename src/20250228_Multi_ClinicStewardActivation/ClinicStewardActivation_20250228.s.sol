// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ChainIds, EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript, ScrollScript, BNBScript, LineaScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {ActivationPayload_20250228} from './ActivationPayload_20250228.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {GovernanceV3Linea} from 'aave-address-book/GovernanceV3Linea.sol';

address constant BOT = 0x3Cbded22F878aFC8d39dCD744d3Fe62086B76193;

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Ethereum.COLLECTOR, AaveV3Ethereum.CLINIC_STEWARD, BOT)
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Ethereum.COLLECTOR, AaveV3EthereumLido.CLINIC_STEWARD, BOT)
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
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=polygon npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Polygon.COLLECTOR, AaveV3Polygon.CLINIC_STEWARD, BOT)
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
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=avalanche npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Avalanche.COLLECTOR, AaveV3Avalanche.CLINIC_STEWARD, BOT)
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
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=optimism npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Optimism.COLLECTOR, AaveV3Optimism.CLINIC_STEWARD, BOT)
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
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=arbitrum npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Arbitrum.COLLECTOR, AaveV3Arbitrum.CLINIC_STEWARD, BOT)
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
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=metis npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Metis.COLLECTOR, AaveV3Metis.CLINIC_STEWARD, BOT)
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
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=base npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Base.COLLECTOR, AaveV3Base.CLINIC_STEWARD, BOT)
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
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=gnosis npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Gnosis.COLLECTOR, AaveV3Gnosis.CLINIC_STEWARD, BOT)
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
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=scroll npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Scroll.COLLECTOR, AaveV3Scroll.CLINIC_STEWARD, BOT)
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
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=bnb npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3BNB.COLLECTOR, AaveV3BNB.CLINIC_STEWARD, BOT)
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
 * @dev Deploy Linea
 * deploy-command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=linea npx catapulta-verify -b broadcast/ClinicStewardActivation_20250228.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Linea.COLLECTOR, AaveV3Linea.CLINIC_STEWARD, BOT)
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
 * command: make deploy-ledger contract=src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation_20250228.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](12);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](2);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Ethereum.COLLECTOR, AaveV3Ethereum.CLINIC_STEWARD, BOT)
    );
    actionsEthereum[1] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Ethereum.COLLECTOR, AaveV3EthereumLido.CLINIC_STEWARD, BOT)
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Polygon.COLLECTOR, AaveV3Polygon.CLINIC_STEWARD, BOT)
    );
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Avalanche.COLLECTOR, AaveV3Avalanche.CLINIC_STEWARD, BOT)
    );
    payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Optimism.COLLECTOR, AaveV3Optimism.CLINIC_STEWARD, BOT)
    );
    payloads[3] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Arbitrum.COLLECTOR, AaveV3Arbitrum.CLINIC_STEWARD, BOT)
    );
    payloads[4] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Metis.COLLECTOR, AaveV3Metis.CLINIC_STEWARD, BOT)
    );
    payloads[5] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Base.COLLECTOR, AaveV3Base.CLINIC_STEWARD, BOT)
    );
    payloads[6] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Gnosis.COLLECTOR, AaveV3Gnosis.CLINIC_STEWARD, BOT)
    );
    payloads[7] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3Scroll.COLLECTOR, AaveV3Scroll.CLINIC_STEWARD, BOT)
    );
    payloads[8] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(
      type(ActivationPayload_20250228).creationCode,
      abi.encode(AaveV3BNB.COLLECTOR, AaveV3BNB.CLINIC_STEWARD, BOT)
    );
    payloads[9] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    uint40 zksyncPayload = 18;
    require(zksyncPayload != 0);
    payloads[10] = PayloadsControllerUtils.Payload({
      chain: ChainIds.ZKSYNC,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
      payloadId: zksyncPayload
    });

    uint40 lineaPayload = 5;
    require(lineaPayload != 0);
    payloads[11] = PayloadsControllerUtils.Payload({
      chain: ChainIds.LINEA,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3Linea.PAYLOADS_CONTROLLER),
      payloadId: lineaPayload
    });

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250228_Multi_ClinicStewardActivation/ClinicStewardActivation.md'
      )
    );
  }
}
