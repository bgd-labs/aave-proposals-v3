// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, PolygonScript, AvalancheScript} from 'aave-helpers/ScriptUtils.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231109_Multi_AllowEmergencyAdminToFreezeOnAaveV2/AllowEmergencyAdminToFreezeOnAaveV2_20231109.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(0x23AceD103f5E22bD22B9272c82f29C0E51abC5c2);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231109_Multi_AllowEmergencyAdminToFreezeOnAaveV2/AllowEmergencyAdminToFreezeOnAaveV2_20231109.s.sol:DeployEthereumAmm chain=mainnet
 */
contract DeployEthereumAmm is EthereumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(0xf75cBd975756C52aA7321d10E6aCA90e07835Dee);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231109_Multi_AllowEmergencyAdminToFreezeOnAaveV2/AllowEmergencyAdminToFreezeOnAaveV2_20231109.s.sol:DeployEthereumSentinel chain=mainnet
 */
contract DeployEthereumSentinel is EthereumScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(0x9441B65EE553F70df9C77d45d3283B6BC24F222d);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Polygon
 * command: make deploy-ledger contract=src/20231109_Multi_AllowEmergencyAdminToFreezeOnAaveV2/AllowEmergencyAdminToFreezeOnAaveV2_20231109.s.sol:DeployPolygon chain=polygon
 */
contract DeployPolygon is PolygonScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(0x1AA25FdD7d55FA8a401D6EFba8e48874Ef730E55);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Deploy Avalanche
 * command: make deploy-ledger contract=src/20231109_Multi_AllowEmergencyAdminToFreezeOnAaveV2/AllowEmergencyAdminToFreezeOnAaveV2_20231109.s.sol:DeployAvalanche chain=avalanche
 */
contract DeployAvalanche is AvalancheScript {
  function run() external broadcast {
    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(0xD3DE4b3571744EB77946d65aBF01408902E92c4E);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231109_Multi_AllowEmergencyAdminToFreezeOnAaveV2/AllowEmergencyAdminToFreezeOnAaveV2_20231109.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](5);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(0x23AceD103f5E22bD22B9272c82f29C0E51abC5c2);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereumAmm = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereumAmm[0] = GovV3Helpers.buildAction(0xf75cBd975756C52aA7321d10E6aCA90e07835Dee);
    payloads[1] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereumAmm);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereumSentinel = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereumSentinel[0] = GovV3Helpers.buildAction(0x9441B65EE553F70df9C77d45d3283B6BC24F222d);
    payloads[2] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereumSentinel);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(0x1AA25FdD7d55FA8a401D6EFba8e48874Ef730E55);
    payloads[3] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsAvalanche = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsAvalanche[0] = GovV3Helpers.buildAction(0xD3DE4b3571744EB77946d65aBF01408902E92c4E);
    payloads[4] = GovV3Helpers.buildAvalanchePayload(vm, actionsAvalanche);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231109_Multi_AllowEmergencyAdminToFreezeOnAaveV2/AllowEmergencyAdminToFreezeOnAaveV2.md'
      )
    );
  }
}
