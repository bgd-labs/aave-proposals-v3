// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

import {AaveV2Polygon_BorrowRateUpdates_20240528} from './AaveV2Polygon_BorrowRateUpdates_20240528.sol';

/**
 * @dev Test for AaveV2Polygon_BorrowRateUpdates_20240528
 * command: make test-contract filter=AaveV2Polygon_BorrowRateUpdates_20240528
 */
contract AaveV2Polygon_BorrowRateUpdates_20240528_Test is ProtocolV2TestBase {
  struct Changes {
    address asset;
    uint256 reserveFactor;
  }
  AaveV2Polygon_BorrowRateUpdates_20240528 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 58078849);
    proposal = new AaveV2Polygon_BorrowRateUpdates_20240528();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV2Polygon_BorrowRateUpdates_20240528', AaveV2Polygon.POOL, address(proposal));
  }
}
