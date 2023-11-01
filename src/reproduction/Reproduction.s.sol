// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script} from 'forge-std/Script.sol';

/**
 * @dev Preproduction
 * command: make deploy-ledger contract=src/reproduction/Reproduction.s.sol:Reproduction chain=mainnet
 */
contract Reproduction is Script {
  function run() public {
    uint256 previousFork = vm.activeFork();
    uint256 newFork = vm.createFork(vm.rpcUrl('polygon'));
    vm.selectFork(previousFork);
    vm.startBroadcast();
    address(0x25F2226B597E8F9514B3F68F00f494cF4f286491).call{value: 1}(new bytes(0));
  }
}
