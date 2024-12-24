// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/src/GovV3Helpers.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {EthereumScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';
import {AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223} from './AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223.sol';
import {AaveV3EthereumLido_USDSInterestRateCurveUpdate_20241223} from './AaveV3EthereumLido_USDSInterestRateCurveUpdate_20241223.sol';

/**
 * @dev Deploy Ethereum
 * deploy-command: make deploy-ledger contract=src/20241223_Multi_USDSInterestRateCurveUpdate/USDSInterestRateCurveUpdate_20241223.s.sol:DeployEthereum chain=mainnet
 * verify-command: FOUNDRY_PROFILE=mainnet npx catapulta-verify -b broadcast/USDSInterestRateCurveUpdate_20241223.s.sol/1/run-latest.json
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223).creationCode
    );
    address payload1 = GovV3Helpers.deployDeterministic(
      type(AaveV3EthereumLido_USDSInterestRateCurveUpdate_20241223).creationCode
    );

    // compose action
    IPayloadsControllerCore.ExecutionAction[]
      memory actions = new IPayloadsControllerCore.ExecutionAction[](2);
    actions[0] = GovV3Helpers.buildAction(payload0);
    actions[1] = GovV3Helpers.buildAction(payload1);

    // register action at payloadsController
    GovV3Helpers.createPayload(actions);
  }
}

/**
 * @dev Create Proposal
 * command: make deploy-ledger contract=src/20241223_Multi_USDSInterestRateCurveUpdate/USDSInterestRateCurveUpdate_20241223.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsEthereum = new IPayloadsControllerCore.ExecutionAction[](2);
    actionsEthereum[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223).creationCode
    );
    actionsEthereum[1] = GovV3Helpers.buildAction(
      type(AaveV3EthereumLido_USDSInterestRateCurveUpdate_20241223).creationCode
    );
    payloads[0] = GovV3Helpers.buildMainnetPayload(vm, actionsEthereum);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20241223_Multi_USDSInterestRateCurveUpdate/USDSInterestRateCurveUpdate.md'
      )
    );
  }
}
