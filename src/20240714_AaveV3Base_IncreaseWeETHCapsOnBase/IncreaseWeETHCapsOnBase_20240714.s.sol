// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript, BaseScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Base_IncreaseWeETHCapsOnBase_20240714} from './AaveV3Base_IncreaseWeETHCapsOnBase_20240714.sol';

/**
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20240714_AaveV3Base_IncreaseWeETHCapsOnBase/IncreaseWeETHCapsOnBase_20240714.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=base npx catapulta-verify -b broadcast/IncreaseWeETHCapsOnBase_20240714.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_IncreaseWeETHCapsOnBase_20240714).creationCode
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
 * command: make deploy-ledger contract=src/20240714_AaveV3Base_IncreaseWeETHCapsOnBase/IncreaseWeETHCapsOnBase_20240714.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(AaveV3Base_IncreaseWeETHCapsOnBase_20240714).creationCode
    );
    payloads[0] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20240714_AaveV3Base_IncreaseWeETHCapsOnBase/IncreaseWeETHCapsOnBase.md'
      )
    );
  }
}
