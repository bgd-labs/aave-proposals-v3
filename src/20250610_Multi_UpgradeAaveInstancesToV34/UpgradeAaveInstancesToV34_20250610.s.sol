// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript, ScrollScript, BNBScript, LineaScript, CeloScript, SonicScript, SoneiumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_UpgradeAaveInstancesToV34_20250610} from './AaveV3Ethereum_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3EthereumLido_UpgradeAaveInstancesToV34_20250610} from './AaveV3EthereumLido_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3EthereumEtherFi_UpgradeAaveInstancesToV34_20250610} from './AaveV3EthereumEtherFi_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Polygon_UpgradeAaveInstancesToV34_20250610} from './AaveV3Polygon_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Avalanche_UpgradeAaveInstancesToV34_20250610} from './AaveV3Avalanche_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Optimism_UpgradeAaveInstancesToV34_20250610} from './AaveV3Optimism_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Arbitrum_UpgradeAaveInstancesToV34_20250610} from './AaveV3Arbitrum_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Metis_UpgradeAaveInstancesToV34_20250610} from './AaveV3Metis_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Base_UpgradeAaveInstancesToV34_20250610} from './AaveV3Base_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Gnosis_UpgradeAaveInstancesToV34_20250610} from './AaveV3Gnosis_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Scroll_UpgradeAaveInstancesToV34_20250610} from './AaveV3Scroll_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3BNB_UpgradeAaveInstancesToV34_20250610} from './AaveV3BNB_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Linea_UpgradeAaveInstancesToV34_20250610} from './AaveV3Linea_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Celo_UpgradeAaveInstancesToV34_20250610} from './AaveV3Celo_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Sonic_UpgradeAaveInstancesToV34_20250610} from './AaveV3Sonic_UpgradeAaveInstancesToV34_20250610.sol';
import {AaveV3Soneium_UpgradeAaveInstancesToV34_20250610} from './AaveV3Soneium_UpgradeAaveInstancesToV34_20250610.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3EthereumLido_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    address payload2 = GovV3Helpers.deployDeterministic(
      type(AaveV3EthereumEtherFi_UpgradeAaveInstancesToV34_20250610).creationCode
    );

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
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Polygon_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployAvalanche chain=avalanche
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Avalanche_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployOptimism chain=optimism
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployMetis chain=metis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Metis_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployGnosis chain=gnosis
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Gnosis_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Scroll_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Linea_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * @dev Deploy Celo
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeployCelo chain=celo
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/42220/run-latest.json
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Celo_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * @dev Deploy Sonic
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeploySonic chain=sonic
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/146/run-latest.json
 */
contract DeploySonic is SonicScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Sonic_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * @dev Deploy Soneium
 * deploy-command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:DeploySoneium chain=soneium
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UpgradeAaveInstancesToV34_20250610.s.sol/1868/run-latest.json
 */
contract DeploySoneium is SoneiumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Soneium_UpgradeAaveInstancesToV34_20250610).creationCode
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
 * command: make deploy-ledger contract=src/20250610_Multi_UpgradeAaveInstancesToV34/UpgradeAaveInstancesToV34_20250610.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](15);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](3);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    actionsEthereum[1] = GovV3Helpers.buildAction(
      type(AaveV3EthereumLido_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    actionsEthereum[2] = GovV3Helpers.buildAction(
      type(AaveV3EthereumEtherFi_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Polygon_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(
      type(AaveV3Avalanche_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(
      type(AaveV3Optimism_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[3] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[4] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(
      type(AaveV3Metis_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[5] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(AaveV3Base_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[6] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(
      type(AaveV3Gnosis_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[7] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(
      type(AaveV3Scroll_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[8] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(
      type(AaveV3BNB_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[9] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsZkSync = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsZkSync[0] = GovV3Helpers.buildActionZkSync(
      vm,
      'AaveV3ZkSync_UpgradeAaveInstancesToV34_20250610'
    );
    payloads[10] = GovV3Helpers.buildZkSyncPayload(vm, actionsZkSync);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsLinea = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsLinea[0] = GovV3Helpers.buildAction(
      type(AaveV3Linea_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[11] = GovV3Helpers.buildLineaPayload(vm, actionsLinea);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsCelo[0] = GovV3Helpers.buildAction(
      type(AaveV3Celo_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[12] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsSonic = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsSonic[0] = GovV3Helpers.buildAction(
      type(AaveV3Sonic_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[13] = GovV3Helpers.buildSonicPayload(vm, actionsSonic);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsSoneium = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsSoneium[0] = GovV3Helpers.buildAction(
      type(AaveV3Soneium_UpgradeAaveInstancesToV34_20250610).creationCode
    );
    payloads[14] = GovV3Helpers.buildSoneiumPayload(vm, actionsSoneium);

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
