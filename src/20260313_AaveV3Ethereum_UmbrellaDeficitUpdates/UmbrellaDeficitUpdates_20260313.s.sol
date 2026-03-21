// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313} from './AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313.sol';
import {AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313} from './AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20260313_AaveV3Ethereum_UmbrellaDeficitUpdates/UmbrellaDeficitUpdates_20260313.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UmbrellaDeficitUpdates_20260313.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313).creationCode
    );

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload1));
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20260313_AaveV3Ethereum_UmbrellaDeficitUpdates/UmbrellaDeficitUpdates_20260313.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_UmbrellaDeficitUpdates_Part_1_20260313).creationCode
      );
      payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsEthereum[0] = GovV3Helpers.buildAction(
        type(AaveV3Ethereum_UmbrellaDeficitUpdates_Part_2_20260313).creationCode
      );
      payloads[1] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260313_AaveV3Ethereum_UmbrellaDeficitUpdates/UmbrellaDeficitUpdates.md'
      )
    );
  }
}
