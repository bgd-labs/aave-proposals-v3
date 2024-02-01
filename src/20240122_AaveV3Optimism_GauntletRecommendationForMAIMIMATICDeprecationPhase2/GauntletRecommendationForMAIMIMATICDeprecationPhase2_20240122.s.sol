// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, OptimismScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Optimism_GauntletRecommendationForMAIMIMATICDeprecationPhase2_20240122} from './AaveV3Optimism_GauntletRecommendationForMAIMIMATICDeprecationPhase2_20240122.sol';

/**
 * @dev Deploy Optimism
 * deploy-command: make deploy-ledger contract=src/20240122_AaveV3Optimism_GauntletRecommendationForMAIMIMATICDeprecationPhase2/GauntletRecommendationForMAIMIMATICDeprecationPhase2_20240122.s.sol:DeployOptimism chain=optimism
 * verify-command: npx catapulta-verify -b broadcast/GauntletRecommendationForMAIMIMATICDeprecationPhase2_20240122.s.sol/10/run-latest.json
 */
contract DeployOptimism is OptimismScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Optimism_GauntletRecommendationForMAIMIMATICDeprecationPhase2_20240122)
        .creationCode
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
 * command: make deploy-ledger contract=src/20240122_AaveV3Optimism_GauntletRecommendationForMAIMIMATICDeprecationPhase2/GauntletRecommendationForMAIMIMATICDeprecationPhase2_20240122.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsOptimism = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsOptimism[0] = GovV3Helpers.buildAction(
      type(AaveV3Optimism_GauntletRecommendationForMAIMIMATICDeprecationPhase2_20240122)
        .creationCode
    );
    payloads[0] = GovV3Helpers.buildOptimismPayload(vm, actionsOptimism);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240122_AaveV3Optimism_GauntletRecommendationForMAIMIMATICDeprecationPhase2/GauntletRecommendationForMAIMIMATICDeprecationPhase2.md'
      )
    );
  }
}
