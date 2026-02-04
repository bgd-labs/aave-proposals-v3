// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {EthereumScript, MegaEthScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3MegaEth_AaveV36MegaETHActivation_20260128} from './AaveV3MegaEth_AaveV36MegaETHActivation_20260128.sol';

/**
 * @dev Deploy MegaEth
 * deploy-command: make deploy-ledger contract=src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV36MegaETHActivation_20260128.s.sol:DeployMegaEth chain=megaeth
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/AaveV36MegaETHActivation_20260128.s.sol/4326/run-latest.json
 */
contract DeployMegaEth is MegaEthScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3MegaEth_AaveV36MegaETHActivation_20260128).creationCode
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
 * command: make deploy-ledger contract=src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV36MegaETHActivation_20260128.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    {
      IPayloadsControllerCore.ExecutionAction[]
        memory actionsMegaEth = new IPayloadsControllerCore.ExecutionAction[](1);
      actionsMegaEth[0] = GovV3Helpers.buildAction(
        type(AaveV3MegaEth_AaveV36MegaETHActivation_20260128).creationCode
      );
      payloads[0] = GovV3Helpers.buildMegaEthPayload(vm, actionsMegaEth);
    }

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20260128_AaveV3MegaEth_AaveV36MegaETHActivation/AaveV36MegaETHActivation.md'
      )
    );
  }
}
