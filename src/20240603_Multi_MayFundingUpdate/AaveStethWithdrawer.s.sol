// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveStethWithdrawer} from './AaveStethWithdrawer.sol';
import 'forge-std/Script.sol';

contract DeployEthereum is Script {
  function run() external {
    // deploy payloads
    vm.startBroadcast();
    new AaveStethWithdrawer(0x06610fdEFD2239C828e7114Fc1Ea7EfD9Ae90448);
    vm.stopBroadcast();
  }
}
