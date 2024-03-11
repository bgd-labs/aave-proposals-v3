// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_GHOBorrowRateIncrease_20240308} from './AaveV3Ethereum_GHOBorrowRateIncrease_20240308.sol';
import {GhoInterestRateStrategy} from './GhoInterestRateStrategy.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240308_AaveV3Ethereum_GHOBorrowRateIncrease/GHOBorrowRateIncrease_20240308.s.sol:DeployInterestRateStrategy chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/GHOBorrowRateIncrease_20240308.s.sol/1/run-latest.json
 */
contract DeployInterestRateStrategy is EthereumScript {
  function run() external broadcast {
    // deploy ir
    GovV3Helpers.deployDeterministic(type(GhoInterestRateStrategy).creationCode);
  }
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240308_AaveV3Ethereum_GHOBorrowRateIncrease/GHOBorrowRateIncrease_20240308.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/GHOBorrowRateIncrease_20240308.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_GHOBorrowRateIncrease_20240308).creationCode,
      abi.encode(
        GovV3Helpers.predictDeterministicAddress(type(GhoInterestRateStrategy).creationCode)
      )
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
 * command: make deploy-ledger contract=src/20240308_AaveV3Ethereum_GHOBorrowRateIncrease/GHOBorrowRateIncrease_20240308.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    address ghoIr = GovV3Helpers.predictDeterministicAddress(
      type(GhoInterestRateStrategy).creationCode
    );
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_GHOBorrowRateIncrease_20240308).creationCode,
      abi.encode(ghoIr)
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
