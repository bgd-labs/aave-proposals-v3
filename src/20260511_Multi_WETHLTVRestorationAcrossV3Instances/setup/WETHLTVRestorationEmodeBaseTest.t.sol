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
    BorrowSetup memory s = _emodeBorrowSetup();
    uint8 emodeId = _changedEmodeId();

    address user = makeAddr('emodeBorrowUser');
    _deposit({config: s.wethConfig, pool: s.pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    s.pool.setUserEMode(emodeId);
    vm.startPrank(user);
    vm.expectRevert(Errors.LtvValidationFailed.selector);
    s.pool.borrow({
      asset: s.borrowAsset,
      amount: s.underLtvBorrow,
      interestRateMode: 2,
      referralCode: 0,
      onBehalfOf: user
    });
    vm.stopPrank();
  }

  function test_emodeBorrow_atLtv() public {
    BorrowSetup memory s = _emodeBorrowSetup();
    uint8 emodeId = _changedEmodeId();
    GovV3Helpers.executePayload({vm: vm, payloadAddress: _proposal()});

    address user = makeAddr('emodeBorrowUser');
    _deposit({config: s.wethConfig, pool: s.pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    s.pool.setUserEMode(emodeId);
    _borrow({config: s.borrowConfig, pool: s.pool, user: user, amount: s.underLtvBorrow});
  }

  function test_emodeBorrow_revertsOverLtv() public {
    BorrowSetup memory s = _emodeBorrowSetup();
    uint8 emodeId = _changedEmodeId();
    GovV3Helpers.executePayload({vm: vm, payloadAddress: _proposal()});

    address user = makeAddr('emodeBorrowUser');
    _deposit({config: s.wethConfig, pool: s.pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    s.pool.setUserEMode(emodeId);
    vm.startPrank(user);
    vm.expectRevert(Errors.CollateralCannotCoverNewBorrow.selector);
    s.pool.borrow({
      asset: s.borrowAsset,
      amount: s.overLtvBorrow,
      interestRateMode: 2,
      referralCode: 0,
      onBehalfOf: user
    });
    vm.stopPrank();
  }

  function _emodeBorrowSetup() internal view returns (BorrowSetup memory s) {
    s.pool = _pool();
    s.weth = _weth();
    s.borrowAsset = _emodeBorrowAsset();
    ReserveConfig[] memory configs = _getReservesConfigs(s.pool);
    s.wethConfig = _findReserveConfig({configs: configs, underlying: s.weth});
    s.borrowConfig = _findReserveConfig({configs: configs, underlying: s.borrowAsset});
    s.underLtvBorrow = _borrowAmountAtLtv({
      pool: s.pool,
      collateralConfig: s.wethConfig,
      borrowConfig: s.borrowConfig,
      collateralAmount: WETH_SUPPLY_AMOUNT,
      ltvBps: _expectedChangedEmodeLtv(),
      marginBps: BORROW_UNDER_LTV_BPS
    });
    s.overLtvBorrow = _borrowAmountAtLtv({
      pool: s.pool,
      collateralConfig: s.wethConfig,
      borrowConfig: s.borrowConfig,
      collateralAmount: WETH_SUPPLY_AMOUNT,
      ltvBps: _expectedChangedEmodeLtv(),
      marginBps: BORROW_OVER_LTV_BPS
    });
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
