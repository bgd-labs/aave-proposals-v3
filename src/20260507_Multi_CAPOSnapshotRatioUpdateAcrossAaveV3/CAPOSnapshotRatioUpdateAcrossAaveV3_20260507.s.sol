// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, PolygonScript, AvalancheScript, GnosisScript, LineaScript, PlasmaScript, MantleScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';
import {AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';
import {AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';
import {AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';
import {AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';
import {AaveV3Plasma_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Plasma_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';
import {AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
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
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
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
 * @dev Deploy Plasma
 * deploy-command: make deploy-ledger contract=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol:DeployPlasma chain=plasma
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol/9745/run-latest.json
 */
contract DeployPlasma is PlasmaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Plasma_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
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
 * @dev Deploy Mantle
 * deploy-command: make deploy-ledger contract=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol:DeployMantle chain=mantle
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol/5000/run-latest.json
 */
contract DeployMantle is MantleScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
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
 * command: make deploy-ledger contract=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](7);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPolygon[0] = GovV3Helpers.buildAction(
        type(AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
      );
      payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsAvalanche[0] = GovV3Helpers.buildAction(
        type(AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
      );
      payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGnosis[0] = GovV3Helpers.buildAction(
        type(AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
      );
      payloads[3] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsLinea = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsLinea[0] = GovV3Helpers.buildAction(
        type(AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
      );
      payloads[4] = GovV3Helpers.buildLineaPayload(vm, actionsLinea);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPlasma = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPlasma[0] = GovV3Helpers.buildAction(
        type(AaveV3Plasma_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
      );
      payloads[5] = GovV3Helpers.buildPlasmaPayload(vm, actionsPlasma);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMantle = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMantle[0] = GovV3Helpers.buildAction(
        type(AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507).creationCode
      );
      payloads[6] = GovV3Helpers.buildMantlePayload(vm, actionsMantle);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/CAPOSnapshotRatioUpdateAcrossAaveV3.md'
      )
    );
  }
}
