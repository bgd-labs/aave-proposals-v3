// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729} from './AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729.sol';
/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729).creationCode
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
 * command: make deploy-ledger contract=src/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/AaveV3EthereumLido_WETHLTV0AaveV3LidoInstance_20240729/WETHLTV0AaveV3LidoInstance.md'
      )
    );
  }
}
