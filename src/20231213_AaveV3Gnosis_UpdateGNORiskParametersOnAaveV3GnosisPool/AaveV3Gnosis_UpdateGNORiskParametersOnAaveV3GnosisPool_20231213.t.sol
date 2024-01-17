// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213} from './AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213.sol';

/**
 * @dev Test for AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213
 * command: make test-contract filter=AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213
 */
contract AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213_Test is
  ProtocolV3TestBase
{
  AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 31425108);
    proposal = new AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_UpdateGNORiskParametersOnAaveV3GnosisPool_20231213',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
