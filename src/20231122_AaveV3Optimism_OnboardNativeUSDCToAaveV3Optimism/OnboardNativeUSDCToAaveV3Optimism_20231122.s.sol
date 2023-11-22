// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {EthereumScript, OptimismScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122} from './AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122.sol';

/**
 * @dev Deploy Optimism
 * command: make deploy-ledger contract=src/20231122_AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism/OnboardNativeUSDCToAaveV3Optimism_20231122.s.sol:DeployOptimism chain=optimism
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122 payload0 = new AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122();

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
 * command: make deploy-ledger contract=src/20231122_AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism/OnboardNativeUSDCToAaveV3Optimism_20231122.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(0x41DaCfA8Bc41221F46c780fD6469dAD4CDCceF83);
    payloads[0] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal2_5(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231122_AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism/OnboardNativeUSDCToAaveV3Optimism.md'
      )
    );
  }
}
