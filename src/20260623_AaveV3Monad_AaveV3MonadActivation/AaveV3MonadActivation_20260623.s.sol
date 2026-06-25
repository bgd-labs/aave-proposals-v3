// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, MonadScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Monad_AaveV3MonadActivation_20260623} from './AaveV3Monad_AaveV3MonadActivation_20260623.sol';
import {AaveV3Monad_AaveV3MonadGHOListing_20260623} from './AaveV3Monad_AaveV3MonadGHOListing_20260623.sol';

/**
 * @dev Deploy Monad. Deploys the activation and the GHO listing as two distinct payloads with one
 *      action each. The GHO listing must be executed after the activation, which creates the
 *      syrupUSDC__Stablecoins and USDe_sUSDe__Stablecoins eModes it adds GHO to.
 * deploy-command: make deploy-ledger contract=src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3MonadActivation_20260623.s.sol:DeployMonad chain=monad
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV3MonadActivation_20260623.s.sol/143/run-latest.json
 */
contract DeployMonad is MonadScript {
  function run() external broadcast {
    // deploy payloads
    address activationPayload = GovV3Helpers.deployDeterministic(
      type(AaveV3Monad_AaveV3MonadActivation_20260623).creationCode
    );
    address ghoListingPayload = GovV3Helpers.deployDeterministic(
      type(AaveV3Monad_AaveV3MonadGHOListing_20260623).creationCode
    );

    // compose actions
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsActivation = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsActivation[0] = GovV3Helpers.buildAction(activationPayload);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsGHOListing = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsGHOListing[0] = GovV3Helpers.buildAction(ghoListingPayload);

    // register actions at payloadsController as two distinct payloads
    GovV3Helpers.createPayload(actionsActivation);
    GovV3Helpers.createPayload(actionsGHOListing);
  }
}

/**
 * @dev Create Proposal bundling the activation (payloads[0]) and the GHO listing (payloads[1]) as
 *      two separate Monad payloads. The GHO listing must be executed after the activation.
 * command: make deploy-ledger contract=src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3MonadActivation_20260623.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](2);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsActivation = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsActivation[0] = GovV3Helpers.buildAction(
        type(AaveV3Monad_AaveV3MonadActivation_20260623).creationCode
      );
      payloads[0] = GovV3Helpers.buildMonadPayload(vm, actionsActivation);
    }
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsGHOListing = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsGHOListing[0] = GovV3Helpers.buildAction(
        type(AaveV3Monad_AaveV3MonadGHOListing_20260623).creationCode
      );
      payloads[1] = GovV3Helpers.buildMonadPayload(vm, actionsGHOListing);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260623_AaveV3Monad_AaveV3MonadActivation/AaveV3MonadActivation.md'
      )
    );
  }
}
