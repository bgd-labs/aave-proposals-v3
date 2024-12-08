// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201} from './AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol';

/**
 * @dev Test for AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol -vv
 */
contract AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201_Test is
  ProtocolV3TestBase
{
  AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 44648014);
    proposal = new AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201',
      AaveV3BNB.POOL,
      address(proposal)
    );
  }
}
