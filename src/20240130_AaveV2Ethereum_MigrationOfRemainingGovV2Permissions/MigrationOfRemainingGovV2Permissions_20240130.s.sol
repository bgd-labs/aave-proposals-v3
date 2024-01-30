// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130, AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130} from './AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/MigrationOfRemainingGovV2Permissions_20240130.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/MigrationOfRemainingGovV2Permissions_20240130.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    uint256 estimatedOnchainExecution = block.timestamp +
      5 days + // governance
      1 days + // executor delay
      1 days; // margin for error (delay on bridging/ time between payload deployment & proposal creation)

    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      abi.encodePacked(
        type(AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130).creationCode,
        abi.encode(address(0), 0) // TODO: replace with correct address
      )
    );

    address payload1 = GovV3Helpers.deployDeterministic(
      abi.encodePacked(
        type(AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130).creationCode,
        abi.encode(payload0)
      )
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions0 = new IPayloadsControllerCore.ExecutionAction[](1);
    actions0[0] = GovV3Helpers.buildAction(payload0);

    IPayloadsControllerCore.ExecutionAction[]
      memory actions1 = new IPayloadsControllerCore.ExecutionAction[](1);
    actions1[0] = GovV3Helpers.buildAction(payload1);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions0);
    GovV3Helpers.createPayload(actions1);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/MigrationOfRemainingGovV2Permissions_20240130.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum0 = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum0[0] = GovV3Helpers.buildAction(address(0)); // TODO: replace with part1
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum0);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum1 = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum1[0] = GovV3Helpers.buildAction(address(0)); // TODO: replace with part2
    payloads[1] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum1);
    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/MigrationOfRemainingGovV2Permissions.md'
      )
    );
  }
}
