// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, MonadScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Monad_AaveV3MonadGHOListing_20260623} from './AaveV3Monad_AaveV3MonadGHOListing_20260623.sol';

/**
 * @dev Deploy & propose only after AaveV3MonadActivation_20260623 has executed
 *      (the Maple_syrupUSDC and Liquid_Leverage eModes must already exist).
 * @dev Deploy Monad
 * deploy-command: make deploy-ledger contract=src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3MonadGHOListing_20260623.s.sol:DeployMonadGHOListing chain=monad
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV3MonadGHOListing_20260623.s.sol/143/run-latest.json
 */
contract DeployMonadGHOListing is MonadScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Monad_AaveV3MonadGHOListing_20260623).creationCode
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
 * command: make deploy-ledger contract=src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3MonadGHOListing_20260623.s.sol:CreateProposalGHOListing chain=mainnet
 */
contract CreateProposalGHOListing is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMonad = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMonad[0] = GovV3Helpers.buildAction(
        type(AaveV3Monad_AaveV3MonadGHOListing_20260623).creationCode
      );
      payloads[0] = GovV3Helpers.buildMonadPayload(vm, actionsMonad);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3MonadGHOListing.md'
      )
    );
  }
}
