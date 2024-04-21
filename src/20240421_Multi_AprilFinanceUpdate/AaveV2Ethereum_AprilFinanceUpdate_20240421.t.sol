// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_AprilFinanceUpdate_20240421} from './AaveV2Ethereum_AprilFinanceUpdate_20240421.sol';

/**
 * @dev Test for AaveV2Ethereum_AprilFinanceUpdate_20240421
 * command: make test-contract filter=AaveV2Ethereum_AprilFinanceUpdate_20240421
 */
contract AaveV2Ethereum_AprilFinanceUpdate_20240421_Test is ProtocolV2TestBase {
  AaveV2Ethereum_AprilFinanceUpdate_20240421 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19706815);
    proposal = new AaveV2Ethereum_AprilFinanceUpdate_20240421();
  }

  function test_agdAllowanceChanges() public {}

  function test_v2ToV3Migration() public {}

  function test_swaps() public {}
}
