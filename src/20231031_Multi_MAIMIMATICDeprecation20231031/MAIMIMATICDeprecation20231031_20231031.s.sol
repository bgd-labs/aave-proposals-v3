// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Polygon_MAIMIMATICDeprecation20231031_20231031} from './AaveV3Polygon_MAIMIMATICDeprecation20231031_20231031.sol';
import {AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031} from './AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031.sol';
import {AaveV3Optimism_MAIMIMATICDeprecation20231031_20231031} from './AaveV3Optimism_MAIMIMATICDeprecation20231031_20231031.sol';
import {AaveV3Arbitrum_MAIMIMATICDeprecation20231031_20231031} from './AaveV3Arbitrum_MAIMIMATICDeprecation20231031_20231031.sol';

/**
 * @dev Deploy Polygon
 * command: make deploy-ledger contract=src/20231031_Multi_MAIMIMATICDeprecation20231031/MAIMIMATICDeprecation20231031_20231031.s.sol:DeployPolygon chain=polygon
 * command: make deploy-pk contract=src/20231031_Multi_MAIMIMATICDeprecation20231031/MAIMIMATICDeprecation20231031_20231031.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Polygon_MAIMIMATICDeprecation20231031_20231031 payload0 = new AaveV3Polygon_MAIMIMATICDeprecation20231031_20231031();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * command: make deploy-ledger contract=src/20231031_Multi_MAIMIMATICDeprecation20231031/MAIMIMATICDeprecation20231031_20231031.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031 payload0 = new AaveV3Avalanche_MAIMIMATICDeprecation20231031_20231031();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Optimism
 * command: make deploy-ledger contract=src/20231031_Multi_MAIMIMATICDeprecation20231031/MAIMIMATICDeprecation20231031_20231031.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Optimism_MAIMIMATICDeprecation20231031_20231031 payload0 = new AaveV3Optimism_MAIMIMATICDeprecation20231031_20231031();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Arbitrum
 * command: make deploy-ledger contract=src/20231031_Multi_MAIMIMATICDeprecation20231031/MAIMIMATICDeprecation20231031_20231031.s.sol:DeployArbitrum chain=arbitrum
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Arbitrum_MAIMIMATICDeprecation20231031_20231031 payload0 = new AaveV3Arbitrum_MAIMIMATICDeprecation20231031_20231031();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231031_Multi_MAIMIMATICDeprecation20231031/MAIMIMATICDeprecation20231031_20231031.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(0x47a200a4805297c396aE73FFD52044D1Edb261bA);
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(0xf7C3350757DE224bdB2b77A3943C8667aCEE3d37);
    payloads[1] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(0xf8bC2a699559c96D48cf1e6F70aa2e67508C2aE9);
    payloads[2] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(0x0cB2535D00cddFae5Ed1aFf2e5a0239fC947D17d);
    payloads[3] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231031_Multi_MAIMIMATICDeprecation20231031/MAIMIMATICDeprecation20231031.md'
      )
    );
  }
}
