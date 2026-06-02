// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513} from './AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20260513_AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4/RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513).creationCode
    );

    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20260513_AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4/RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260513_AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4/RenewLlamaRiskAsRiskServiceProviderEpoch4.md'
      )
    );
  }
}
