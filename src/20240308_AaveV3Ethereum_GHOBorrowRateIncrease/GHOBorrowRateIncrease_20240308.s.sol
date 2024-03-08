// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_GHOBorrowRateIncrease_20240308} from './AaveV3Ethereum_GHOBorrowRateIncrease_20240308.sol';
import {GhoInterestRateStrategy} from './GhoInterestRateStrategy.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240308_AaveV3Ethereum_GHOBorrowRateIncrease/GHOBorrowRateIncrease_20240308.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/GHOBorrowRateIncrease_20240308.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(type(GhoInterestRateStrategy).creationCode);
    address payload1 = GovV3Helpers.deployDeterministic(
      abi.encode(type(AaveV3Ethereum_GHOBorrowRateIncrease_20240308).creationCode, payload0)
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(payload1);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240308_AaveV3Ethereum_GHOBorrowRateIncrease/GHOBorrowRateIncrease_20240308.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    address payload0 = GovV3Helpers.deployDeterministic(type(GhoInterestRateStrategy).creationCode);
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      abi.encode(type(AaveV3Ethereum_GHOBorrowRateIncrease_20240308).creationCode, payload0)
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240308_AaveV3Ethereum_GHOBorrowRateIncrease/GHOBorrowRateIncrease.md'
      )
    );
  }
}
