// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, BaseScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127} from './AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127.sol';

/**
 * @dev Deploy Base
 * command: make deploy-ledger contract=src/20231127_AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork/OnboardingWstETHToAaveV3OnBaseNetwork_20231127.s.sol:DeployBase chain=base
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127 payload0 = new AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127();

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](1);
    actions[0] = GovV3Helpers.buildAction(address(payload0));

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20231127_AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork/OnboardingWstETHToAaveV3OnBaseNetwork_20231127.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(0x3b0b255e648D6680a6cf1A5aF92c73240e13C69d);
    payloads[0] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231127_AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork/OnboardingWstETHToAaveV3OnBaseNetwork.md'
      )
    );
  }
}
