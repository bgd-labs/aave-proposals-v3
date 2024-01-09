// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import {EthereumScript} from 'aave-helpers/ScriptUtils.sol';
import {AaveV3Ethereum_AaveFundingUpdates_20231106} from './AaveV3Ethereum_AaveFundingUpdates_20231106.sol';

/**
 * @dev Deploy Ethereum
 * command: make deploy-ledger contract=src/20231106_AaveV3Ethereum_AaveFundingUpdates/AaveFundingUpdates_20231106.s.sol:DeployEthereum chain=mainnet
 */
contract DeployEthereum is EthereumScript {
  function run() external broadcast {
    // deploy payloads
    address payload0 = GovV3Helpers.deployDeterministic(
      type(AaveV3Ethereum_AaveFundingUpdates_20231106).creationCode
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
 * command: make deploy-ledger contract=src/20231106_AaveV3Ethereum_AaveFundingUpdates/AaveFundingUpdates_20231106.s.sol:CreateProposal chain=mainnet
 */
contract CreateProposal is EthereumScript {
  function run() external {
    // create payloads
    PayloadsControllerUtils.Payload[] memory payloads = new PayloadsControllerUtils.Payload[](1);

    // compose actions for validation
    IPayloadsControllerCore.ExecutionAction[]
      memory actionsPolygon = new IPayloadsControllerCore.ExecutionAction[](1);
    actionsPolygon[0] = GovV3Helpers.buildAction(
      type(AaveV3Ethereum_AaveFundingUpdates_20231106).creationCode
    );
    payloads[0] = GovV3Helpers.buildPolygonPayload(vm, actionsPolygon);

    // create proposal
    vm.startBroadcast();
    GovV3Helpers.createProposal(
      vm,
      payloads,
      GovV3Helpers.ipfsHashFile(
        vm,
        'src/20231106_AaveV3Ethereum_AaveFundingUpdates/AaveFundingUpdates.md'
      )
    );
  }
}
