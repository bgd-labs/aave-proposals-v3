// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, SoneiumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Soneium_AaveV33SoneiumActivation_20250518} from './AaveV3Soneium_AaveV33SoneiumActivation_20250518.sol';

/**
 * @dev Deploy Soneium
 * deploy-command: make deploy-ledger contract=src/20250518_AaveV3Soneium_AaveV33SoneiumActivation/AaveV33SoneiumActivation_20250518.s.sol:DeploySoneium chain=soneium
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV33SoneiumActivation_20250518.s.sol/1868/run-latest.json
 */
contract DeploySoneium is SoneiumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Soneium_AaveV33SoneiumActivation_20250518).creationCode
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
 * command: make deploy-ledger contract=src/20250518_AaveV3Soneium_AaveV33SoneiumActivation/AaveV33SoneiumActivation_20250518.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsSoneium = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsSoneium[0] = GovV3Helpers.buildAction(
      type(AaveV3Soneium_AaveV33SoneiumActivation_20250518).creationCode
    );
    payloads[0] = GovV3Helpers.buildSoneiumPayload(vm, actionsSoneium);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250518_AaveV3Soneium_AaveV33SoneiumActivation/AaveV33SoneiumActivation.md'
      )
    );
  }
}
