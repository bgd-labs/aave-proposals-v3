// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import {AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506} from './AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506.sol';
import {CoWFlashBorrowerBaseTest} from './setup/CoWFlashBorrowerBaseTest.t.sol';

/**
 * @dev Test for AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506.t.sol -vv
 */
contract AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506_Test is CoWFlashBorrowerBaseTest {
  AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 96691532);
    proposal = new AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3BNB_AddCoWFactoriesToFlashBorrowers_20260506',
      AaveV3BNB.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3BNB.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
    assertEq(isFlashBorrower, true);
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3BNB.POOL;
  }

  function _flashBorrower() internal view override returns (address) {
    return proposal.NEW_FLASH_BORROWER();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function _collateralSwapConfig() internal pure override returns (CollateralSwapConfig memory) {
    // Both BSC USDT and BSC USDC are 18-decimals on BNB Chain (not 6).
    return
      CollateralSwapConfig({
        collateralAsset: AaveV3BNBAssets.USDT_UNDERLYING,
        debtAsset: AaveV3BNBAssets.USDC_UNDERLYING,
        collateralSeed: 40_000 ether,
        debtSeed: 10_000 ether,
        sellAmount: 40_000 ether,
        expectedBuyAmount: 42_000 ether
      });
  }
}
