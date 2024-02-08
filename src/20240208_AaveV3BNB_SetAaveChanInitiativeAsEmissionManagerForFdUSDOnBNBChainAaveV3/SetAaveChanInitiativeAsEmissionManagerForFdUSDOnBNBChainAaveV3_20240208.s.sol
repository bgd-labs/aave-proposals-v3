// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript, BNBScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208} from './AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208.sol';

/**
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20240208_AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3/SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208.s.sol:DeployBNB chain=bnb
 * verify-command: npx catapulta-verify -b broadcast/SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208)
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
 * command: make deploy-ledger contract=src/20240208_AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3/SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(
      type(AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208)
        .creationCode
    );
    payloads[0] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240208_AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3/SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3.md'
      )
    );
  }
}
