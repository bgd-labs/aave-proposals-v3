// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, SonicScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Sonic_StSLoopIncentiveProgram_20250711} from './AaveV3Sonic_StSLoopIncentiveProgram_20250711.sol';

/**
 * @dev Deploy Sonic
 * deploy-command: make deploy-ledger contract=src/20250711_AaveV3Sonic_StSLoopIncentiveProgram/StSLoopIncentiveProgram_20250711.s.sol:DeploySonic chain=sonic
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/StSLoopIncentiveProgram_20250711.s.sol/146/run-latest.json
 */
contract DeploySonic is SonicScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Sonic_StSLoopIncentiveProgram_20250711).creationCode
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
 * command: make deploy-ledger contract=src/20250711_AaveV3Sonic_StSLoopIncentiveProgram/StSLoopIncentiveProgram_20250711.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsSonic = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsSonic[0] = GovV3Helpers.buildAction(
        type(AaveV3Sonic_StSLoopIncentiveProgram_20250711).creationCode
      );
      payloads[0] = GovV3Helpers.buildSonicPayload(vm, actionsSonic);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250711_AaveV3Sonic_StSLoopIncentiveProgram/StSLoopIncentiveProgram.md'
      )
    );
  }
}
