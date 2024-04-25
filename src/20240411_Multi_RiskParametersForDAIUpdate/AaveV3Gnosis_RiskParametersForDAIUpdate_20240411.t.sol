// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_RiskParametersForDAIUpdate_20240411} from './AaveV3Gnosis_RiskParametersForDAIUpdate_20240411.sol';

/**
 * @dev Test for AaveV3Gnosis_RiskParametersForDAIUpdate_20240411
 * command: make test-contract filter=AaveV3Gnosis_RiskParametersForDAIUpdate_20240411
 */
contract AaveV3Gnosis_RiskParametersForDAIUpdate_20240411_Test is ProtocolV3TestBase {
  AaveV3Gnosis_RiskParametersForDAIUpdate_20240411 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 33384278);
    proposal = new AaveV3Gnosis_RiskParametersForDAIUpdate_20240411();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_RiskParametersForDAIUpdate_20240411',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
