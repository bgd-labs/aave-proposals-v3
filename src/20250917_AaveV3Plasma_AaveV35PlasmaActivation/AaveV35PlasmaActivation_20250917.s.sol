// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, PlasmaScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Plasma_AaveV35PlasmaActivation_20250917} from './AaveV3Plasma_AaveV35PlasmaActivation_20250917.sol';

/**
 * @dev Deploy Plasma
 * deploy-command: make deploy-ledger contract=src/20250917_AaveV3Plasma_AaveV35PlasmaActivation/AaveV35PlasmaActivation_20250917.s.sol:DeployPlasma chain=plasma
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV35PlasmaActivation_20250917.s.sol/9745/run-latest.json
 */
contract DeployPlasma is PlasmaScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Plasma_AaveV35PlasmaActivation_20250917).creationCode
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
 * command: make deploy-ledger contract=src/20250917_AaveV3Plasma_AaveV35PlasmaActivation/AaveV35PlasmaActivation_20250917.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsPlasma = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsPlasma[0] = GovV3Helpers.buildAction(
        type(AaveV3Plasma_AaveV35PlasmaActivation_20250917).creationCode
      );
      payloads[0] = GovV3Helpers.buildPlasmaPayload(vm, actionsPlasma);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250917_AaveV3Plasma_AaveV35PlasmaActivation/AaveV35PlasmaActivation.md'
      )
    );
  }
}
