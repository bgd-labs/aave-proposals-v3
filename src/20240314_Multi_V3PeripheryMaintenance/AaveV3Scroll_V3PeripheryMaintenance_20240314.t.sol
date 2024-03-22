// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Scroll_V3PeripheryMaintenance_20240314} from './AaveV3Scroll_V3PeripheryMaintenance_20240314.sol';
import {IPriceOracleSentinel} from 'aave-v3-core/contracts/interfaces/IPriceOracleSentinel.sol';

/**
 * @dev Test for AaveV3Scroll_V3PeripheryMaintenance_20240314
 * command: make test-contract filter=AaveV3Scroll_V3PeripheryMaintenance_20240314
 */
contract AaveV3Scroll_V3PeripheryMaintenance_20240314_Test is ProtocolV3TestBase {
  AaveV3Scroll_V3PeripheryMaintenance_20240314 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 4240928);
    proposal = new AaveV3Scroll_V3PeripheryMaintenance_20240314();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_V3PeripheryMaintenance_20240314',
      AaveV3Scroll.POOL,
      address(proposal)
    );

    assertEq(
      AaveV3Scroll.POOL_ADDRESSES_PROVIDER.getPriceOracleSentinel(),
      proposal.PRICE_ORACLE_SENTINEL()
    );

    assertTrue(IPriceOracleSentinel(proposal.PRICE_ORACLE_SENTINEL()).isLiquidationAllowed());
    assertTrue(IPriceOracleSentinel(proposal.PRICE_ORACLE_SENTINEL()).isBorrowAllowed());
  }
}
