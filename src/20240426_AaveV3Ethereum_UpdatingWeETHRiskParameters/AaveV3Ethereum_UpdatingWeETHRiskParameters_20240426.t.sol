// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426} from './AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426.sol';

/**
 * @dev Test for AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426
 * command: make test-contract filter=AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426
 */
contract AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426_Test is ProtocolV3TestBase {
  AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19735235);
    proposal = new AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UpdatingWeETHRiskParameters_20240426',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
