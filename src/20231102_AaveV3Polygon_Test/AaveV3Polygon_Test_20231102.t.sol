// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_Test_20231102} from './AaveV3Polygon_Test_20231102.sol';

/**
 * @dev Test for AaveV3Polygon_Test_20231102
 * command: make test-contract filter=AaveV3Polygon_Test_20231102
 */
contract AaveV3Polygon_Test_20231102_Test is ProtocolV3TestBase {
  AaveV3Polygon_Test_20231102 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49467959);
    proposal = new AaveV3Polygon_Test_20231102();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Polygon_Test_20231102', AaveV3Polygon.POOL, address(proposal));
  }

  function test_collectorHasDAIFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Polygon
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.DAI());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Polygon.COLLECTOR)), 10 ** 18);
  }
}
