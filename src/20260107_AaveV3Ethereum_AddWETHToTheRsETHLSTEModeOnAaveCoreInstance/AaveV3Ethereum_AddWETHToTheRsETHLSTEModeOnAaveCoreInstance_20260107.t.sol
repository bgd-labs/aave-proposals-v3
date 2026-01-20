// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107} from './AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107.sol';

/**
 * @dev Test for AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260107_AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance/AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107.t.sol -vv
 */
contract AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24219749);
    proposal = new AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddWETHToTheRsETHLSTEModeOnAaveCoreInstance_20260107',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
