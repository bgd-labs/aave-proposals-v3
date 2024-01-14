// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_V2DeprecationPlan20240102_20240103} from './AaveV2Ethereum_V2DeprecationPlan20240102_20240103.sol';

/**
 * @dev Test for AaveV2Ethereum_V2DeprecationPlan20240102_20240103
 * command: make test-contract filter=AaveV2Ethereum_V2DeprecationPlan20240102_20240103
 */
contract AaveV2Ethereum_V2DeprecationPlan20240102_20240103_Test is ProtocolV2TestBase {
  AaveV2Ethereum_V2DeprecationPlan20240102_20240103 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18929805);
    proposal = new AaveV2Ethereum_V2DeprecationPlan20240102_20240103();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_V2DeprecationPlan20240102_20240103',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }
}
