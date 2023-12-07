// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum_GhoIncidentReport_20231113} from './AaveV3Ethereum_GhoIncidentReport_20231113.sol';
import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

/**
 * @dev Deploy AaveV3Ethereum_GhoIncidentReport_20231113
 * command: make deploy-ledger contract=src/20231207_AaveV3Ethereum_GhoIncidentReport_20231126/AaveV3Ethereum_GhoIncidentReport_20231113.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  address constant NEW_VGHO_IMPL = 0x20Cb2f303EDe313e2Cc44549Ad8653a5E8c0050e;

  function run() external broadcast {
    // deploy payloads
    AaveV3Ethereum_GhoIncidentReport_20231113 payload = new AaveV3Ethereum_GhoIncidentReport_20231113();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231207_AaveV3Ethereum_GhoIncidentReport_20231126/AaveV3Ethereum_GhoIncidentReport_20231113.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(0xbC9ffee8d18d75a412474B92192257d3c18471FF);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231207_AaveV3Ethereum_GhoIncidentReport_20231126/AaveV3Ethereum_GhoIncidentReport_20231113.md'
      )
    );
  }
}
