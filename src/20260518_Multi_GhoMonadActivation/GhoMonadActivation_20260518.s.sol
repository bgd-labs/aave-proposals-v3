// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, AvalancheScript, ArbitrumScript, BaseScript, GnosisScript, InkScript, PlasmaScript, MantleScript, XLayerScript, MonadScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_GhoMonadActivation_20260518} from './remote-lanes/AaveV3Ethereum_GhoMonadActivation_20260518.sol';
import {AaveV3Avalanche_GhoMonadActivation_20260518} from './remote-lanes/AaveV3Avalanche_GhoMonadActivation_20260518.sol';
import {AaveV3Arbitrum_GhoMonadActivation_20260518} from './remote-lanes/AaveV3Arbitrum_GhoMonadActivation_20260518.sol';
import {AaveV3Base_GhoMonadActivation_20260518} from './remote-lanes/AaveV3Base_GhoMonadActivation_20260518.sol';
import {AaveV3Gnosis_GhoMonadActivation_20260518} from './remote-lanes/AaveV3Gnosis_GhoMonadActivation_20260518.sol';
import {AaveV3Plasma_GhoMonadActivation_20260518} from './remote-lanes/AaveV3Plasma_GhoMonadActivation_20260518.sol';
import {AaveV3Ink_GhoMonadActivation_20260518} from './remote-lanes/AaveV3Ink_GhoMonadActivation_20260518.sol';
import {AaveV3Mantle_GhoMonadActivation_20260518} from './remote-lanes/AaveV3Mantle_GhoMonadActivation_20260518.sol';
import {AaveV3XLayer_GhoMonadActivation_20260518} from './remote-lanes/AaveV3XLayer_GhoMonadActivation_20260518.sol';
import {AaveV3Monad_GhoMonadActivation_20260518} from './AaveV3Monad_GhoMonadActivation_20260518.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_GhoMonadActivation_20260518).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_GhoMonadActivation_20260518).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_GhoMonadActivation_20260518).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_GhoMonadActivation_20260518).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_GhoMonadActivation_20260518).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployInk chain=ink
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/57073/run-latest.json
 */
contract DeployInk is InkScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ink_GhoMonadActivation_20260518).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployMantle chain=mantle
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/1088/run-latest.json
 */
contract DeployMantle is MantleScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Mantle_GhoMonadActivation_20260518).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployPlasma chain=plasma
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/9745/run-latest.json
 */
contract DeployPlasma is PlasmaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Plasma_GhoMonadActivation_20260518).creationCode
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
 * @dev Deploy X-Layer
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployXLayer chain=xlayer
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/196/run-latest.json
 */
contract DeployXLayer is XLayerScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3XLayer_GhoMonadActivation_20260518).creationCode
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
 * @dev Deploy Monad
 * deploy-command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:DeployMonad chain=monad
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/GhoMonadActivation_20260518.s.sol/143/run-latest.json
 */
contract DeployMonad is MonadScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Monad_GhoMonadActivation_20260518).creationCode
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
 * command: make deploy-ledger contract=src/20260518_Multi_GhoMonadActivation/GhoMonadActivation_20260518.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](10);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_GhoMonadActivation_20260518).creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsAvalanche[0] = GovV3Helpers.buildAction(
        type(AaveV3Avalanche_GhoMonadActivation_20260518).creationCode
      );
      payloads[1] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsArbitrum[0] = GovV3Helpers.buildAction(
        type(AaveV3Arbitrum_GhoMonadActivation_20260518).creationCode
      );
      payloads[2] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsBase[0] = GovV3Helpers.buildAction(
        type(AaveV3Base_GhoMonadActivation_20260518).creationCode
      );
      payloads[3] = GovV3Helpers.buildBasePayload(vm, actionsBase);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGnosis[0] = GovV3Helpers.buildAction(
        type(AaveV3Gnosis_GhoMonadActivation_20260518).creationCode
      );
      payloads[4] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsInk = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsInk[0] = GovV3Helpers.buildAction(
        type(AaveV3Ink_GhoMonadActivation_20260518).creationCode
      );
      payloads[5] = GovV3Helpers.buildInkPayload(vm, actionsInk);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMantle = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMantle[0] = GovV3Helpers.buildAction(
        type(AaveV3Mantle_GhoMonadActivation_20260518).creationCode
      );
      payloads[6] = GovV3Helpers.buildMantlePayload(vm, actionsMantle);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPlasma = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPlasma[0] = GovV3Helpers.buildAction(
        type(AaveV3Plasma_GhoMonadActivation_20260518).creationCode
      );
      payloads[7] = GovV3Helpers.buildPlasmaPayload(vm, actionsPlasma);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsXLayer = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsXLayer[0] = GovV3Helpers.buildAction(
        type(AaveV3XLayer_GhoMonadActivation_20260518).creationCode
      );
      payloads[8] = GovV3Helpers.buildXLayerPayload(vm, actionsXLayer);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMonad = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMonad[0] = GovV3Helpers.buildAction(
        type(AaveV3Monad_GhoMonadActivation_20260518).creationCode
      );
      payloads[9] = GovV3Helpers.buildMonadPayload(vm, actionsMonad);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(vm, 'src/20260518_Multi_GhoMonadActivation/GhoMonadActivation.md')
    );
  }
}
