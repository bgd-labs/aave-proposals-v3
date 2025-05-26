// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';

import {AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515} from './AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515.sol';
import {AaveV3Ethereum_RobotActivation_20250515} from './AaveV3Ethereum_RobotActivation_20250515.sol';
import {AaveV3Ethereum_UmbrellaActivation_20250515} from './AaveV3Ethereum_UmbrellaActivation_20250515.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20250515_AaveV3Ethereum_UmbrellaActivation/UmbrellaActivation_20250515.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/UmbrellaActivation_20250515.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_UmbrellaActivation_20250515).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515).creationCode
    );
    address payload2 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_RobotActivation_20250515).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](3);

    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(payload1);
    actions[2] = GovV3Helpers.buildAction(payload2);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20250515_AaveV3Ethereum_UmbrellaActivation/UmbrellaActivation_20250515.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](3);

    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_UmbrellaActivation_20250515).creationCode
    );
    actionsEthereum[1] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_SafetyModuleRewardsDecrease_20250515).creationCode
    );
    actionsEthereum[2] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_RobotActivation_20250515).creationCode
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
        'src/20250515_AaveV3Ethereum_UmbrellaActivation/UmbrellaActivation.md'
      )
    );
  }
}
