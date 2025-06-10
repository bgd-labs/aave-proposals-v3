// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, CeloScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515} from './AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515.sol';

/**
 * @dev Deploy Celo
 * deploy-command: make deploy-ledger contract=src/20250515_AaveV3Celo_OnboardingWETHToAaveV3CeloInstance/OnboardingWETHToAaveV3CeloInstance_20250515.s.sol:DeployCelo chain=celo
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/OnboardingWETHToAaveV3CeloInstance_20250515.s.sol/42220/run-latest.json
 */
contract DeployCelo is CeloScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515).creationCode
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
 * command: make deploy-ledger contract=src/20250515_AaveV3Celo_OnboardingWETHToAaveV3CeloInstance/OnboardingWETHToAaveV3CeloInstance_20250515.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsCelo = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsCelo[0] = GovV3Helpers.buildAction(
      type(AaveV3Celo_OnboardingWETHToAaveV3CeloInstance_20250515).creationCode
    );
    payloads[0] = GovV3Helpers.buildCeloPayload(vm, actionsCelo);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250515_AaveV3Celo_OnboardingWETHToAaveV3CeloInstance/OnboardingWETHToAaveV3CeloInstance.md'
      )
    );
  }
}
