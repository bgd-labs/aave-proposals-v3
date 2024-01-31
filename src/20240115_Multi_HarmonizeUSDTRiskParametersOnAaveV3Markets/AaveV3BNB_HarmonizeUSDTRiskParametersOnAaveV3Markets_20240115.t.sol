// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3BNB_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115} from './AaveV3BNB_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.sol';

/**
 * @dev Test for AaveV3BNB_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115
 * command: make test-contract filter=AaveV3BNB_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115
 */
contract AaveV3BNB_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115_Test is ProtocolV3TestBase {
  AaveV3BNB_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 35705382);
    proposal = new AaveV3BNB_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3BNB_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115',
      AaveV3BNB.POOL,
      address(proposal)
    );
  }
}
