// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423} from './AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423.sol';
import {AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423} from './AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423.sol';
import {AaveV3Ethereum_ActivateAGRS_20250423} from './AaveV3Ethereum_ActivateAGRS_20250423.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance_20250423.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance_20250423.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423).creationCode
    );
    address payload2 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_ActivateAGRS_20250423).creationCode
    );

    // register action at payloadsController
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload0));
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload1));
    GovV3Helpers.createPayload(GovV3Helpers.buildAction(payload2));
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance_20250423.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](3);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction memory action0 = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423).creationCode
    );
    IPayloadsControllerCore.ExecutionAction memory action1 = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423).creationCode
    );
    IPayloadsControllerCore.ExecutionAction memory action2 = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_ActivateAGRS_20250423).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, action0);
    payloads[1] = GovV3Helpers.buildMainnetPayload(vm, action1);
    payloads[2] = GovV3Helpers.buildMainnetPayload(vm, action2);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance.md'
      )
    );
  }
}
