// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-address-book/AaveV3.sol';
import {IAaveOracle} from 'aave-v3-origin/contracts/interfaces/IAaveOracle.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';
import {EModeConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/EModeConfiguration.sol';
import {PercentageMath} from 'aave-v3-origin/contracts/protocol/libraries/math/PercentageMath.sol';
import {Errors} from 'aave-v3-origin/contracts/protocol/libraries/helpers/Errors.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

abstract contract WETHLTVRestorationBaseTest is ProtocolV3TestBase {
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  uint256 internal constant WETH_SUPPLY_AMOUNT = 1 ether;
  uint256 internal constant BORROW_UNDER_LTV_BPS = 99_00;
  uint256 internal constant BORROW_OVER_LTV_BPS = 101_00;

  struct EmodeSnapshot {
    uint8 categoryId;
    uint256 categoryLtv;
    uint256 categoryLt;
    uint256 categoryLb;
    uint128 collateralBitmap;
    uint128 borrowableBitmap;
    bool isLtvZero;
    uint256 effectiveLtv;
  }

  function _pool() internal view virtual returns (IPool);

  function _weth() internal view virtual returns (address);

  function _proposal() internal view virtual returns (address);

  function _expectedLtv() internal view virtual returns (uint256);

  function _expectedLt() internal view virtual returns (uint256);

  function _expectedLb() internal view virtual returns (uint256);

  function _defaultBorrowAsset() internal view virtual returns (address);

  function test_ltvRestoration() public {
    IPool pool = _pool();
    address weth = _weth();

    ReserveConfig[] memory configsBefore = _getReservesConfigs(pool);
    ReserveConfig memory wethBefore = _findReserveConfig({
      configs: configsBefore,
      underlying: weth
    });

    _assertWethReserveBefore(wethBefore);

    uint256 reserveId = pool.getReserveData(weth).id;
    EmodeSnapshot[] memory emodesBefore = _captureWethEmodes(pool, reserveId);
    _assertEmodesBefore(emodesBefore);

    GovV3Helpers.executePayload({vm: vm, payloadAddress: _proposal()});

    ReserveConfig[] memory configsAfter = _getReservesConfigs(pool);
    ReserveConfig memory wethAfter = _findReserveConfig({configs: configsAfter, underlying: weth});

    _assertWethReserveAfter(wethBefore, wethAfter);

    _noReservesConfigsChangesApartFrom({
      allConfigsBefore: configsBefore,
      allConfigsAfter: configsAfter,
      assetChangedUnderlying: weth
    });

    _assertEmodesAfter(pool, reserveId, emodesBefore);
  }

  function test_borrowAgainstWeth_defaultMode() public {
    IPool pool = _pool();
    address weth = _weth();
    address borrowAsset = _defaultBorrowAsset();

    ReserveConfig[] memory configs = _getReservesConfigs(pool);
    ReserveConfig memory wethConfig = _findReserveConfig({configs: configs, underlying: weth});
    ReserveConfig memory borrowConfig = _findReserveConfig({
      configs: configs,
      underlying: borrowAsset
    });

    uint256 underLtvBorrow = _borrowAmountAtLtv({
      pool: pool,
      collateralConfig: wethConfig,
      borrowConfig: borrowConfig,
      collateralAmount: WETH_SUPPLY_AMOUNT,
      ltvBps: _expectedLtv(),
      marginBps: BORROW_UNDER_LTV_BPS
    });
    uint256 overLtvBorrow = _borrowAmountAtLtv({
      pool: pool,
      collateralConfig: wethConfig,
      borrowConfig: borrowConfig,
      collateralAmount: WETH_SUPPLY_AMOUNT,
      ltvBps: _expectedLtv(),
      marginBps: BORROW_OVER_LTV_BPS
    });

    address user = makeAddr('defaultBorrowUser');

    uint256 snapshot = vm.snapshotState();
    _deposit({config: wethConfig, pool: pool, user: user, amount: WETH_SUPPLY_AMOUNT});
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
    vm.revertToState(snapshot);

    GovV3Helpers.executePayload({vm: vm, payloadAddress: _proposal()});

    snapshot = vm.snapshotState();
    _deposit({config: wethConfig, pool: pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    pool.setUserUseReserveAsCollateral({asset: weth, useAsCollateral: true});
    _borrow({config: borrowConfig, pool: pool, user: user, amount: underLtvBorrow});
    vm.revertToState(snapshot);

    _deposit({config: wethConfig, pool: pool, user: user, amount: WETH_SUPPLY_AMOUNT});
    vm.prank(user);
    pool.setUserUseReserveAsCollateral({asset: weth, useAsCollateral: true});
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

  function _borrowAmountAtLtv(
    IPool pool,
    ReserveConfig memory collateralConfig,
    ReserveConfig memory borrowConfig,
    uint256 collateralAmount,
    uint256 ltvBps,
    uint256 marginBps
  ) internal view returns (uint256) {
    IAaveOracle oracle = IAaveOracle(pool.ADDRESSES_PROVIDER().getPriceOracle());
    uint256 collateralPrice = oracle.getAssetPrice(collateralConfig.underlying);
    uint256 borrowPrice = oracle.getAssetPrice(borrowConfig.underlying);
    uint256 collateralValueBase = (collateralAmount * collateralPrice) /
      (10 ** collateralConfig.decimals);
    uint256 maxBorrowValueBase = (collateralValueBase * ltvBps) / PercentageMath.PERCENTAGE_FACTOR;
    uint256 maxBorrowInAsset = (maxBorrowValueBase * (10 ** borrowConfig.decimals)) / borrowPrice;
    return (maxBorrowInAsset * marginBps) / PercentageMath.PERCENTAGE_FACTOR;
  }

  function _assertWethReserveBefore(ReserveConfig memory wethBefore) internal view {
    assertEq(wethBefore.ltv, 0);
    assertEq(wethBefore.isFrozen, false);
    assertEq(wethBefore.liquidationThreshold, _expectedLt());
    assertEq(wethBefore.liquidationBonus, _expectedLb());
  }

  function _assertWethReserveAfter(
    ReserveConfig memory wethBefore,
    ReserveConfig memory wethAfter
  ) internal view {
    assertEq(wethAfter.ltv, _expectedLtv());
    assertEq(wethAfter.liquidationThreshold, wethBefore.liquidationThreshold);
    assertEq(wethAfter.liquidationThreshold, _expectedLt());
    assertEq(wethAfter.liquidationBonus, wethBefore.liquidationBonus);
    assertEq(wethAfter.liquidationBonus, _expectedLb());
    assertEq(wethAfter.isFrozen, false);

    assertEq(wethBefore.symbol, wethAfter.symbol);
    assertEq(wethBefore.underlying, wethAfter.underlying);
    assertEq(wethBefore.aToken, wethAfter.aToken);
    assertEq(wethBefore.variableDebtToken, wethAfter.variableDebtToken);
    assertEq(wethBefore.decimals, wethAfter.decimals);
    assertEq(wethBefore.liquidationProtocolFee, wethAfter.liquidationProtocolFee);
    assertEq(wethBefore.reserveFactor, wethAfter.reserveFactor);
    assertEq(wethBefore.usageAsCollateralEnabled, wethAfter.usageAsCollateralEnabled);
    assertEq(wethBefore.borrowingEnabled, wethAfter.borrowingEnabled);
    assertEq(wethBefore.interestRateStrategy, wethAfter.interestRateStrategy);
    assertEq(wethBefore.isPaused, wethAfter.isPaused);
    assertEq(wethBefore.isActive, wethAfter.isActive);
    assertEq(wethBefore.isSiloed, wethAfter.isSiloed);
    assertEq(wethBefore.isBorrowableInIsolation, wethAfter.isBorrowableInIsolation);
    assertEq(wethBefore.isFlashloanable, wethAfter.isFlashloanable);
    assertEq(wethBefore.supplyCap, wethAfter.supplyCap);
    assertEq(wethBefore.borrowCap, wethAfter.borrowCap);
    assertEq(wethBefore.debtCeiling, wethAfter.debtCeiling);
  }

  function _expectedWethEmodeCount() internal view virtual returns (uint256) {
    return 0;
  }

  function _assertEmodesBefore(EmodeSnapshot[] memory emodesBefore) internal view {
    assertEq(emodesBefore.length, _expectedWethEmodeCount());
    for (uint256 i = 0; i < emodesBefore.length; i++) {
      _assertSingleEmodeBefore(emodesBefore[i]);
    }
  }

  function _assertSingleEmodeBefore(EmodeSnapshot memory emode) internal view virtual {
    assertFalse(emode.isLtvZero);
    assertGt(emode.effectiveLtv, 0);
  }

  function _assertEmodesAfter(
    IPool pool,
    uint256 reserveId,
    EmodeSnapshot[] memory emodesBefore
  ) internal view {
    EmodeSnapshot[] memory emodesAfter = _captureWethEmodes(pool, reserveId);
    assertEq(emodesAfter.length, emodesBefore.length);
    for (uint256 i = 0; i < emodesBefore.length; i++) {
      _assertSingleEmodeAfter(emodesBefore[i], emodesAfter[i]);
    }
  }

  function _assertSingleEmodeAfter(
    EmodeSnapshot memory emodeBefore,
    EmodeSnapshot memory emodeAfter
  ) internal view virtual {
    _assertEmodeConfigInvariant(emodeBefore, emodeAfter);
    assertEq(emodeAfter.isLtvZero, emodeBefore.isLtvZero);
    assertFalse(emodeAfter.isLtvZero);
    assertEq(emodeAfter.effectiveLtv, emodeBefore.effectiveLtv);
    assertGt(emodeAfter.effectiveLtv, 0);
  }

  function _assertEmodeConfigInvariant(
    EmodeSnapshot memory emodeBefore,
    EmodeSnapshot memory emodeAfter
  ) internal pure {
    assertEq(emodeAfter.categoryLtv, emodeBefore.categoryLtv);
    assertEq(emodeAfter.categoryLt, emodeBefore.categoryLt);
    assertEq(emodeAfter.categoryLb, emodeBefore.categoryLb);
    assertEq(emodeAfter.collateralBitmap, emodeBefore.collateralBitmap);
    assertEq(emodeAfter.borrowableBitmap, emodeBefore.borrowableBitmap);
  }

  function _captureWethEmodes(
    IPool pool,
    uint256 reserveId
  ) internal view returns (EmodeSnapshot[] memory) {
    EmodeSnapshot[] memory temp = new EmodeSnapshot[](256);
    uint256 count;
    for (uint256 i = 1; i < type(uint8).max; i++) {
      uint8 categoryId = uint8(i);
      uint128 collateralBitmap = pool.getEModeCategoryCollateralBitmap(categoryId);
      if (
        EModeConfiguration.isReserveEnabledOnBitmap({
          bitmap: collateralBitmap,
          reserveIndex: reserveId
        })
      ) {
        temp[count] = _readEmode(pool, reserveId, categoryId);
        count++;
      }
    }
    EmodeSnapshot[] memory result = new EmodeSnapshot[](count);
    for (uint256 i = 0; i < count; i++) {
      result[i] = temp[i];
    }
    return result;
  }

  function _readEmode(
    IPool pool,
    uint256 reserveId,
    uint8 categoryId
  ) internal view returns (EmodeSnapshot memory) {
    DataTypes.CollateralConfig memory cfg = pool.getEModeCategoryCollateralConfig(categoryId);
    uint128 ltvzeroBitmap = pool.getEModeCategoryLtvzeroBitmap(categoryId);
    bool isLtvZero = EModeConfiguration.isReserveEnabledOnBitmap({
      bitmap: ltvzeroBitmap,
      reserveIndex: reserveId
    });
    return
      EmodeSnapshot({
        categoryId: categoryId,
        categoryLtv: cfg.ltv,
        categoryLt: cfg.liquidationThreshold,
        categoryLb: cfg.liquidationBonus,
        collateralBitmap: pool.getEModeCategoryCollateralBitmap(categoryId),
        borrowableBitmap: pool.getEModeCategoryBorrowableBitmap(categoryId),
        isLtvZero: isLtvZero,
        effectiveLtv: isLtvZero ? 0 : cfg.ltv
      });
  }
}
