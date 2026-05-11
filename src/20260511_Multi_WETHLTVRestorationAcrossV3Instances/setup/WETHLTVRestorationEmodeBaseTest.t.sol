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

  function _expectedWethEmodeCount() internal pure override returns (uint256) {
    return 1;
  }

  function _assertEmodesBefore(EmodeSnapshot[] memory emodesBefore) internal view override {
    super._assertEmodesBefore(emodesBefore);
    _assertChangedEmodePresent(emodesBefore);
  }

  function _assertEmodesAfter(
    IPool pool,
    uint256 reserveId,
    EmodeSnapshot[] memory emodesBefore
  ) internal view override {
    super._assertEmodesAfter(pool, reserveId, emodesBefore);
    _assertChangedEmodePresent(_captureWethEmodes(pool, reserveId));
  }

  function _assertChangedEmodePresent(EmodeSnapshot[] memory emodes) internal view {
    uint8 changedEmodeId = _changedEmodeId();
    for (uint256 i = 0; i < emodes.length; i++) {
      if (emodes[i].categoryId == changedEmodeId) {
        return;
      }
    }
    revert('changed e-mode not found in WETH e-modes');
  }

  function _assertSingleEmodeBefore(EmodeSnapshot memory emode) internal view override {
    if (emode.categoryId == _changedEmodeId()) {
      assertTrue(emode.isLtvZero);
      assertEq(emode.effectiveLtv, 0);
      _assertChangedEmodeHardcoded(emode);
    } else {
      super._assertSingleEmodeBefore(emode);
    }
  }

  function _assertSingleEmodeAfter(
    EmodeSnapshot memory emodeBefore,
    EmodeSnapshot memory emodeAfter
  ) internal view override {
    if (emodeAfter.categoryId == _changedEmodeId()) {
      _assertEmodeConfigInvariant(emodeBefore, emodeAfter);
      _assertChangedEmodeHardcoded(emodeAfter);
      assertFalse(emodeAfter.isLtvZero);
      assertGt(emodeAfter.effectiveLtv, 0);
      assertEq(emodeAfter.effectiveLtv, emodeAfter.categoryLtv);
    } else {
      super._assertSingleEmodeAfter(emodeBefore, emodeAfter);
    }
  }

  function _assertChangedEmodeHardcoded(EmodeSnapshot memory emode) internal view {
    assertEq(emode.categoryLtv, _expectedChangedEmodeLtv());
    assertEq(emode.categoryLt, _expectedChangedEmodeLt());
  }
}
