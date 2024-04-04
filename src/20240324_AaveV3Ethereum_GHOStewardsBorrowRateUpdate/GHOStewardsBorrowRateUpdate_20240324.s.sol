// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';

import {AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324} from './AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324.sol';
import {GhoInterestRateStrategy} from './GhoInterestRateStrategy.sol';

/**
 * @dev Deploy InterestRateStrategy
 * deploy-command: make deploy-ledger contract=src/20240324_AaveV3Ethereum_GHOStewardsBorrowRateUpdate/GHOStewardsBorrowRateUpdate_20240324.s.sol:DeployInterestRateStrategy chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/GHOStewardsBorrowRateUpdate_20240324.s.sol/1/run-latest.json
 */
contract DeployInterestRateStrategy is EthereumScript {
  function run() external broadcast {
    // deploy ir
    GovV3Helpers.deployDeterministic(type(GhoInterestRateStrategy).creationCode);
  }
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240324_AaveV3Ethereum_GHOStewardsBorrowRateUpdate/GHOStewardsBorrowRateUpdate_20240324.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/GHOStewardsBorrowRateUpdate_20240324.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324).creationCode,
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
 * command: make deploy-ledger contract=src/20240324_AaveV3Ethereum_GHOStewardsBorrowRateUpdate/GHOStewardsBorrowRateUpdate_20240324.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    address strategy = GovV3Helpers.predictDeterministicAddress(
      type(GhoInterestRateStrategy).creationCode
    );
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324).creationCode,
      abi.encode(strategy)
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240324_AaveV3Ethereum_GHOStewardsBorrowRateUpdate/GHOStewardsBorrowRateUpdate.md'
      )
    );
  }
}
