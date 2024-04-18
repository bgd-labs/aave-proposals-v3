// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, AvalancheScript} from 'aave-helpers/ScriptUtils.sol';

library Payloads {
  // https://etherscan.io/address/0x927402dF69eaDC67ab0Ce0D443dA87d04dcaD84A
  address public constant ETHEREUM = 0x927402dF69eaDC67ab0Ce0D443dA87d04dcaD84A;

  // https://polygonscan.com/address/0xF70E9568Cc0E23154b1478356a1bCB75fD2d0D16
  address public constant POLYGON = 0xF70E9568Cc0E23154b1478356a1bCB75fD2d0D16;

  // https://snowscan.xyz/address/0x3c27599160ed92bc62660c13e6f3f5930485f92b
  address public constant AVALANCHE = 0x3C27599160ed92bc62660c13E6F3F5930485F92B;
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240415_Multi_SetPriceCapAdaptersForAaveV2/SetPriceCapAdaptersForAaveV2_20240415.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdaptersForAaveV2_20240415.s.sol/1/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240415_Multi_SetPriceCapAdaptersForAaveV2/SetPriceCapAdaptersForAaveV2_20240415.s.sol:DeployPolygon chain=polygon
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdaptersForAaveV2_20240415.s.sol/137/run-latest.json
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
 * deploy-command: make deploy-ledger contract=src/20240415_Multi_SetPriceCapAdaptersForAaveV2/SetPriceCapAdaptersForAaveV2_20240415.s.sol:DeployAvalanche chain=avalanche
 * verify-command: npx catapulta-verify -b broadcast/SetPriceCapAdaptersForAaveV2_20240415.s.sol/43114/run-latest.json
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
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240415_Multi_SetPriceCapAdaptersForAaveV2/SetPriceCapAdaptersForAaveV2_20240415.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](3);

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

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240415_Multi_SetPriceCapAdaptersForAaveV2/SetPriceCapAdaptersForAaveV2.md'
      )
    );
  }
}
