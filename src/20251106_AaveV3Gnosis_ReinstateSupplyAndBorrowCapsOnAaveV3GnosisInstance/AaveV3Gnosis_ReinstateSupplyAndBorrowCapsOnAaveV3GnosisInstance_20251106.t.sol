// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106} from './AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106.sol';

/**
 * @dev Test for AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251106_AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance/AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106.t.sol -vv
 */
contract AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106_Test is
  ProtocolV3TestBase
{
  AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 43004019);
    proposal = new AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
