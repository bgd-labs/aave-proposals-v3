// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import {AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506} from './AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506.sol';
import {CoWFlashBorrowerBaseTest} from './setup/CoWFlashBorrowerBaseTest.t.sol';

/**
 * @dev Test for AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506.t.sol -vv
 */
contract AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506_Test is CoWFlashBorrowerBaseTest {
  AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 21132780);
    proposal = new AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_AddCoWFactoriesToFlashBorrowers_20260506',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Plasma.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
    assertEq(isFlashBorrower, true);
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3Plasma.POOL;
  }

  function _flashBorrower() internal view override returns (address) {
    return proposal.NEW_FLASH_BORROWER();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function _collateralSwapConfig() internal pure override returns (CollateralSwapConfig memory) {
    // Plasma's only borrowable+LTV asset at this fork block is WETH itself; every
    // listed stable (USDe / sUSDe / syrupUSDT / GHO) has either borrowing disabled
    // or 0 LTV, so the trader must keep enough original WETH collateral after the
    // swap to back the remaining debt. Seed 50 WETH but only swap 5 of them.
    return
      CollateralSwapConfig({
        collateralAsset: AaveV3PlasmaAssets.WETH_UNDERLYING,
        debtAsset: AaveV3PlasmaAssets.USDe_UNDERLYING,
        collateralSeed: 50 ether,
        debtSeed: 10_000 ether,
        sellAmount: 5 ether,
        expectedBuyAmount: 21_000 ether
      });
  }
}
