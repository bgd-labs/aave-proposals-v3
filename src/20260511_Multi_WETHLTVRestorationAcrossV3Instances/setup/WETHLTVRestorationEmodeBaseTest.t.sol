// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-address-book/AaveV3.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

import {ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {WETHLTVRestorationBaseTest} from './WETHLTVRestorationBaseTest.t.sol';

abstract contract WETHLTVRestorationEmodeBaseTest is WETHLTVRestorationBaseTest {
  function _changedEmodeId() internal view virtual returns (uint8);

  function _expectedChangedEmodeLtv() internal view virtual returns (uint256);

  function _expectedChangedEmodeLt() internal view virtual returns (uint256);

  function _emodeBorrowAsset() internal view virtual returns (address);

  function test_borrowAgainstWeth_eMode() public {
    uint8 emodeId = _changedEmodeId();
    IPool pool = _pool();
    address weth = _weth();
    address borrowAsset = _emodeBorrowAsset();

    ReserveConfig[] memory configs = _getReservesConfigs(pool);
    ReserveConfig memory wethConfig = _findReserveConfig({configs: configs, underlying: weth});
    ReserveConfig memory borrowConfig = _findReserveConfig({
      configs: configs,
      underlying: borrowAsset
    });

    uint256 borrowAmount = _maxBorrowAtLtv({
      pool: pool,
      collateralConfig: wethConfig,
      borrowConfig: borrowConfig,
      collateralAmount: WETH_SUPPLY_AMOUNT,
      ltvBps: _expectedChangedEmodeLtv()
    });

    address user = makeAddr('emodeBorrowUser');

    uint256 snapshot = vm.snapshotState();
    _deposit({config: wethConfig, pool: pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    pool.setUserEMode(emodeId);
    vm.startPrank(user);
    vm.expectRevert();
    pool.borrow({
      asset: borrowAsset,
      amount: borrowAmount,
      interestRateMode: 2,
      referralCode: 0,
      onBehalfOf: user
    });
    vm.stopPrank();
    vm.revertToState(snapshot);

    GovV3Helpers.executePayload({vm: vm, payloadAddress: _proposal()});

    _deposit({config: wethConfig, pool: pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    pool.setUserEMode(emodeId);
    _borrow({config: borrowConfig, pool: pool, user: user, amount: borrowAmount});
  }

  function _expectedWethEmodeCount() internal pure override returns (uint256) {
    return 1;
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
