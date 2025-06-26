// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';
import {ProtocolV2TestBase} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626} from './AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626.sol';

/**
 * @dev Test for AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250626_Multi_AaveV2NonEthereumPoolsNextDeprecationSteps/AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626.t.sol -vv
 */
contract AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626_Test is
  ProtocolV2TestBase
{
  AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 73234716);
    proposal = new AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626',
      AaveV2Polygon.POOL,
      address(proposal),
      false
    );
  }

  function test_all_reserves_frozen() public {
    executePayload(vm, address(proposal));

    address[] memory reserves = AaveV2Polygon.POOL.getReservesList();
    for (uint256 i = 0; i < reserves.length; i++) {
      (, , , , , , , , , bool isFrozen) = AaveV2Polygon
        .AAVE_PROTOCOL_DATA_PROVIDER
        .getReserveConfigurationData(reserves[i]);
      assertTrue(isFrozen);
    }
  }
}
