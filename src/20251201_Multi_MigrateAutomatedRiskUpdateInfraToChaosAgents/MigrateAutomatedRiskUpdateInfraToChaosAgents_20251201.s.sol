// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {AaveV3Ethereum_ReimburseLinkForRobot_20251201} from './AaveV3Ethereum_ReimburseLinkForRobot_20251201.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, BaseScript, GnosisScript, BNBScript, LineaScript, PlasmaScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

library Payloads {
  address internal constant ETHEREUM_CORE = 0x16747805927466664367aC107128501211B83dAf;
  address internal constant ETHEREUM_PRIME = 0x7Ca783f0Ab6c574978580E9e9F3b22733B035d8e;
  address internal constant ARBITRUM = 0xe2B7ad5e3aD12C5C59BB75532fd2d4177017B4C1;
  address internal constant AVALANCHE = 0xe22EeB5DCBb1f2934365CEAe2F504Dd7cF4e8652;
  address internal constant BASE = 0xB4BEE48b6D831586F5Ca498d65aaEe7cCed5804d;
  address internal constant BNB = 0x3085447F23F698Fe68A7d756a5fC333B88782880;
  address internal constant GNOSIS = 0x7afd7E52C258a9829614e93ac15C5c90EEEb1b64;
  address internal constant LINEA = 0x80BeCdFD39e47666FF2242aB5A9397c395e20581;
  address internal constant OPTIMISM = 0x022d4798197Af5003eA3AD8e83c93B4f30E0Faee;
  address internal constant POLYGON = 0x46bC67F2d5e937e478bbFc24652C8E101e664C75;
  address internal constant PLASMA = 0xc1772f185d7A7c1177791A85C3719277c2EA004E;
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
