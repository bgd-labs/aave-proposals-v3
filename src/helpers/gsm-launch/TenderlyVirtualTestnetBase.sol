// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';

import {GovNetworks} from './GovNetworks.sol';

interface IExecutor {
  function executeTransaction(
    address target,
    uint256 value,
    string memory signature,
    bytes memory data,
    bool withDelegateCall
  ) external payable returns (bytes memory);
}

abstract contract TenderlyVirtualTestnetBase is Script {
  /// @dev Random deployer address on Virtual Testnet
  address internal constant DEPLOYER = 0xDE910C0000000000000000000000000000000001;

  /// @dev String representation of the current fork
  string internal currentFork;

  /// Send a transaction ON the VirtualTestnet as `from` (no key needed — Admin RPC
  /// impersonation). Returns the tx hash.
  /// @return The transaction hash
  function _rpcSendAs(address from, address to, bytes memory data) internal returns (bytes32) {
    bytes memory response = vm.rpc(
      'eth_sendTransaction',
      string.concat(
        '[{"from":"',
        vm.toString(from),
        '","to":"',
        vm.toString(to),
        '","data":"',
        vm.toString(data),
        '"}]'
      )
    );
    return _toBytes32(response);
  }

  /// Variant for contract CREATION
  function _rpcDeployAs(address from, bytes memory creationCode) internal returns (bytes32 txHash) {
    bytes memory response = vm.rpc(
      'eth_sendTransaction',
      string.concat('[{"from":"', vm.toString(from), '","data":"', vm.toString(creationCode), '"}]')
    );
    return _toBytes32(response);
  }

  /// Deploy `creationCode` on the CURRENTLY selected VirtualTestnet as `deployer`.
  /// Address is computed from the deployer's on-VirtualTestnet nonce (CREATE semantics),
  /// then verified to actually contain code after a fresh re-fork.
  function _deployOnVirtualTestnet(
    bytes memory creationCode,
    address deployer
  ) internal returns (address) {
    // 1. read the deployer's CURRENT nonce from the VirtualTestnet itself
    bytes memory nonceResponse = vm.rpc(
      'eth_getTransactionCount',
      string.concat('["', vm.toString(deployer), '","latest"]')
    );
    uint256 nonce = _toUint(nonceResponse);

    // 2. CREATE address = f(sender, nonce) — deterministic
    address deployed = vm.computeCreateAddress(deployer, nonce);

    // 3. fire the creation tx (impersonated, no key)
    _rpcDeployAs(deployer, creationCode);

    // 4. verify against FRESH VirtualTestnet state — never trust without reading back
    _reforkCurrent();
    require(deployed.code.length > 0, 'VirtualTestnet deploy failed: no code at computed address');

    return deployed;
  }

  /// Deploy a payload on `network`'s VirtualTestnet
  function _deployPayloadOn(
    GovNetworks.GovNetwork memory network,
    bytes memory creationCode
  ) internal returns (address) {
    _refork(network.rpcAlias);
    _fund(DEPLOYER);

    return _deployOnVirtualTestnet(creationCode, DEPLOYER);
  }

  /// Execute a payload production-faithfully:
  /// PayloadsController → Executor.executeTransaction(payload, delegatecall)
  function _executePayloadOn(GovNetworks.GovNetwork memory network, address payload) internal {
    _refork(network.rpcAlias);
    _fund(network.payloadsController);
    bytes memory data = abi.encodeCall(
      IExecutor.executeTransaction,
      (payload, 0, 'execute()', '', true)
    );
    _rpcSendAs(network.payloadsController, network.executor, data);
  }

  /// Override in your test: read state on the CURRENTLY selected fork and
  /// return whether the cross-chain effect has landed.
  function _isDelivered() internal view virtual returns (bool);

  function _pollUntilDelivered(string memory rpcAlias, uint256 maxIters, uint256 sleepMs) internal {
    for (uint256 i = 0; i < maxIters; i++) {
      _refork(rpcAlias); // fresh VirtualTestnet state every iteration
      if (_isDelivered()) return;
      vm.sleep(sleepMs);
    }
    revert('Cross-chain message never delivered by relay');
  }

  // Helper Functions

  function _fund(address who) internal {
    vm.rpc(
      'tenderly_setBalance',
      string.concat('[["', vm.toString(who), '"], "0xDE0B6B3A7640000"]')
    );
  }

  function _refork(string memory fork) internal {
    currentFork = fork;
    try vm.createFork(vm.rpcUrl(fork)) returns (uint256 id) {
      vm.selectFork(id);
    } catch {
      vm.sleep(2000);
      vm.selectFork(vm.createFork(vm.rpcUrl(fork)));
    }
  }

  function _reforkCurrent() internal {
    require(bytes(currentFork).length != 0, 'no fork selected: use _refork');
    _refork(currentFork);
  }

  function _increaseTime(uint256 inSeconds) internal {
    // plain JSON number, no quotes, no hex — verified via curl
    vm.rpc('evm_increaseTime', string.concat('[', vm.toString(inSeconds), ']'));
  }

  // Snapshot Environment

  function _snapshotLifecycle(string[] memory aliases, string memory snapDir) internal {
    if (!vm.exists(snapDir)) vm.createDir(snapDir, true);

    for (uint256 i = 0; i < aliases.length; i++) {
      string memory path = string.concat(snapDir, '/.snap_', aliases[i]);
      string memory id = _readSnap(path);
      if (bytes(id).length != 0) _revertTo(aliases[i], id);
    }

    for (uint256 i = 0; i < aliases.length; i++) {
      string memory path = string.concat(snapDir, '/.snap_', aliases[i]);
      vm.writeFile(path, _snapshot(aliases[i]));
    }
  }

  function _snapshot(string memory fork) internal returns (string memory id) {
    _refork(fork);
    bytes memory ret = vm.rpc('evm_snapshot', '[]');
    id = vm.toString(ret);
    require(bytes(id).length == 66, string.concat('unexpected snapshot id shape: ', id));
  }

  function _revertTo(string memory fork, string memory id) internal {
    _refork(fork);
    bytes memory ret = vm.rpc('evm_revert', string.concat('["', id, '"]'));
    require(_isTrue(ret), string.concat('evm_revert=false on ', fork, ' for ', id));
    _refork(fork);
  }

  function _readSnap(string memory path) internal view returns (string memory) {
    try vm.readFile(path) returns (string memory s) {
      return s;
    } catch {
      return '';
    }
  }

  // RPC Results Helpers

  function _isTrue(bytes memory response) internal pure returns (bool) {
    if (response.length == 1) return response[0] == 0x01; // raw bool byte
    if (response.length == 32) return abi.decode(response, (uint256)) == 1; // ABI word
    return keccak256(response) == keccak256(bytes('true')); // literal string
  }

  function _toUint(bytes memory rpcResult) internal pure returns (uint256 v) {
    for (uint256 i = 0; i < rpcResult.length; i++) {
      v = (v << 8) | uint8(rpcResult[i]);
    }
  }

  function _toBytes32(bytes memory response) internal pure returns (bytes32 h) {
    require(response.length == 32, 'expected 32-byte rpc result');
    assembly {
      h := mload(add(response, 32))
    }
  }
}
