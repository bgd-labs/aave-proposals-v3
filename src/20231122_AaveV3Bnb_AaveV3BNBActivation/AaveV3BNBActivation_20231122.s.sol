// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, BNBScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Bnb_AaveV3BNBActivation_20231122} from './AaveV3Bnb_AaveV3BNBActivation_20231122.sol';

/**
 * @dev Deploy Bnb
 * command: make deploy-ledger contract=src/20231122_AaveV3Bnb_AaveV3BNBActivation/AaveV3BNBActivation_20231122.s.sol:DeployBnb chain=bnb
 */
contract DeployBnb is BNBScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Bnb_AaveV3BNBActivation_20231122 payload0 = new AaveV3Bnb_AaveV3BNBActivation_20231122();

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
 * command: make deploy-ledger contract=src/20231122_AaveV3Bnb_AaveV3BNBActivation/AaveV3BNBActivation_20231122.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBnb = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBnb[0] = GovV3Helpers.buildAction(address(0));
    payloads[0] = GovV3Helpers.buildBNBPayload(vm, actionsBnb);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231122_AaveV3Bnb_AaveV3BNBActivation/AaveV3BNBActivation.md'
      )
    );
  }
}
