// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_OffboardInstance_20260410} from './AaveV3Scroll_OffboardInstance_20260410.sol';

/**
 * @dev Test for AaveV3Scroll_OffboardInstance_20260410
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260410_AaveV3Scroll_OffboardInstance/AaveV3Scroll_OffboardInstance_20260410.t.sol -vv
 */
contract AaveV3Scroll_OffboardInstance_20260410_Test is
  ProtocolV3TestBase
{
  AaveV3Scroll_OffboardInstance_20260410 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 33262428);
    proposal = new AaveV3Scroll_OffboardInstance_20260410();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_OffboardInstance_20260410',
      AaveV3Scroll.POOL,
      address(proposal),
      false,
      false
    );
  }

  function test_frozenFlag() public {
    executePayload(vm, address(proposal), AaveV3Scroll.POOL);
    ReserveConfig[] memory configs = _getReservesConfigs(AaveV3Scroll.POOL);
    for (uint256 i = 0; i < configs.length; i++) {
      assertTrue(configs[i].isFrozen, string.concat('Reserve ', vm.toString(configs[i].underlying), " isn't frozen"));
    }
  }

  function test_reserveFactor() public {
    executePayload(vm, address(proposal), AaveV3Scroll.POOL);
    ReserveConfig[] memory configs = _getReservesConfigs(AaveV3Scroll.POOL);
    for (uint256 i = 0; i < configs.length; i++) {
      if (configs[i].underlying == AaveV3ScrollAssets.WETH_UNDERLYING) {
        assertEq(configs[i].reserveFactor, 50_00, 'WETH reserve factor should remain 50%');
      } else {
        assertEq(configs[i].reserveFactor, 85_00, string.concat('Reserve ', vm.toString(configs[i].underlying), ' should have 85% reserve factor'));
      }
    }
  }
}