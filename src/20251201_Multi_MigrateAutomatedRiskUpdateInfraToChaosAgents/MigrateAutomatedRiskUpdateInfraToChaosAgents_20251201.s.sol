// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3Ethereum_ReimburseLinkForRobot_20251201} from './AaveV3Ethereum_ReimburseLinkForRobot_20251201.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, BaseScript, GnosisScript, BNBScript, LineaScript, PlasmaScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

library Payloads {
  address internal constant ETHEREUM_CORE = 0xfFc35B2ae62A7a4aCCAa64BCe70eF9c85435b0eC;
  address internal constant ETHEREUM_PRIME = 0x8dA7d151F230ca969a0460Be804Af7aAe5b50f6b;
  address internal constant ARBITRUM = 0x9D1C9aA189c538c0F793ABCCB8A6195A4f67D878;
  address internal constant AVALANCHE = 0x2A31906B9B6da2d9D2057C926276C0D610e79882;
  address internal constant BASE = 0xCC88fB5f07F38e285Aba857ee5345535c60f4098;
  address internal constant BNB = 0x593b820168eeBa2De15eBdAb0F2bCe4c8B09760A;
  address internal constant GNOSIS = 0x593bBD378c2bdC59A54966135A7653f5e08Ce172;
  address internal constant LINEA = 0xE638b790AF0EFaD986F162A1dDbEa7C0583d3a74;
  address internal constant OPTIMISM = 0x8b5850ADD9784874BCB3cc3ee72B2DE3f897d61A;
  address internal constant POLYGON = 0xeED95cea6E2FD11f1513d2317d4c4353523e76B4;
  address internal constant PLASMA = 0x2514b2B522dB4FdE44ec8eAe701Be17b204D4c21;
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address reimbursePayload = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_ReimburseLinkForRobot_20251201).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](3);
    actions[0] = GovV3Helpers.buildAction(Payloads.ETHEREUM_CORE);
    actions[1] = GovV3Helpers.buildAction(Payloads.ETHEREUM_PRIME);
    actions[2] = GovV3Helpers.buildAction(reimbursePayload);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployPolygon chain=polygon
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(Payloads.POLYGON));
  }
}

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(Payloads.AVALANCHE));
  }
}

/**
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(Payloads.OPTIMISM));
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(Payloads.ARBITRUM));
  }
}

/**
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(Payloads.BASE));
  }
}

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(Payloads.GNOSIS));
  }
}

/**
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(Payloads.BNB));
  }
}

/**
 * @dev Deploy Linea
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(Payloads.LINEA));
  }
}

/**
 * @dev Deploy Plasma
 * deploy-command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:DeployPlasma chain=plasma
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol/9745/run-latest.json
 */
contract DeployPlasma is PlasmaScript {
  function run() external broadcast {
    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(Payloads.PLASMA));
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](10);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](3);
      actionsEthereum[0] = GovV3Helpers.buildAction(Payloads.ETHEREUM_CORE);
      actionsEthereum[1] = GovV3Helpers.buildAction(Payloads.ETHEREUM_PRIME);
      actionsEthereum[2] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_ReimburseLinkForRobot_20251201).creationCode
      );

      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      payloads[1] = GovV3Helpers.buildPolygonPayload(
        vm,
        GovV3Helpers.buildAction(Payloads.POLYGON)
      );
    }

    {
      payloads[2] = GovV3Helpers.buildAvalanchePayload(
        vm,
        GovV3Helpers.buildAction(Payloads.AVALANCHE)
      );
    }

    {
      payloads[3] = GovV3Helpers.buildOptimismPayload(
        vm,
        GovV3Helpers.buildAction(Payloads.OPTIMISM)
      );
    }

    {
      payloads[4] = GovV3Helpers.buildArbitrumPayload(
        vm,
        GovV3Helpers.buildAction(Payloads.ARBITRUM)
      );
    }

    {
      payloads[5] = GovV3Helpers.buildBasePayload(vm, GovV3Helpers.buildAction(Payloads.BASE));
    }

    {
      payloads[6] = GovV3Helpers.buildGnosisPayload(vm, GovV3Helpers.buildAction(Payloads.GNOSIS));
    }

    {
      payloads[7] = GovV3Helpers.buildBNBPayload(vm, GovV3Helpers.buildAction(Payloads.BNB));
    }

    {
      payloads[8] = GovV3Helpers.buildLineaPayload(vm, GovV3Helpers.buildAction(Payloads.LINEA));
    }

    {
      payloads[9] = GovV3Helpers.buildPlasmaPayload(vm, GovV3Helpers.buildAction(Payloads.PLASMA));
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/MigrateAutomatedRiskUpdateInfraToChaosAgents.md'
      )
    );
  }
}
