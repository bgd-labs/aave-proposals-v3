// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205} from './AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205.sol';

/**
 * @dev Test for AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205
 * command: make test-contract filter=AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205
 */
contract AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18751343);
    proposal = new AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_IncreaseGHOBorrowRate100BpsTo635OnAaveV3_20231205',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
