// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, BNBScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030} from './AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030.sol';

/**
 * @dev Deploy BNB
 * deploy-command: make deploy-ledger contract=src/20241030_AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain/OnboardWstETHToAaveV3OnBNBChain_20241030.s.sol:DeployBNB chain=bnb
 * verify-command: FOUNDRY_PROFILE=bnb npx catapulta-verify -b broadcast/OnboardWstETHToAaveV3OnBNBChain_20241030.s.sol/56/run-latest.json
 */
contract DeployBNB is BNBScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030).creationCode
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
 * command: make deploy-ledger contract=src/20241030_AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain/OnboardWstETHToAaveV3OnBNBChain_20241030.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBNB = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBNB[0] = GovV3Helpers.buildAction(
      type(AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain_20241030).creationCode
    );
    payloads[0] = GovV3Helpers.buildBNBPayload(vm, actionsBNB);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20241030_AaveV3BNB_OnboardWstETHToAaveV3OnBNBChain/OnboardWstETHToAaveV3OnBNBChain.md'
      )
    );
  }
}
