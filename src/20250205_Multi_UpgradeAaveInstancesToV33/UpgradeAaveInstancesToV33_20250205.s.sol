// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript, ScrollScript, BNBScript, LineaScript, ChainIds} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {PaymentPayload} from './PaymentPayload.sol';

library Payloads {
  address internal constant POLYGON = 0xe39e928A82D3c4a406FfCAb671B3b36a21D98295;
  address internal constant GNOSIS = 0xCf85FF1c37c594a10195F7A9Ab85CBb0a03f69dE;
  address internal constant OPTIMISM = 0x09262648Fce84992B68AbF216BfC47731F154462;
  address internal constant ARBITRUM = 0x19ED0C564d7818BcA61C358b10f017F9239D2Df2;
  address internal constant AVALANCHE = 0x391095d2e79e7Bd89C1eb984220273268994a5b7;
  address internal constant BASE = 0x1E81af09001aD208BDa68FF022544dB2102A752d;
  address internal constant SCROLL = 0xb77fc84a549ecc0b410d6fa15159C2df207545a3;
  address internal constant BNB = 0x5E76E98E0963EcDC6A065d1435F84065b7523f39;
  address internal constant PROTO = 0x79691D2DFE962E4059F3b56B53D7Cc081F494aE0;
  address internal constant METIS = 0xb85d72EC1EfE48168c4aBC4eB855f8Cbcd05cE38;
  address internal constant LIDO = 0x5Deec870CAA11742BAE0f0B650EC8A549D1814Fa;
  address internal constant ETHERFI = 0xceDd3bC91c502aA5d74eF4065fbBE5D0b5ECb4C3;
  address internal constant LINEA = 0x89654c66A6abd7174b525D05C2f4c442a615cee8;
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload3 = GovV3Helpers.deployDeterministic(type(PaymentPayload).creationCode);

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](4);
    actions[0] = GovV3Helpers.buildAction(Payloads.PROTO);
    actions[1] = GovV3Helpers.buildAction(Payloads.LIDO);
    actions[2] = GovV3Helpers.buildAction(Payloads.ETHERFI);
    actions[3] = GovV3Helpers.buildAction(payload3);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=polygon npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/137/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=avalanche npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/43114/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=optimism npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/10/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=arbitrum npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/42161/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=metis npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/1088/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=base npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/8453/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=gnosis npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/100/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=scroll npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/534352/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=bnb npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/56/run-latest.json
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
 * @dev Deploy Linea
 * deploy-command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=linea npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV33_20250205.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.LINEA);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33_20250205.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](12);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](4);
    actionsEthereum[0] = GovV3Helpers.buildAction(Payloads.PROTO);
    actionsEthereum[1] = GovV3Helpers.buildAction(Payloads.LIDO);
    actionsEthereum[2] = GovV3Helpers.buildAction(Payloads.ETHERFI);
    actionsEthereum[3] = GovV3Helpers.buildAction(type(PaymentPayload).creationCode);
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

    uint40 payloadId = 15;
    payloads[10] = PayloadsControllerUtils.Payload({
      chain: ChainIds.ZKSYNC,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
      payloadId: payloadId
    });

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsLinea = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsLinea[0] = GovV3Helpers.buildAction(Payloads.LINEA);
    payloads[11] = GovV3Helpers.buildLineaPayload(vm, actionsLinea);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250205_Multi_UpgradeAaveInstancesToV33/UpgradeAaveInstancesToV33.md'
      )
    );
  }
}
