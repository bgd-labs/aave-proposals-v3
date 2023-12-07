// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203} from './AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231203_AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum/ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203 payload0 = new AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203();

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
 * command: make deploy-ledger contract=src/20231203_AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum/ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(0xBE90E16CA2f6d2e0b828164Ef644f189d24D91bA);
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231203_AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum/ChaosLabsRFAndIRUpdatesAaveV2Ethereum.md'
      )
    );
  }
}
