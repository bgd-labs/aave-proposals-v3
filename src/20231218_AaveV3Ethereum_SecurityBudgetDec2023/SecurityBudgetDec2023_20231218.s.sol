// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vm} from 'forge-std/Vm.sol';
import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_SecurityBudgetDec2023_20231218} from './AaveV3Ethereum_SecurityBudgetDec2023_20231218.sol';

/**
 * deployment library so it's easier to use within tests
 */
library DeploymentHelper {
  function createPayloads() internal returns (uint40) {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_SecurityBudgetDec2023_20231218).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(payload0);

    // register action at payloadsController
    return GovV3Helpers.createPayload(actions);
  }

  function createProposal(Vm vm) internal returns (uint256) {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_SecurityBudgetDec2023_20231218).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    return
      GovV3Helpers.createProposal(
        vm,
        payloads,
        GovV3Helpers.ipfsHashFile(
          vm,
          'src/20231218_AaveV3Ethereum_SecurityBudgetDec2023/SecurityBudgetDec2023.md'
        )
      );
  }
}

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20231218_AaveV3Ethereum_SecurityBudgetDec2023/SecurityBudgetDec2023_20231218.s.sol:DeployEthereum chain=mainnet
 * verify-command: npx catapulta-verify -b broadcast/SecurityBudgetDec2023_20231218.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    DeploymentHelper.createPayloads();
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231218_AaveV3Ethereum_SecurityBudgetDec2023/SecurityBudgetDec2023_20231218.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external broadcast {
    DeploymentHelper.createProposal(vm);
  }
}
