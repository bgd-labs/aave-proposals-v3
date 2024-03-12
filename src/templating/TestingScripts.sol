// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CommonTestBase, Vm} from 'aave-helpers/CommonTestBase.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';

import {WithPayloads} from './DeploymentScripts.sol';

abstract contract TestPayloadsBase is CommonTestBase, WithPayloads {
  function executeNetworkPayloads(Vm vm, string memory network) internal {
    ActionsPerChain[] memory actionsPerChain = getActions();

    for (uint256 i = 0; i < actionsPerChain.length; i++) {
      if (keccak256(bytes(actionsPerChain[i].chainName)) == keccak256(bytes(network))) {
        ActionsPerChain memory rawActions = actionsPerChain[i];

        for (uint256 j = 0; j < rawActions.actionCode.length; j++) {
          GovV3Helpers.executePayload(
            vm,
            GovV3Helpers.deployDeterministic(rawActions.actionCode[j])
          );
        }
      }
    }
  }
}
