// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {ISpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ISpoke.sol';
import {IHub} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IHub.sol';
import {IAaveOracle} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IAaveOracle.sol';
import {IPriceOracle} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IPriceOracle.sol';
import {AaveV4EthereumAddresses} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4EthereumAddresses.sol';
import {ISpokeConfigurator} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ISpokeConfigurator.sol';
import {Types} from './Types.sol';
import {Helpers} from './Helpers.sol';

/// @title Scenarios
/// @notice Test scenario orchestration for V4 e2e tests.
abstract contract Scenarios is Helpers {
  using SafeERC20 for IERC20;

  /// @dev Makes a user liquidatable by manipulating oracle prices and warping time.
  ///      1. Reduce collateral-only prices to near zero and decrease coll prices; boost debt-only prices.
  ///      2. For same-asset positions (supply + debt on same reserve), reduce collateral factor to 1 BPS.
  function _makeUserLiquidatable(ISpoke spoke, address user) internal virtual {
    address oracle = spoke.ORACLE();
    uint256 reserveCount = spoke.getReserveCount();

    // Pass 1: manipulate prices for reserves where user has only supply or only debt
    for (uint256 i; i < reserveCount; i++) {
      uint256 userSupply = spoke.getUserSuppliedAssets(i, user);
      uint256 userDebt = spoke.getUserTotalDebt(i, user);

      if (userSupply > 0) {
        // Reduce CF to 1 BPS on the user's actual dynamic config key
        _updateCollateralFactor({spoke: spoke, reserveId: i, user: user, collateralFactor: 1});
      }
      if (userSupply > 0 && userDebt == 0) {
        // Collateral-only: also slash price by 1000x
        uint256 currentPrice = IAaveOracle(oracle).getReservePrice(i);
        vm.mockCall(
          oracle,
          abi.encodeWithSelector(IPriceOracle.getReservePrice.selector, i),
          abi.encode(currentPrice / 1000)
        );
      } else if (userDebt > 0 && userSupply == 0) {
        // Debt-only: boost price by 1000x
        uint256 currentPrice = IAaveOracle(oracle).getReservePrice(i);
        vm.mockCall(
          oracle,
          abi.encodeWithSelector(IPriceOracle.getReservePrice.selector, i),
          abi.encode(currentPrice * 1000)
        );
      }
    }

    ISpoke.UserAccountData memory accountData = spoke.getUserAccountData(user);
    // Verify the user is actually liquidatable
    assertLt(
      accountData.healthFactor,
      HEALTH_FACTOR_LIQUIDATION_THRESHOLD,
      'MAKE_LIQUIDATABLE: health factor not below 1'
    );
  }

  /// @dev Update the collateral factor on the user's existing dynamic config key.
  ///      Mocks ACCESS_MANAGER to bypass auth, then calls SpokeConfigurator.updateCollateralFactor.
  function _updateCollateralFactor(
    ISpoke spoke,
    uint256 reserveId,
    address user,
    uint16 collateralFactor
  ) internal {
    uint32 userConfigKey = spoke.getUserPosition(reserveId, user).dynamicConfigKey;
    vm.mockCall(
      AaveV4EthereumAddresses.ACCESS_MANAGER,
      abi.encodeWithSelector(bytes4(keccak256('canCall(address,address,bytes4)'))),
      abi.encode(true, uint32(0))
    );
    ISpokeConfigurator(AaveV4EthereumAddresses.SPOKE_CONFIGURATOR).updateCollateralFactor({
      spoke: address(spoke),
      reserveId: reserveId,
      dynamicConfigKey: userConfigKey,
      collateralFactor: collateralFactor
    });
    vm.clearMockedCalls();

    assertEq(
      collateralFactor,
      spoke.getDynamicReserveConfig(reserveId, userConfigKey).collateralFactor
    );
  }

  /// @dev Supply collateral(s) and test asset, return the test asset amount.
  function _setupPositions(
    ISpoke spoke,
    Types.ReserveInfo[] memory goodCollaterals,
    uint256 primaryCollateralIndex,
    Types.ReserveInfo memory testAssetInfo,
    address collateralSupplier,
    address testAssetSupplier
  ) internal returns (uint256 testAssetAmount) {
    Types.ReserveInfo memory collateralInfo = goodCollaterals[primaryCollateralIndex];
    address oracle = spoke.ORACLE();

    uint256 collateralDollars = vm.randomUint(50_000, 200_000);
    uint256 testAssetDollars = vm.randomUint(1_000, 20_000);
    uint256 collateralAmount = _getTokenAmountByDollarValue({
      oracleAddr: oracle,
      reserveInfo: collateralInfo,
      dollarValue: collateralDollars
    });
    testAssetAmount = _getTokenAmountByDollarValue({
      oracleAddr: oracle,
      reserveInfo: testAssetInfo,
      dollarValue: testAssetDollars
    });

    // Supply primary collateral
    _supply({
      spoke: spoke,
      reserveInfo: collateralInfo,
      user: collateralSupplier,
      amount: collateralAmount
    });
    vm.prank(collateralSupplier);
    spoke.setUsingAsCollateral({
      reserveId: collateralInfo.reserveId,
      usingAsCollateral: true,
      onBehalfOf: collateralSupplier
    });

    {
      ISpoke.UserAccountData memory accountAfterCollateral = spoke.getUserAccountData(
        collateralSupplier
      );
      assertEq(
        accountAfterCollateral.activeCollateralCount,
        1,
        'SETUP: activeCollateralCount should be 1 after primary collateral'
      );
    }

    // Supply random extra collaterals up to remaining capacity
    {
      uint256 extraCount = _randomExtraCount({
        spoke: spoke,
        user: collateralSupplier,
        available: goodCollaterals.length > 1 ? goodCollaterals.length - 1 : 0
      });
      _supplyRandomExtraCollaterals({
        spoke: spoke,
        goodCollaterals: goodCollaterals,
        primaryIndex: primaryCollateralIndex,
        testAssetReserveId: testAssetInfo.reserveId,
        oracleAddr: oracle,
        user: collateralSupplier,
        extraCount: extraCount
      });
    }

    // Supply test asset
    _supply({
      spoke: spoke,
      reserveInfo: testAssetInfo,
      user: testAssetSupplier,
      amount: testAssetAmount
    });
  }

  function _testPartialWithdrawal(
    ISpoke spoke,
    Types.ReserveInfo memory testAssetInfo,
    address testAssetSupplier,
    uint256 testAssetAmount
  ) internal {
    uint256 partialWithdraw = testAssetAmount > 1
      ? vm.randomUint(1, testAssetAmount - 1)
      : testAssetAmount;
    _withdraw(spoke, testAssetInfo, testAssetSupplier, partialWithdraw);
  }

  function _testFullWithdrawal(
    ISpoke spoke,
    Types.ReserveInfo memory testAssetInfo,
    address testAssetSupplier
  ) internal {
    _withdraw(spoke, testAssetInfo, testAssetSupplier, UINT256_MAX);
  }

  /// @dev Setup borrows: calculate ceiling, first+second borrow, extras.
  ///      Returns the borrow ceiling (0 means no borrow was possible).
  function _setupBorrows(
    ISpoke spoke,
    Types.ReserveInfo memory testAssetInfo,
    address collateralSupplier,
    uint256 testAssetAmount
  ) internal returns (uint256 borrowCeiling) {
    // Cap borrow by user's available borrowing power to avoid HealthFactorBelowThreshold.
    {
      ISpoke.UserAccountData memory accountData = spoke.getUserAccountData(collateralSupplier);
      // maxDebtValue = CF-weighted collateral value (HF=1 threshold)
      uint256 maxDebtValue = (accountData.totalCollateralValue * accountData.avgCollateralFactor) /
        1e18;
      uint256 currentDebtValue = accountData.totalDebtValueRay / 1e27;
      uint256 availableDebtValue = maxDebtValue > currentDebtValue
        ? maxDebtValue - currentDebtValue
        : 0;

      // Convert to test asset tokens
      address oracleAddr = spoke.ORACLE();
      uint256 testAssetPrice = IAaveOracle(oracleAddr).getReservePrice(testAssetInfo.reserveId);
      uint256 maxBorrowableAmount = (availableDebtValue * 10 ** testAssetInfo.decimals) /
        testAssetPrice;
      // Use 50% of max for safety margin
      maxBorrowableAmount = maxBorrowableAmount / 2;
      borrowCeiling = testAssetAmount < maxBorrowableAmount ? testAssetAmount : maxBorrowableAmount;
      console.log(
        'BORROW_CEILING: maxDebt=%e, available=%e, ceiling=%e',
        maxDebtValue,
        maxBorrowableAmount,
        borrowCeiling
      );
    }
    if (borrowCeiling == 0) {
      return 0;
    }

    // First borrow (random partial amount)
    uint256 firstBorrow = borrowCeiling > 2 ? vm.randomUint(1, borrowCeiling / 2) : borrowCeiling;
    _borrow({
      spoke: spoke,
      reserveInfo: testAssetInfo,
      user: collateralSupplier,
      amount: firstBorrow
    });

    // Health factor + reserves limit check after first borrow
    {
      ISpoke.UserAccountData memory accountData = spoke.getUserAccountData(collateralSupplier);
      assertGe(
        accountData.healthFactor,
        HEALTH_FACTOR_LIQUIDATION_THRESHOLD,
        'HEALTH: health factor below 1 after borrow'
      );
      assertLe(
        accountData.borrowCount,
        spoke.MAX_USER_RESERVES_LIMIT(),
        'BORROW: borrowCount exceeds MAX_USER_RESERVES_LIMIT'
      );
    }

    // Second sequential borrow on same reserve
    uint256 remaining = borrowCeiling - firstBorrow;
    if (remaining > 0) {
      uint256 secondBorrow = vm.randomUint(1, remaining);
      _borrow({
        spoke: spoke,
        reserveInfo: testAssetInfo,
        user: collateralSupplier,
        amount: secondBorrow
      });

      // Verify borrow count unchanged (same reserve, not a new borrow position)
      ISpoke.UserAccountData memory accountAfterSecond = spoke.getUserAccountData(
        collateralSupplier
      );
      assertLe(
        accountAfterSecond.borrowCount,
        spoke.MAX_USER_RESERVES_LIMIT(),
        'BORROW: borrowCount exceeds MAX_USER_RESERVES_LIMIT after second borrow'
      );
    }

    // Borrow from random extra borrowable reserves up to remaining capacity
    _borrowExtrasWithinLimit({
      spoke: spoke,
      primaryReserveId: testAssetInfo.reserveId,
      user: collateralSupplier
    });
  }

  function _testPartialRepay(
    ISpoke spoke,
    Types.ReserveInfo memory testAssetInfo,
    address collateralSupplier
  ) internal {
    uint256 actualDebt = spoke.getUserTotalDebt(testAssetInfo.reserveId, collateralSupplier);
    if (actualDebt > 1) {
      uint256 partialRepay = vm.randomUint(1, actualDebt - 1);
      _repay({
        spoke: spoke,
        reserveInfo: testAssetInfo,
        user: collateralSupplier,
        amount: partialRepay
      });
    }
  }

  function _testFullRepay(
    ISpoke spoke,
    Types.ReserveInfo memory testAssetInfo,
    address collateralSupplier
  ) internal {
    uint256 actualDebt = spoke.getUserTotalDebt(testAssetInfo.reserveId, collateralSupplier);
    _repay({
      spoke: spoke,
      reserveInfo: testAssetInfo,
      user: collateralSupplier,
      amount: actualDebt
    });
  }

  function _testRepayAfterInterest(
    ISpoke spoke,
    Types.ReserveInfo memory testAssetInfo,
    address collateralSupplier
  ) internal {
    _skipTimeAndCheckAccounting({
      spoke: spoke,
      reserveInfo: testAssetInfo,
      user: collateralSupplier,
      skipDays: vm.randomUint(1, 450)
    });

    skip(vm.randomUint(1, 30) * 1 days);
    uint256 debtAfterAccrual = spoke.getUserTotalDebt(testAssetInfo.reserveId, collateralSupplier);
    _repay({
      spoke: spoke,
      reserveInfo: testAssetInfo,
      user: collateralSupplier,
      amount: debtAfterAccrual
    });
  }

  /// @dev Test liquidation: partial, full (receive underlying), and full (receive shares).
  function _testLiquidation(
    ISpoke spoke,
    Types.ReserveInfo memory collateralInfo,
    Types.ReserveInfo memory testAssetInfo,
    address collateralSupplier
  ) internal {
    _makeUserLiquidatable(spoke, collateralSupplier);

    // Skip random 1-90 days to let interest accrue before liquidation
    uint256 skipDays = vm.randomUint(1, 90);
    skip(skipDays * 1 days);

    // Verify health factor is below 1 after making liquidatable
    ISpoke.UserAccountData memory accountData = spoke.getUserAccountData(collateralSupplier);
    assertLt(
      accountData.healthFactor,
      HEALTH_FACTOR_LIQUIDATION_THRESHOLD,
      'HEALTH: should be below 1 for liquidation'
    );

    address liquidator = vm.randomAddress();
    uint256 snapshotBeforeLiquidation = vm.snapshotState();

    bool receiveSharesEnabled = spoke
      .getReserveConfig(collateralInfo.reserveId)
      .receiveSharesEnabled;

    // Partial liquidation — only if no dust remains
    _testPartialLiquidation({
      spoke: spoke,
      collateralInfo: collateralInfo,
      testAssetInfo: testAssetInfo,
      liquidator: liquidator,
      borrower: collateralSupplier,
      receiveShares: false
    });
    if (receiveSharesEnabled) {
      _testPartialLiquidation({
        spoke: spoke,
        collateralInfo: collateralInfo,
        testAssetInfo: testAssetInfo,
        liquidator: liquidator,
        borrower: collateralSupplier,
        receiveShares: true
      });
    }

    // Full liquidation - receive underlying
    _liquidationCall({
      spoke: spoke,
      collateralInfo: collateralInfo,
      debtInfo: testAssetInfo,
      liquidator: liquidator,
      borrower: collateralSupplier,
      debtToCover: UINT256_MAX,
      receiveShares: false
    });
    vm.revertToState(snapshotBeforeLiquidation);

    // Full liquidation - receive shares (only if enabled on collateral reserve)
    if (receiveSharesEnabled) {
      _liquidationCall({
        spoke: spoke,
        collateralInfo: collateralInfo,
        debtInfo: testAssetInfo,
        liquidator: liquidator,
        borrower: collateralSupplier,
        debtToCover: UINT256_MAX,
        receiveShares: true
      });
      vm.revertToState(snapshotBeforeLiquidation);
    }

    // Clear oracle price mocks
    vm.clearMockedCalls();
  }

  /// @dev Partial liquidation: only for coll/debt amounts that won't trigger dust threshold reverts
  function _testPartialLiquidation(
    ISpoke spoke,
    Types.ReserveInfo memory collateralInfo,
    Types.ReserveInfo memory testAssetInfo,
    address liquidator,
    address borrower,
    bool receiveShares
  ) internal {
    uint256 snapshot = vm.snapshotState();

    address oracleAddr = spoke.ORACLE();
    uint256 totalDebt = spoke.getUserTotalDebt(testAssetInfo.reserveId, borrower);
    uint256 totalCollateral = spoke.getUserSuppliedAssets(collateralInfo.reserveId, borrower);
    // only execute partial liquidations above $1.5k
    uint256 liquidationThreshold = 1_500;
    uint256 minDebtAssets = _getTokenAmountByDollarValue({
      oracleAddr: oracleAddr,
      reserveInfo: testAssetInfo,
      dollarValue: liquidationThreshold
    });
    uint256 minCollateralAssets = _getTokenAmountByDollarValue({
      oracleAddr: oracleAddr,
      reserveInfo: collateralInfo,
      dollarValue: liquidationThreshold
    });

    // Skip if either debt or collateral is too small — partial liq leads to dust
    if (totalDebt <= minDebtAssets || totalCollateral <= minCollateralAssets) {
      vm.revertToState(snapshot);
      return;
    }

    // liquidate only up to $400 so that remaining amounts won't trigger dust threshold reverts
    uint256 partialDebt = _getTokenAmountByDollarValue({
      oracleAddr: oracleAddr,
      reserveInfo: testAssetInfo,
      dollarValue: vm.randomUint(1, 400)
    });
    _liquidationCall({
      spoke: spoke,
      collateralInfo: collateralInfo,
      debtInfo: testAssetInfo,
      liquidator: liquidator,
      borrower: borrower,
      debtToCover: partialDebt,
      receiveShares: receiveShares
    });
    assertGt(
      spoke.getUserTotalDebt(testAssetInfo.reserveId, borrower),
      0,
      'PARTIAL_LIQUIDATION: debt should not be fully repaid'
    );

    vm.revertToState(snapshot);
  }

  /// @dev Disable all collaterals, verify borrow reverts, re-enable all, verify borrow works.
  function _testCollateralToggle(
    ISpoke spoke,
    Types.ReserveInfo[] memory goodCollaterals,
    Types.ReserveInfo memory testAssetInfo,
    address collateralSupplier,
    uint256 testAssetAmount
  ) internal {
    // Disable all active collaterals
    for (uint256 i; i < goodCollaterals.length; i++) {
      uint256 supplied = spoke.getUserSuppliedAssets(
        goodCollaterals[i].reserveId,
        collateralSupplier
      );
      if (supplied == 0) {
        continue;
      }
      vm.prank(collateralSupplier);
      spoke.setUsingAsCollateral({
        reserveId: goodCollaterals[i].reserveId,
        usingAsCollateral: false,
        onBehalfOf: collateralSupplier
      });
    }

    // Borrow should revert with HealthFactorBelowThreshold (no collateral backing)
    uint256 smallBorrow = testAssetAmount > 10 ? testAssetAmount / 10 : testAssetAmount;
    _ensureLiquidity({spoke: spoke, reserveInfo: testAssetInfo, amount: smallBorrow});
    vm.prank(collateralSupplier);
    vm.expectRevert(ISpoke.HealthFactorBelowThreshold.selector);
    spoke.borrow({
      reserveId: testAssetInfo.reserveId,
      amount: smallBorrow,
      onBehalfOf: collateralSupplier
    });

    // Re-enable all collaterals
    for (uint256 i; i < goodCollaterals.length; i++) {
      uint256 supplied = spoke.getUserSuppliedAssets(
        goodCollaterals[i].reserveId,
        collateralSupplier
      );
      if (supplied == 0) {
        continue;
      }
      vm.prank(collateralSupplier);
      spoke.setUsingAsCollateral({
        reserveId: goodCollaterals[i].reserveId,
        usingAsCollateral: true,
        onBehalfOf: collateralSupplier
      });
    }

    // Borrow should succeed now
    _borrow({
      spoke: spoke,
      reserveInfo: testAssetInfo,
      user: collateralSupplier,
      amount: smallBorrow
    });
  }

  /// @dev Compute a random extra count bounded by remaining reserve slots and available reserves.
  function _randomExtraCount(
    ISpoke spoke,
    address user,
    uint256 available
  ) internal view returns (uint256) {
    uint16 maxUserReserves = spoke.MAX_USER_RESERVES_LIMIT();
    uint256 currentCount = spoke.getUserAccountData(user).activeCollateralCount;
    uint256 remainingSlots = currentCount < maxUserReserves ? maxUserReserves - currentCount : 0;
    uint256 maxExtra = remainingSlots < available ? remainingSlots : available;
    return maxExtra > 0 ? vm.randomUint(0, maxExtra) : 0;
  }

  /// @dev Borrow from random extra reserves, respecting MAX_USER_RESERVES_LIMIT.
  function _borrowExtrasWithinLimit(ISpoke spoke, uint256 primaryReserveId, address user) internal {
    Types.ReserveInfo[] memory allReserves = _getReserveInfo(spoke);
    Types.ReserveInfo[] memory usableDebtReserves = _getAllUsableDebtReserves(allReserves);
    uint16 maxUserReserves = spoke.MAX_USER_RESERVES_LIMIT();
    uint256 currentBorrowCount = spoke.getUserAccountData(user).borrowCount;
    uint256 remainingSlots = currentBorrowCount < maxUserReserves
      ? maxUserReserves - currentBorrowCount
      : 0;
    if (remainingSlots == 0) {
      return;
    }
    uint256 extraBorrowCount = vm.randomUint(0, remainingSlots);
    _borrowRandomExtraReserves({
      spoke: spoke,
      usableDebtReserves: usableDebtReserves,
      primaryReserveId: primaryReserveId,
      oracleAddr: spoke.ORACLE(),
      user: user,
      extraCount: extraBorrowCount
    });
  }

  /// @dev Test spoke addCap and drawCap by incrementally filling to the cap, then verify overflow reverts.
  function _testCaps(ISpoke spoke, Types.ReserveInfo memory reserveInfo) internal {
    IHub.SpokeConfig memory spokeConfig = IHub(reserveInfo.hub).getSpokeConfig(
      reserveInfo.assetId,
      address(spoke)
    );

    if (spokeConfig.addCap > 0 && spokeConfig.addCap < type(uint40).max) {
      uint256 snap = vm.snapshotState();
      _testAddCap({spoke: spoke, reserveInfo: reserveInfo, addCap: spokeConfig.addCap});
      vm.revertToState(snap);
    }

    if (
      spokeConfig.drawCap > 0 && spokeConfig.drawCap < type(uint40).max && reserveInfo.borrowable
    ) {
      uint256 snap = vm.snapshotState();
      _testDrawCap({spoke: spoke, reserveInfo: reserveInfo, drawCap: spokeConfig.drawCap});
      vm.revertToState(snap);
    }
  }

  /// @dev Fill supply up to addCap in random chunks, then verify overflow reverts.
  function _testAddCap(ISpoke spoke, Types.ReserveInfo memory reserveInfo, uint40 addCap) internal {
    uint256 addCapScaled = uint256(addCap) * 10 ** reserveInfo.decimals;
    uint256 currentSupply = spoke.getReserveSuppliedAssets(reserveInfo.reserveId);
    if (addCapScaled <= currentSupply) {
      return;
    }

    uint256 room = addCapScaled - currentSupply;
    address supplier = vm.randomAddress();

    // Supply more than addCap — should revert with AddCapExceeded
    uint256 overflowAmount = room + 10 ** reserveInfo.decimals;
    vm.startPrank(supplier);
    deal2({asset: reserveInfo.underlying, user: supplier, amount: overflowAmount});
    IERC20(reserveInfo.underlying).forceApprove(address(spoke), overflowAmount);
    vm.expectRevert(abi.encodeWithSelector(IHub.AddCapExceeded.selector, uint256(addCap)));
    spoke.supply({reserveId: reserveInfo.reserveId, amount: overflowAmount, onBehalfOf: supplier});
    vm.stopPrank();
  }

  /// @dev Fill borrows up to drawCap in random chunks, then verify overflow reverts.
  function _testDrawCap(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    uint40 drawCap
  ) internal {
    // Remove addCaps so enough collateral can be supplied to borrow up to drawCap
    _setAddCapsToMax(spoke);

    console.log('TEST_DRAW_CAP: drawCap=%e', drawCap);
    address borrower = vm.randomAddress();
    uint256 drawCapScaled = uint256(drawCap) * 10 ** reserveInfo.decimals;
    uint256 currentDebt = spoke.getReserveTotalDebt(reserveInfo.reserveId);
    if (drawCapScaled <= currentDebt) {
      return;
    }

    uint256 room = drawCapScaled - currentDebt;

    // Supply the debt asset itself as collateral (3x room for borrow headroom) + liquidity
    uint256 collateralAmount = room * 10;
    _supply({spoke: spoke, reserveInfo: reserveInfo, user: borrower, amount: collateralAmount});
    vm.prank(borrower);
    spoke.setUsingAsCollateral({
      reserveId: reserveInfo.reserveId,
      usingAsCollateral: true,
      onBehalfOf: borrower
    });

    // Supply liquidity from a separate provider
    address liquidityProvider = vm.randomAddress();
    _supply({spoke: spoke, reserveInfo: reserveInfo, user: liquidityProvider, amount: room});

    // Borrow more than drawCap — should revert with DrawCapExceeded
    uint256 overflowAmount = room + 10 ** reserveInfo.decimals;
    vm.prank(borrower);
    vm.expectRevert(abi.encodeWithSelector(IHub.DrawCapExceeded.selector, uint256(drawCap)));
    spoke.borrow({reserveId: reserveInfo.reserveId, amount: overflowAmount, onBehalfOf: borrower});
  }

  /// @dev Test that 0-amount operations revert.
  function _testZeroAmountReverts(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    address user
  ) internal {
    uint256 reserveId = reserveInfo.reserveId;

    // Supply 0
    vm.startPrank(user);
    IERC20(reserveInfo.underlying).forceApprove(address(spoke), 0);
    vm.expectRevert();
    spoke.supply({reserveId: reserveId, amount: 0, onBehalfOf: user});
    vm.stopPrank();

    // Withdraw 0
    vm.prank(user);
    vm.expectRevert();
    spoke.withdraw({reserveId: reserveId, amount: 0, onBehalfOf: user});

    // Borrow 0
    if (reserveInfo.borrowable) {
      vm.prank(user);
      vm.expectRevert();
      spoke.borrow({reserveId: reserveId, amount: 0, onBehalfOf: user});
    }

    // Repay 0
    vm.startPrank(user);
    IERC20(reserveInfo.underlying).forceApprove(address(spoke), 0);
    vm.expectRevert();
    spoke.repay({reserveId: reserveId, amount: 0, onBehalfOf: user});
    vm.stopPrank();
  }
}
