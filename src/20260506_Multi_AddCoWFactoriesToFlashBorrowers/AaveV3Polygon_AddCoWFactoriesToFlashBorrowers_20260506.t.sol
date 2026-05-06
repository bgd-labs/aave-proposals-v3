// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import {AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506} from './AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506.sol';
import {CoWFlashBorrowerBaseTest} from './setup/CoWFlashBorrowerBaseTest.t.sol';

/**
 * @dev Test for AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506.t.sol -vv
 */
contract AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506_Test is CoWFlashBorrowerBaseTest {
  AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 86472283);
    proposal = new AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_AddCoWFactoriesToFlashBorrowers_20260506',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Polygon.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
    assertEq(isFlashBorrower, true);
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3Polygon.POOL;
  }

  function _flashBorrower() internal view override returns (address) {
    return proposal.NEW_FLASH_BORROWER();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function _collateralSwapConfig() internal pure override returns (CollateralSwapConfig memory) {
    // Bridged USDC.e (`USDC_UNDERLYING`) has borrowing disabled on Polygon at this
    // fork block; use native USDC (USDCn) for both sides via wstETH collateral.
    return
      CollateralSwapConfig({
        collateralAsset: AaveV3PolygonAssets.wstETH_UNDERLYING,
        debtAsset: AaveV3PolygonAssets.USDCn_UNDERLYING,
        collateralSeed: 10 ether,
        debtSeed: 10_000 * 1e6,
        sellAmount: 10 ether,
        expectedBuyAmount: 42_000 * 1e6
      });
  }
}
