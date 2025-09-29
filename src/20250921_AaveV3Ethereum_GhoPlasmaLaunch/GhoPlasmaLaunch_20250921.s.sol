// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, ArbitrumScript, BaseScript, AvalancheScript, GnosisScript, InkScript, PlasmaScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3_GhoPlasmaLaunch_20250921} from './AaveV3_GhoPlasmaLaunch_20250921.sol';
import {Arbitrum_Plasma_AaveV3GHOLane_20250921} from './remote-lanes/Arbitrum_Plasma_AaveV3GHOLane_20250921.sol';
import {Avalanche_Plasma_AaveV3GHOLane_20250921} from './remote-lanes/Avalanche_Plasma_AaveV3GHOLane_20250921.sol';
import {Base_Plasma_AaveV3GHOLane_20250921} from './remote-lanes/Base_Plasma_AaveV3GHOLane_20250921.sol';
import {Ethereum_Plasma_AaveV3GHOLane_20250921} from './remote-lanes/Ethereum_Plasma_AaveV3GHOLane_20250921.sol';
import {Gnosis_Plasma_AaveV3GHOLane_20250921} from './remote-lanes/Gnosis_Plasma_AaveV3GHOLane_20250921.sol';
import {Ink_Plasma_AaveV3GHOLane_20250921} from './remote-lanes/Ink_Plasma_AaveV3GHOLane_20250921.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/GhoPlasmaLaunch_20250921.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Ethereum_Plasma_AaveV3GHOLane_20250921).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/GhoPlasmaLaunch_20250921.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/1/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Arbitrum_Plasma_AaveV3GHOLane_20250921).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/GhoPlasmaLaunch_20250921.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/1/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Avalanche_Plasma_AaveV3GHOLane_20250921).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/GhoPlasmaLaunch_20250921.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/1/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Base_Plasma_AaveV3GHOLane_20250921).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/GhoPlasmaLaunch_20250921.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/1/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Gnosis_Plasma_AaveV3GHOLane_20250921).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/GhoPlasmaLaunch_20250921.s.sol:DeployInk chain=ink
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/1/run-latest.json
 */
contract DeployInk is InkScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(Ink_Plasma_AaveV3GHOLane_20250921).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/GhoPlasmaLaunch_20250921.s.sol:DeployPlasma chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoPlasmaLaunch_20250921.s.sol/1/run-latest.json
 */
contract DeployPlasma is PlasmaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3_GhoPlasmaLaunch_20250921).creationCode
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
 * command: make deploy-ledger contract=src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/GhoPlasmaLaunch_20250921.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](7);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3_GhoPlasmaLaunch_20250921).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(Arbitrum_Plasma_AaveV3GHOLane_20250921).creationCode
    );
    payloads[1] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(Base_Plasma_AaveV3GHOLane_20250921).creationCode
    );
    payloads[2] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      type(Avalanche_Plasma_AaveV3GHOLane_20250921).creationCode
    );
    payloads[3] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(Gnosis_Plasma_AaveV3GHOLane_20250921).creationCode
    );
    payloads[4] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsInk = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsInk[0] = GovV3Helpers.buildAction(type(Ink_Plasma_AaveV3GHOLane_20250921).creationCode);
    payloads[5] = GovV3Helpers.buildInkPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPlasmaLaunch = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPlasmaLaunch[0] = GovV3Helpers.buildAction(
      type(AaveV3_GhoPlasmaLaunch_20250921).creationCode
    );
    payloads[6] = GovV3Helpers.buildPlasmaPayload(vm, actionsPlasmaLaunch);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/GhoPlasmaLaunch.md'
      )
    );
  }
}
