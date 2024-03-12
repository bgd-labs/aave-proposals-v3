// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';

abstract contract WithPayloads {
  struct ActionsPerChain {
    string chainName;
    bytes[] actionCode;
  }

  function getActions() public view virtual returns (ActionsPerChain[] memory);
}

abstract contract DeployPayloads is WithPayloads, Script {
  function isChainSupported(string memory chain) public view virtual returns (bool);

  function run() external {
    ActionsPerChain[] memory actionsPerChain = getActions();

    for (uint256 i = 0; i < actionsPerChain.length; i++) {
      ActionsPerChain memory rawActions = actionsPerChain[i];

      // if actions belongs to the network we should not deploy, skip
      if (!isChainSupported(rawActions.chainName)) continue;
      require(rawActions.actionCode.length != 0, 'should be at least one payload action per chain');

      vm.rpcUrl(rawActions.chainName);
      // TODO: after rpc switch we should be checking that chainId is the one we expect, just in case
      vm.startBroadcast();

      // compose actions
      IPayloadsControllerCore.ExecutionAction[]
        memory composedActions = new IPayloadsControllerCore.ExecutionAction[](
          rawActions.actionCode.length
        );
      // deploy payloads
      for (uint256 j = 0; j < rawActions.actionCode.length; j++) {
        composedActions[j] = GovV3Helpers.buildAction(
          GovV3Helpers.deployDeterministic(rawActions.actionCode[j])
        );
      }

      // register actions at payloadsController
      GovV3Helpers.createPayload(composedActions);
      vm.stopBroadcast();
    }
  }
}

// not so applicable atm, because requires solid multiChan support, but for the good future
abstract contract DeployPayloadsMultiChain is DeployPayloads {
  mapping(bytes32 => bool) internal _supportedChain;

  constructor(string[] memory supportedChains) {
    for (uint256 i = 0; i < supportedChains.length; i++) {
      _supportedChain[keccak256(bytes(supportedChains[i]))] = true;
    }
  }

  function isChainSupported(string memory chain) public view override returns (bool) {
    return _supportedChain[keccak256(bytes(chain))];
  }
}

abstract contract DeployPayloadsSingleChain is DeployPayloads {
  string public supportedChain;

  constructor(string memory chainName) {
    supportedChain = chainName;
  }

  function isChainSupported(string memory chain) public view override returns (bool) {
    return keccak256(bytes(chain)) == keccak256(bytes(supportedChain));
  }
}

abstract contract DeployPayloadsEthereum is DeployPayloadsSingleChain('ethereum') {}

abstract contract DeployPayloadsPolygon is DeployPayloadsSingleChain('polygon') {}

abstract contract CreateProposal is WithPayloads, Script {
  string internal _ipfsFilePath;

  // TODO: I would make it more human readable with params: date, name, isMulti(?) and generation of the actual string
  constructor(string memory ipfsFilePath) {
    _ipfsFilePath = ipfsFilePath;
  }

  function run() external {
    ActionsPerChain[] memory actionsPerChain = getActions();

    // create payloads
    PayloadsControllerUtils.Payload[] memory payloadsPinned = new PayloadsControllerUtils.Payload[](
      actionsPerChain.length
    );

    for (uint256 i = 0; i < actionsPerChain.length; i++) {
      ActionsPerChain memory rawActions = actionsPerChain[i];
      vm.rpcUrl(rawActions.chainName);

      IPayloadsControllerCore.ExecutionAction[]
        memory actions = new IPayloadsControllerCore.ExecutionAction[](
          rawActions.actionCode.length
        );

      for (uint256 j = 0; j < rawActions.actionCode.length; j++) {
        actions[j] = GovV3Helpers.buildAction(rawActions.actionCode[j]);
      }
      payloadsPinned[i] = GovV3Helpers._buildPayload(vm, block.chainid, actions);
    }

    // create proposal
    vm.rpcUrl('ethereum');
    // TODO: after rpc switch we should be checking that chainId is the one we expect, just in case
    vm.startBroadcast();
    GovV3Helpers.createProposal(vm, payloadsPinned, GovV3Helpers.ipfsHashFile(vm, _ipfsFilePath));
    vm.stopBroadcast();
  }
}
