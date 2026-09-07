// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, LineaScript, CeloScript, SonicScript, SoneiumScript, PlasmaScript, MantleScript, MegaEthScript, XLayerScript, InkScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Linea_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3Linea_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';
import {AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';
import {AaveV3Sonic_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3Sonic_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';
import {AaveV3Soneium_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3Soneium_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';
import {AaveV3Plasma_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3Plasma_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';
import {AaveV3Mantle_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3Mantle_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';
import {AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';
import {AaveV3XLayer_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3XLayer_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';
import {AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';

/**
 * @dev Deploy Linea
 * deploy-command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:DeployLinea chain=linea
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol/59144/run-latest.json
 */
contract DeployLinea is LineaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Linea_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:DeployCelo chain=celo
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol/42220/run-latest.json
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:DeploySonic chain=sonic
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol/146/run-latest.json
 */
contract DeploySonic is SonicScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Sonic_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:DeploySoneium chain=soneium
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol/1868/run-latest.json
 */
contract DeploySoneium is SoneiumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Soneium_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:DeployPlasma chain=plasma
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol/9745/run-latest.json
 */
contract DeployPlasma is PlasmaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Plasma_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:DeployMantle chain=mantle
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol/5000/run-latest.json
 */
contract DeployMantle is MantleScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Mantle_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
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
 * @dev Deploy MegaEth
 * deploy-command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:DeployMegaEth chain=megaeth
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol/4326/run-latest.json
 */
contract DeployMegaEth is MegaEthScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
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
 * @dev Deploy XLayer
 * deploy-command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:DeployXLayer chain=xlayer
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol/196/run-latest.json
 */
contract DeployXLayer is XLayerScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3XLayer_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
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
 * deploy-command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:DeployInk chain=ink
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol/57073/run-latest.json
 */
contract DeployInk is InkScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
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
 * command: make deploy-ledger contract=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](9);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsLinea = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsLinea[0] = GovV3Helpers.buildAction(
        type(AaveV3Linea_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
      );
      payloads[0] = GovV3Helpers.buildLineaPayload(vm, actionsLinea);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsCelo[0] = GovV3Helpers.buildAction(
        type(AaveV3Celo_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
      );
      payloads[1] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsSonic = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsSonic[0] = GovV3Helpers.buildAction(
        type(AaveV3Sonic_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
      );
      payloads[2] = GovV3Helpers.buildSonicPayload(vm, actionsSonic);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsSoneium = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsSoneium[0] = GovV3Helpers.buildAction(
        type(AaveV3Soneium_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
      );
      payloads[3] = GovV3Helpers.buildSoneiumPayload(vm, actionsSoneium);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPlasma = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPlasma[0] = GovV3Helpers.buildAction(
        type(AaveV3Plasma_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
      );
      payloads[4] = GovV3Helpers.buildPlasmaPayload(vm, actionsPlasma);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMantle = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMantle[0] = GovV3Helpers.buildAction(
        type(AaveV3Mantle_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
      );
      payloads[5] = GovV3Helpers.buildMantlePayload(vm, actionsMantle);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMegaEth = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMegaEth[0] = GovV3Helpers.buildAction(
        type(AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
      );
      payloads[6] = GovV3Helpers.buildMegaEthPayload(vm, actionsMegaEth);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsXLayer = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsXLayer[0] = GovV3Helpers.buildAction(
        type(AaveV3XLayer_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
      );
      payloads[7] = GovV3Helpers.buildXLayerPayload(vm, actionsXLayer);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsInk = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsInk[0] = GovV3Helpers.buildAction(
        type(AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2).creationCode
      );
      payloads[8] = GovV3Helpers.buildInkPayload(vm, actionsInk);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/MaintenanceGrantALRETRY_ROLEOnADI_Part2.md'
      )
    );
  }
}
