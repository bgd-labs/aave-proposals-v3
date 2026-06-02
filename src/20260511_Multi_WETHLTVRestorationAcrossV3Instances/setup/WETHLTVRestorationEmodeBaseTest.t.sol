// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-address-book/AaveV3.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

import {ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {WETHLTVRestorationBaseTest} from './WETHLTVRestorationBaseTest.t.sol';

abstract contract WETHLTVRestorationEmodeBaseTest is WETHLTVRestorationBaseTest {
  function _changedEmodeId() internal view virtual returns (uint8);

  function _expectedChangedEmodeLtv() internal view virtual returns (uint256);

  function _expectedChangedEmodeLt() internal view virtual returns (uint256);

  function _emodeBorrowAsset() internal view virtual returns (address);

  function test_emodeBorrow_revertsBeforeAip() public {
    IPool pool = _pool();
    address weth = _weth();
    address borrowAsset = _emodeBorrowAsset();
    uint8 emodeId = _changedEmodeId();
    ReserveConfig memory wethConfig = _findReserveConfig({
      configs: _getReservesConfigs(pool),
      underlying: weth
    });
    uint256 underLtvBorrow = _borrowAmountAtLtv({
      pool: pool,
      collateral: weth,
      borrowAsset: borrowAsset,
      collateralAmount: WETH_SUPPLY_AMOUNT,
      ltvBps: _expectedChangedEmodeLtv(),
      marginBps: BORROW_UNDER_LTV_BPS
    });

    address user = makeAddr('emodeBorrowUser');
    _deposit({config: wethConfig, pool: pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    pool.setUserEMode(emodeId);
    vm.startPrank(user);
    vm.expectRevert(Errors.LtvValidationFailed.selector);
    pool.borrow({
      asset: borrowAsset,
      amount: underLtvBorrow,
      interestRateMode: 2,
      referralCode: 0,
      onBehalfOf: user
    });
    vm.stopPrank();
  }

  function test_emodeBorrow_atLtv() public {
    IPool pool = _pool();
    address weth = _weth();
    address borrowAsset = _emodeBorrowAsset();
    uint8 emodeId = _changedEmodeId();
    ReserveConfig[] memory configs = _getReservesConfigs(pool);
    ReserveConfig memory wethConfig = _findReserveConfig({configs: configs, underlying: weth});
    ReserveConfig memory borrowConfig = _findReserveConfig({
      configs: configs,
      underlying: borrowAsset
    });
    uint256 underLtvBorrow = _borrowAmountAtLtv({
      pool: pool,
      collateral: weth,
      borrowAsset: borrowAsset,
      collateralAmount: WETH_SUPPLY_AMOUNT,
      ltvBps: _expectedChangedEmodeLtv(),
      marginBps: BORROW_UNDER_LTV_BPS
    });

    GovV3Helpers.executePayload({vm: vm, payloadAddress: _proposal()});

    address user = makeAddr('emodeBorrowUser');
    _deposit({config: wethConfig, pool: pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    pool.setUserEMode(emodeId);
    _borrow({config: borrowConfig, pool: pool, user: user, amount: underLtvBorrow});
  }

  function test_emodeBorrow_revertsOverLtv() public {
    IPool pool = _pool();
    address weth = _weth();
    address borrowAsset = _emodeBorrowAsset();
    uint8 emodeId = _changedEmodeId();
    ReserveConfig memory wethConfig = _findReserveConfig({
      configs: _getReservesConfigs(pool),
      underlying: weth
    });
    uint256 overLtvBorrow = _borrowAmountAtLtv({
      pool: pool,
      collateral: weth,
      borrowAsset: borrowAsset,
      collateralAmount: WETH_SUPPLY_AMOUNT,
      ltvBps: _expectedChangedEmodeLtv(),
      marginBps: BORROW_OVER_LTV_BPS
    });

    GovV3Helpers.executePayload({vm: vm, payloadAddress: _proposal()});

    address user = makeAddr('emodeBorrowUser');
    _deposit({config: wethConfig, pool: pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    pool.setUserEMode(emodeId);
    vm.startPrank(user);
    vm.expectRevert(Errors.CollateralCannotCoverNewBorrow.selector);
    pool.borrow({
      asset: borrowAsset,
      amount: overLtvBorrow,
      interestRateMode: 2,
      referralCode: 0,
      onBehalfOf: user
    });
    vm.stopPrank();
  }

  function _assertEmodesBefore(EmodeSnapshot[] memory emodesBefore) internal view override {
    assertEq(emodesBefore.length, 1);
    EmodeSnapshot memory emode = emodesBefore[0];
    assertEq(emode.categoryId, _changedEmodeId());
    assertEq(emode.categoryLtv, _expectedChangedEmodeLtv());
    assertEq(emode.categoryLt, _expectedChangedEmodeLt());
    assertTrue(emode.isLtvZero);
    assertEq(emode.effectiveLtv, 0);
  }

  function _assertEmodesAfter(
    IPool pool,
    uint256 reserveId,
    EmodeSnapshot[] memory emodesBefore
  ) internal view override {
    assertEq(emodesBefore.length, 1);
    EmodeSnapshot[] memory emodesAfter = _captureWethEmodes(pool, reserveId);
    assertEq(emodesAfter.length, 1);

    EmodeSnapshot memory beforeEmode = emodesBefore[0];
    EmodeSnapshot memory afterEmode = emodesAfter[0];

    assertEq(afterEmode.categoryId, _changedEmodeId());

    assertEq(afterEmode.categoryLtv, beforeEmode.categoryLtv);
    assertEq(afterEmode.categoryLt, beforeEmode.categoryLt);
    assertEq(afterEmode.categoryLb, beforeEmode.categoryLb);
    assertEq(afterEmode.collateralBitmap, beforeEmode.collateralBitmap);
    assertEq(afterEmode.borrowableBitmap, beforeEmode.borrowableBitmap);

    assertEq(afterEmode.categoryLtv, _expectedChangedEmodeLtv());
    assertEq(afterEmode.categoryLt, _expectedChangedEmodeLt());

    assertFalse(afterEmode.isLtvZero);
    assertGt(afterEmode.effectiveLtv, 0);
    assertEq(afterEmode.effectiveLtv, afterEmode.categoryLtv);
  }
}
