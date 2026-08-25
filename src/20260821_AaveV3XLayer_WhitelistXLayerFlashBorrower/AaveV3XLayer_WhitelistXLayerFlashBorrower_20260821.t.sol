// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3XLayer} from 'aave-address-book/AaveV3XLayer.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821} from './AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821.sol';

/**
 * @dev Test for AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260821_AaveV3XLayer_WhitelistXLayerFlashBorrower/AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821.t.sol -vv
 */
contract AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821_Test is ProtocolV3TestBase {
  AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('xlayer'), 68557900);
    proposal = new AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821',
      AaveV3XLayer.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](0);

    reserveConfigChangesTest(AaveV3XLayer.POOL, address(proposal), updatedAssets);
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertEq(AaveV3XLayer.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER_A()), true);
    assertEq(AaveV3XLayer.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER_B()), true);
  }
}
