// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530} from './AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530.sol';

/**
 * @dev Test for AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530.t.sol -vv
 */
contract AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530_Test is ProtocolV3TestBase {
  AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 34209835);
    proposal = new AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
