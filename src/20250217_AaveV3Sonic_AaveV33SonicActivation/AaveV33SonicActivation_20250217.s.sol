// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Sonic} from 'aave-address-book/GovernanceV3Sonic.sol';
import {EthereumScript, SonicScript, ChainIds} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Sonic_AaveV33SonicActivation_20250217} from './AaveV3Sonic_AaveV33SonicActivation_20250217.sol';

/**
 * @dev Deploy Sonic
 * deploy-command: make deploy-ledger contract=src/20250217_AaveV3Sonic_AaveV33SonicActivation/AaveV33SonicActivation_20250217.s.sol:DeploySonic chain=sonic
 * verify-command: FOUNDRY_PROFILE=sonic npx catapulta-verify -b broadcast/AaveV33SonicActivation_20250217.s.sol/146/run-latest.json
 */
contract DeploySonic is SonicScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Sonic_AaveV33SonicActivation_20250217).creationCode
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
 * command: make deploy-ledger contract=src/20250217_AaveV3Sonic_AaveV33SonicActivation/AaveV33SonicActivation_20250217.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    payloads[0] = PayloadsControllerUtils.Payload({
      chain: ChainIds.SONIC,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3Sonic.PAYLOADS_CONTROLLER),
      payloadId: 0
    });

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250217_AaveV3Sonic_AaveV33SonicActivation/AaveV33SonicActivation.md'
      )
    );
  }
}
