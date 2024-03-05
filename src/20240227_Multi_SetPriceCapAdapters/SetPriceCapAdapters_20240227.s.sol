// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript, BNBScript} from 'aave-helpers/ScriptUtils.sol';

library Payloads {
  // https://etherscan.io/address/0x3611300f745f1e60aa1ce1d205517cdaa3b10b83
  address public constant ETHEREUM = 0x3611300f745F1e60AA1cE1d205517cDAA3b10B83;

  // https://polygonscan.com/address/0xbde0efa2ce806a02b4f25bfd77303c7790f279e4
  address public constant POLYGON = 0xbdE0Efa2CE806a02B4f25bfD77303C7790f279e4;

  // https://snowtrace.io/address/0x7a74E967Ba0663F7fC174D7Fc50D818e2fe877b0
  address public constant AVALANCHE = 0x7a74E967Ba0663F7fC174D7Fc50D818e2fe877b0;

  // https://optimistic.etherscan.io/address/0x8740b38ff207cc0f8bf2621fe467e9cf1aacdb86
  address public constant OPTIMISM = 0x8740b38fF207CC0F8BF2621fe467e9cF1AACDB86;

  // https://arbiscan.io/address/0x8d12d8d7eb9cbeee29a64e31dbc352b7ebc17337
  address public constant ARBITRUM = 0x8D12D8D7Eb9CbeEe29a64E31DbC352B7ebC17337;

  // https://andromeda-explorer.metis.io/address/0xAE04aDeC3Ce3140d34377FB38C71C882E948AA03/
  address public constant METIS = 0xAE04aDeC3Ce3140d34377FB38C71C882E948AA03;

  // https://basescan.org/address/0x360ef8d31b90718f13b73d10f3f3c122d86577f1
  address public constant BASE = 0x360eF8D31B90718f13b73d10f3F3C122d86577f1;

  // https://gnosisscan.io/address/0x473e655bb3066326f7a5ffa5d3cccd6e0ef6f61e
  address public constant GNOSIS = 0x473e655bb3066326F7a5FFA5D3cCcd6E0eF6F61e;

  // https://bscscan.com/address/0x7525a45f37197dcb7c9e9e7e3a354dee81b1224b
  address public constant BNB = 0x7525A45F37197DcB7C9e9E7E3a354DeE81b1224B;
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapPriceAdapters_20240206.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.ETHEREUM);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * deploy-command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapPriceAdapters_20240206.s.sol/137/run-latest.json
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.POLYGON);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * deploy-command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:DeployAvalanche chain=avalanche
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapPriceAdapters_20240206.s.sol/43114/run-latest.json
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.AVALANCHE);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:DeployOptimism chain=optimism
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapPriceAdapters_20240206.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.OPTIMISM);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapPriceAdapters_20240206.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.ARBITRUM);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Metis
 * deploy-command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:DeployMetis chain=metis
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapPriceAdapters_20240206.s.sol/1088/run-latest.json
 */
contract DeployMetis is MetisScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.METIS);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:DeployBase chain=base
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapPriceAdapters_20240206.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.BASE);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Gnosis
 * deploy-command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:DeployGnosis chain=gnosis
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapPriceAdapters_20240206.s.sol/100/run-latest.json
 */
contract DeployGnosis is GnosisScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.GNOSIS);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:DeployBNB chain=bnb
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapPriceAdapters_20240206.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.BNB);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240206_Multi_SetPriceCapPriceAdapters/SetPriceCapPriceAdapters_20240206.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](9);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(Payloads.ETHEREUM);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(Payloads.POLYGON);
    payloads[1] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(Payloads.AVALANCHE);
    payloads[2] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(Payloads.OPTIMISM);
    payloads[3] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(Payloads.ARBITRUM);
    payloads[4] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsMetis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsMetis[0] = GovV3Helpers.buildAction(Payloads.METIS);
    payloads[5] = GovV3Helpers.buildMetisPayload(vm, actionsMetis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(Payloads.BASE);
    payloads[6] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGnosis = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGnosis[0] = GovV3Helpers.buildAction(Payloads.GNOSIS);
    payloads[7] = GovV3Helpers.buildGnosisPayload(vm, actionsGnosis);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(Payloads.BNB);
    payloads[8] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(vm, 'src/20240206_Multi_SetPriceCapAdapters/SetPriceCapAdapters.md')
    );
  }
}
