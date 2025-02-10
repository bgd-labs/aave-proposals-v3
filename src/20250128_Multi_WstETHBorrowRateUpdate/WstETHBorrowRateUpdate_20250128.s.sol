// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3ZkSync} from 'aave-address-book/GovernanceV3ZkSync.sol';
import {EthereumScript, ArbitrumScript, BaseScript, ScrollScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128} from './AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128.sol';
import {AaveV3Base_WstETHBorrowRateUpdate_20250128} from './AaveV3Base_WstETHBorrowRateUpdate_20250128.sol';
import {AaveV3Scroll_WstETHBorrowRateUpdate_20250128} from './AaveV3Scroll_WstETHBorrowRateUpdate_20250128.sol';

/**
 * @dev Deploy Arbitrum
 * deploy-command: make deploy-ledger contract=src/20250128_Multi_WstETHBorrowRateUpdate/WstETHBorrowRateUpdate_20250128.s.sol:DeployArbitrum chain=arbitrum
 * verify-command: FOUNDRY_PROFILE=arbitrum npx catapulta-verify -b broadcast/WstETHBorrowRateUpdate_20250128.s.sol/42161/run-latest.json
 */
contract DeployArbitrum is ArbitrumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128).creationCode
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
 * @dev Deploy Base
 * deploy-command: make deploy-ledger contract=src/20250128_Multi_WstETHBorrowRateUpdate/WstETHBorrowRateUpdate_20250128.s.sol:DeployBase chain=base
 * verify-command: FOUNDRY_PROFILE=base npx catapulta-verify -b broadcast/WstETHBorrowRateUpdate_20250128.s.sol/8453/run-latest.json
 */
contract DeployBase is BaseScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Base_WstETHBorrowRateUpdate_20250128).creationCode
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
 * @dev Deploy Scroll
 * deploy-command: make deploy-ledger contract=src/20250128_Multi_WstETHBorrowRateUpdate/WstETHBorrowRateUpdate_20250128.s.sol:DeployScroll chain=scroll
 * verify-command: FOUNDRY_PROFILE=scroll npx catapulta-verify -b broadcast/WstETHBorrowRateUpdate_20250128.s.sol/534352/run-latest.json
 */
contract DeployScroll is ScrollScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Scroll_WstETHBorrowRateUpdate_20250128).creationCode
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
 * command: make deploy-ledger contract=src/20250128_Multi_WstETHBorrowRateUpdate/WstETHBorrowRateUpdate_20250128.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](4);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsArbitrum = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsArbitrum[0] = GovV3Helpers.buildAction(
      type(AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128).creationCode
    );
    payloads[0] = GovV3Helpers.buildArbitrumPayload(vm, actionsArbitrum);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsBase = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsBase[0] = GovV3Helpers.buildAction(
      type(AaveV3Base_WstETHBorrowRateUpdate_20250128).creationCode
    );
    payloads[1] = GovV3Helpers.buildBasePayload(vm, actionsBase);

    IPayloadsControllerCore.ExecutionAction[]
      memory actionsScroll = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsScroll[0] = GovV3Helpers.buildAction(
      type(AaveV3Scroll_WstETHBorrowRateUpdate_20250128).creationCode
    );
    payloads[2] = GovV3Helpers.buildScrollPayload(vm, actionsScroll);

    payloads[3] = PayloadsControllerUtils.Payload({
      chain: 324,
      accessLevel: PayloadsControllerUtils.AccessControl.Level_1,
      payloadsController: address(GovernanceV3ZkSync.PAYLOADS_CONTROLLER),
      payloadId: 14
    });

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20250128_Multi_WstETHBorrowRateUpdate/WstETHBorrowRateUpdate.md'
      )
    );
  }
}
