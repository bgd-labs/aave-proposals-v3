// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, AvalancheScript, OptimismScript, ArbitrumScript, MetisScript, BaseScript, GnosisScript, BNBScript, ScrollScript} from 'aave-helpers/ScriptUtils.sol';

library Payloads {
  // https://etherscan.io/address/0xb20935059e3f49cbfa35bed0780fb8887d7d0d67
  address public constant ETHEREUM = 0xb20935059e3F49Cbfa35bED0780Fb8887D7D0D67;

  // https://polygonscan.com/address/0x2d976a898522e6bca5bf1464931283d24d2a2698
  address public constant POLYGON = 0x2d976a898522e6Bca5bf1464931283d24D2A2698;

  // https://snowtrace.io/address/0x882cCd8087bC44105E962Bc01280A335b210d738
  address public constant AVALANCHE = 0x882cCd8087bC44105E962Bc01280A335b210d738;

  // https://optimistic.etherscan.io/address/0xe2fad8c2e3aefbb3e8fea1e0b84463c7c06350a3
  address public constant OPTIMISM = 0xE2FaD8c2e3AefBB3e8FEa1E0B84463C7C06350A3;

  // https://arbiscan.io/address/0x296c266263bdc0b4ef32f75a7769ab925772f6cb
  address public constant ARBITRUM = 0x296C266263bDc0b4eF32F75a7769aB925772F6Cb;

  // https://andromeda-explorer.metis.io/address/0xAE04aDeC3Ce3140d34377FB38C71C882E948AA03/
  address public constant METIS = 0xAE04aDeC3Ce3140d34377FB38C71C882E948AA03;

  // https://basescan.org/address/0x360ef8d31b90718f13b73d10f3f3c122d86577f1
  address public constant BASE = 0x360eF8D31B90718f13b73d10f3F3C122d86577f1;

  // https://gnosisscan.io/address/0xac603d82de4fed4c28175f707bc4d15d79e63303
  address public constant GNOSIS = 0xaC603d82de4Fed4c28175f707BC4d15d79E63303;

  // https://bscscan.com/address/0x2683f613a899694a8d8669243321541cbdc6a95b
  address public constant BNB = 0x2683F613a899694a8d8669243321541CBdc6a95b;

  // https://scrollscan.com/address/0xd11f81a205b2ae847cb46c58e12b4c82a30e1809
  address public constant SCROLL = 0xD11f81a205b2ae847cB46c58e12b4c82A30e1809;
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/1/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/137/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployAvalanche chain=avalanche
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/43114/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployOptimism chain=optimism
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/10/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/42161/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployMetis chain=metis
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/1088/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployBase chain=base
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/8453/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployGnosis chain=gnosis
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/100/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployBNB chain=bnb
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/56/run-latest.json
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
 * @dev Deploy Scroll
 * deploy-command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:DeployScroll chain=scroll
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdapters_20240227.s.sol/534351/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(Payloads.SCROLL);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters_20240227.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](10);

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

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(Payloads.SCROLL);
    payloads[9] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(vm, 'src/20240227_Multi_SetPriceCapAdapters/SetPriceCapAdapters.md')
    );
  }
}
