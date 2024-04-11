// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411} from './AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411.sol';

/**
 * @dev Test for AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411
 * command: make test-contract filter=AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411
 */
contract AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 200008386);
    proposal = new AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_RiskParametersForDAIUpdate_20240411',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
