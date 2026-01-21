// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, ArbitrumScript, BaseScript, AvalancheScript, GnosisScript, InkScript, PlasmaScript, MantleScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Mantle_GhoMantleActivation_20260105} from './AaveV3Mantle_GhoMantleActivation_20260105.sol';
import {Arbitrum_Mantle_AaveV3GHOLane_20260105} from './remote-lanes/Arbitrum_Mantle_AaveV3GHOLane_20260105.sol';
import {Avalanche_Mantle_AaveV3GHOLane_20260105} from './remote-lanes/Avalanche_Mantle_AaveV3GHOLane_20260105.sol';
import {Base_Mantle_AaveV3GHOLane_20260105} from './remote-lanes/Base_Mantle_AaveV3GHOLane_20260105.sol';
import {Ethereum_Mantle_AaveV3GHOLane_20260105} from './remote-lanes/Ethereum_Mantle_AaveV3GHOLane_20260105.sol';
import {Gnosis_Mantle_AaveV3GHOLane_20260105} from './remote-lanes/Gnosis_Mantle_AaveV3GHOLane_20260105.sol';
import {Ink_Mantle_AaveV3GHOLane_20260105} from './remote-lanes/Ink_Mantle_AaveV3GHOLane_20260105.sol';
import {Plasma_Mantle_AaveV3GHOLane_20260105} from './remote-lanes/Plasma_Mantle_AaveV3GHOLane_20260105.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation_20260105.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Ethereum_Mantle_AaveV3GHOLane_20260105).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation_20260105.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Arbitrum_Mantle_AaveV3GHOLane_20260105).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation_20260105.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Avalanche_Mantle_AaveV3GHOLane_20260105).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation_20260105.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Base_Mantle_AaveV3GHOLane_20260105).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation_20260105.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Gnosis_Mantle_AaveV3GHOLane_20260105).creationCode
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
 * @dev Deploy Ink
 * deploy-command: make deploy-ledger contract=src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation_20260105.s.sol:DeployInk chain=ink
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/57073/run-latest.json
 */
contract DeployInk is InkScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Ink_Mantle_AaveV3GHOLane_20260105).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation_20260105.s.sol:DeployMantle chain=mantle
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMantleActivation_20260105.s.sol/1088/run-latest.json
 */
contract DeployMantle is MantleScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Mantle_GhoMantleActivation_20260105).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation_20260105.s.sol:DeployPlasma chain=plasma
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMantleActivation_20260105.s.sol/9745/run-latest.json
 */
contract DeployPlasma is PlasmaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Plasma_Mantle_AaveV3GHOLane_20260105).creationCode
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
 * command: make deploy-ledger contract=src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation_20260105.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](8);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMantle = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMantle[0] = GovV3Helpers.buildAction(
        type(AaveV3Mantle_GhoMantleActivation_20260105).creationCode
      );
      payloads[0] = GovV3Helpers.buildMantlePayload(vm, actionsMantle);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(Ethereum_Mantle_AaveV3GHOLane_20260105).creationCode
      );
      payloads[1] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsArbitrum[0] = GovV3Helpers.buildAction(
        type(Arbitrum_Mantle_AaveV3GHOLane_20260105).creationCode
      );
      payloads[2] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsBase[0] = GovV3Helpers.buildAction(
        type(Base_Mantle_AaveV3GHOLane_20260105).creationCode
      );
      payloads[3] = GovV3Helpers.buildBasePayload(vm, actionsBase);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsAvalanche[0] = GovV3Helpers.buildAction(
        type(Avalanche_Mantle_AaveV3GHOLane_20260105).creationCode
      );
      payloads[4] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGnosis[0] = GovV3Helpers.buildAction(
        type(Gnosis_Mantle_AaveV3GHOLane_20260105).creationCode
      );
      payloads[5] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsInk = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsInk[0] = GovV3Helpers.buildAction(
        type(Ink_Mantle_AaveV3GHOLane_20260105).creationCode
      );
      payloads[6] = GovV3Helpers.buildInkPayload(vm, actionsInk);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPlasma = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPlasma[0] = GovV3Helpers.buildAction(
        type(Plasma_Mantle_AaveV3GHOLane_20260105).creationCode
      );
      payloads[7] = GovV3Helpers.buildPlasmaPayload(vm, actionsPlasma);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260105_AaveV3Mantle_GhoMantleActivation/GhoMantleActivation.md'
      )
    );
  }
}
