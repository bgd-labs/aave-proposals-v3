// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {ChainIds, EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript, ScrollScript, BNBScript, LineaScript, CeloScript, SonicScript, SoneiumScript, PlasmaScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {Deployments} from './Deployments.sol';
import {ReimbursePayload} from './ReimbursePayload.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    {
      // compose action
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[0] = GovV3Helpers.buildAction(Deployments.MAINNET_CORE);

      // register action at payloadsController
      GovV3Helpers.createPayload(actions);
    }
    {
      // compose action
      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
      actions[1] = GovV3Helpers.buildAction(Deployments.MAINNET_LIDO);

      // register action at payloadsController
      GovV3Helpers.createPayload(actions);
    }
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.POLYGON);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.AVALANCHE);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.OPTIMISM);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.ARBITRUM);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Metis
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.METIS);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.BASE);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.GNOSIS);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Scroll
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.SCROLL);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.BNB);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Linea
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.LINEA);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Celo
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployCelo chain=celo
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/42220/run-latest.json
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.CELO);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Sonic
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeploySonic chain=sonic
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/146/run-latest.json
 */
contract DeploySonic is SonicScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.SONIC);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Soneium
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeploySoneium chain=soneium
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/1868/run-latest.json
 */
contract DeploySoneium is SoneiumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.SONEIUM);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Plasma
 * deploy-command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:DeployPlasma chain=plasma
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV36_20251209.s.sol/9745/run-latest.json
 */
contract DeployPlasma is PlasmaScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Deployments.PLASMA);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:CreateProposal2thJanuary chain=mainnet
 */
contract CreateProposal2thJanuary is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](9);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](2);
      actionsEthereum[0] = GovV3Helpers.buildAction(Deployments.MAINNET_ETHERFI);
      actionsEthereum[1] = GovV3Helpers.buildAction(type(ReimbursePayload).creationCode);
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsOptimism[0] = GovV3Helpers.buildAction(Deployments.OPTIMISM);
      payloads[1] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMetis[0] = GovV3Helpers.buildAction(Deployments.METIS);
      payloads[2] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGnosis[0] = GovV3Helpers.buildAction(Deployments.GNOSIS);
      payloads[3] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsScroll[0] = GovV3Helpers.buildAction(Deployments.SCROLL);
      payloads[4] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);
    }

    {
      payloads[5] = PayloadsControllerUtils.Payload({
        chain: ChainIds.ZKSYNC,
        accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
        payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
        payloadId: 33
      });
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsCelo[0] = GovV3Helpers.buildAction(Deployments.CELO);
      payloads[6] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsSonic = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsSonic[0] = GovV3Helpers.buildAction(Deployments.SONIC);
      payloads[7] = GovV3Helpers.buildSonicPayload(vm, actionsSonic);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsSoneium = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsSoneium[0] = GovV3Helpers.buildAction(Deployments.SONEIUM);
      payloads[8] = GovV3Helpers.buildSoneiumPayload(vm, actionsSoneium);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV362nd.md'
      )
    );
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV36_20251209.s.sol:CreateProposal6thJanuary chain=mainnet
 */
contract CreateProposal6thJanuary is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](9);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(Deployments.MAINNET_CORE);
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(Deployments.MAINNET_LIDO);
      payloads[1] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPolygon[0] = GovV3Helpers.buildAction(Deployments.POLYGON);
      payloads[2] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsAvalanche[0] = GovV3Helpers.buildAction(Deployments.AVALANCHE);
      payloads[3] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsArbitrum[0] = GovV3Helpers.buildAction(Deployments.ARBITRUM);
      payloads[4] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsBase[0] = GovV3Helpers.buildAction(Deployments.BASE);
      payloads[5] = GovV3Helpers.buildBasePayload(vm, actionsBase);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsBNB[0] = GovV3Helpers.buildAction(Deployments.BNB);
      payloads[6] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsLinea = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsLinea[0] = GovV3Helpers.buildAction(Deployments.LINEA);
      payloads[7] = GovV3Helpers.buildLineaPayload(vm, actionsLinea);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPlasma = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPlasma[0] = GovV3Helpers.buildAction(Deployments.PLASMA);
      payloads[8] = GovV3Helpers.buildPlasmaPayload(vm, actionsPlasma);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20251209_Multi_UpgradeAaveInstancesToV36/UpgradeAaveInstancesToV366th.md'
      )
    );
  }
}
