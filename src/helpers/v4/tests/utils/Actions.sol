// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {CommonTestBase} from 'aave-helpers/src/CommonTestBase.sol';
import {ISpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ISpoke.sol';
import {IHubBase} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IHubBase.sol';
import {Types} from './Types.sol';

/// @title Actions
/// @notice Low-level spoke actions with hub and spoke accounting assertions.
abstract contract Actions is CommonTestBase {
  using SafeERC20 for IERC20;

  uint256 constant HEALTH_FACTOR_LIQUIDATION_THRESHOLD = 1e18;

  function _logAction(string memory action, string memory symbol, uint256 amount) internal pure {
    if (amount == UINT256_MAX) {
      console.log('%s: %s, Amount: UINT256_MAX', action, symbol);
    } else {
      console.log('%s: %s, Amount: %e', action, symbol, amount);
    }
  }

  function _getUserAccounting(
    ISpoke spoke,
    uint256 reserveId,
    address user
  ) internal view returns (Types.Accounting memory) {
    (uint256 drawnDebt, uint256 premiumDebt) = spoke.getUserDebt(reserveId, user);
    ISpoke.UserPosition memory position = spoke.getUserPosition(reserveId, user);
    return
      Types.Accounting({
        collateralShares: position.suppliedShares,
        collateralAssets: spoke.getUserSuppliedAssets(reserveId, user),
        drawnDebt: drawnDebt,
        premiumDebt: premiumDebt,
        totalDebt: spoke.getUserTotalDebt(reserveId, user),
        drawnShares: position.drawnShares,
        premiumShares: position.premiumShares,
        premiumOffsetRay: position.premiumOffsetRay
      });
  }

  function _getReserveAccounting(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo
  ) internal view returns (Types.Accounting memory) {
    IHubBase hub = IHubBase(reserveInfo.hub);
    uint16 assetId = reserveInfo.assetId;
    (uint256 drawnDebt, uint256 premiumDebt) = hub.getSpokeOwed(assetId, address(spoke));
    (uint256 premiumShares, int256 premiumOffsetRay) = hub.getSpokePremiumData(
      assetId,
      address(spoke)
    );
    return
      Types.Accounting({
        collateralShares: spoke.getReserveSuppliedShares(reserveInfo.reserveId),
        collateralAssets: spoke.getReserveSuppliedAssets(reserveInfo.reserveId),
        drawnDebt: drawnDebt,
        premiumDebt: premiumDebt,
        totalDebt: spoke.getReserveTotalDebt(reserveInfo.reserveId),
        drawnShares: hub.getSpokeDrawnShares(assetId, address(spoke)),
        premiumShares: premiumShares,
        premiumOffsetRay: premiumOffsetRay
      });
  }

  function _getHubSpokeAccounting(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo
  ) internal view returns (Types.Accounting memory) {
    IHubBase hub = IHubBase(reserveInfo.hub);
    uint16 assetId = reserveInfo.assetId;
    address spokeAddr = address(spoke);
    (uint256 spokeDrawnOwed, uint256 spokePremiumOwed) = hub.getSpokeOwed(assetId, spokeAddr);
    (uint256 premiumShares, int256 premiumOffsetRay) = hub.getSpokePremiumData(assetId, spokeAddr);
    return
      Types.Accounting({
        collateralShares: hub.getSpokeAddedShares(assetId, spokeAddr),
        collateralAssets: hub.getSpokeAddedAssets(assetId, spokeAddr),
        drawnDebt: spokeDrawnOwed,
        premiumDebt: spokePremiumOwed,
        totalDebt: hub.getSpokeTotalOwed(assetId, spokeAddr),
        drawnShares: hub.getSpokeDrawnShares(assetId, spokeAddr),
        premiumShares: premiumShares,
        premiumOffsetRay: premiumOffsetRay
      });
  }

  function _getPositionSnapshot(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    address user
  ) internal view returns (Types.PositionSnapshot memory) {
    return
      Types.PositionSnapshot({
        user: _getUserAccounting({spoke: spoke, reserveId: reserveInfo.reserveId, user: user}),
        reserve: _getReserveAccounting({spoke: spoke, reserveInfo: reserveInfo}),
        hubSpoke: _getHubSpokeAccounting({spoke: spoke, reserveInfo: reserveInfo})
      });
  }

  /// @notice Skip time, assert debt accounting grew as expected, then revert.
  function _skipTimeAndCheckAccounting(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    address user,
    uint256 skipDays
  ) internal {
    uint256 snapshot = vm.snapshotState();

    Types.PositionSnapshot memory snapshotBefore = _getPositionSnapshot(spoke, reserveInfo, user);

    skip(skipDays * 1 days);

    Types.PositionSnapshot memory snapshotAfter = _getPositionSnapshot(spoke, reserveInfo, user);

    // User debt should not decrease over time
    assertGe(
      snapshotAfter.user.totalDebt,
      snapshotBefore.user.totalDebt,
      'TIME_SKIP: user total debt decreased'
    );
    assertGe(
      snapshotAfter.user.drawnDebt,
      snapshotBefore.user.drawnDebt,
      'TIME_SKIP: user drawn debt decreased'
    );

    // Reserve debt should not decrease over time
    assertGe(
      snapshotAfter.reserve.totalDebt,
      snapshotBefore.reserve.totalDebt,
      'TIME_SKIP: reserve total debt decreased'
    );
    assertGe(
      snapshotAfter.reserve.drawnDebt,
      snapshotBefore.reserve.drawnDebt,
      'TIME_SKIP: reserve drawn debt decreased'
    );

    // Hub spoke owed should not decrease over time
    assertGe(
      snapshotAfter.hubSpoke.totalDebt,
      snapshotBefore.hubSpoke.totalDebt,
      'TIME_SKIP: hub spoke owed decreased'
    );
    assertGe(
      snapshotAfter.hubSpoke.drawnDebt,
      snapshotBefore.hubSpoke.drawnDebt,
      'TIME_SKIP: hub spoke drawn decreased'
    );

    // Hub drawn index should have grown
    IHubBase hub = IHubBase(reserveInfo.hub);
    uint256 drawnIndexAfter = hub.getAssetDrawnIndex(reserveInfo.assetId);
    assertGt(drawnIndexAfter, 1e27, 'TIME_SKIP: drawn index should be greater than 1e27');

    vm.revertToState(snapshot);
  }

  function _supply(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    address user,
    uint256 amount
  ) internal {
    require(!reserveInfo.paused, 'SUPPLY: PAUSED_RESERVE');
    require(!reserveInfo.frozen, 'SUPPLY: FROZEN_RESERVE');

    Types.PositionSnapshot memory snapshotBefore = _getPositionSnapshot(spoke, reserveInfo, user);

    vm.startPrank(user);
    deal2(reserveInfo.underlying, user, amount);
    IERC20(reserveInfo.underlying).forceApprove(address(spoke), amount);
    _logAction('SUPPLY', reserveInfo.symbol, amount);
    (uint256 returnedShares, uint256 returnedAssets) = spoke.supply({
      reserveId: reserveInfo.reserveId,
      amount: amount,
      onBehalfOf: user
    });
    vm.stopPrank();

    Types.PositionSnapshot memory snapshotAfter = _getPositionSnapshot(spoke, reserveInfo, user);

    assertEq(returnedAssets, amount, 'SUPPLY: returnedAssets mismatch');

    // User
    assertEq(
      snapshotAfter.user.collateralAssets,
      snapshotBefore.user.collateralAssets + amount,
      'SUPPLY: user assets mismatch'
    );
    assertEq(
      snapshotAfter.user.collateralShares,
      snapshotBefore.user.collateralShares + returnedShares,
      'SUPPLY: user shares mismatch'
    );
    // Hub spoke
    assertEq(
      snapshotAfter.hubSpoke.collateralAssets,
      snapshotBefore.hubSpoke.collateralAssets + amount,
      'SUPPLY: hub assets mismatch'
    );
    uint256 expectedAddedShares = IHubBase(reserveInfo.hub).previewAddByAssets(
      reserveInfo.assetId,
      amount
    );
    assertEq(returnedShares, expectedAddedShares, 'SUPPLY: returnedShares mismatch');
    assertEq(
      snapshotAfter.hubSpoke.collateralShares,
      snapshotBefore.hubSpoke.collateralShares + expectedAddedShares,
      'SUPPLY: hub shares mismatch'
    );
  }

  function _withdraw(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    address user,
    uint256 amount
  ) internal {
    Types.PositionSnapshot memory snapshotBefore = _getPositionSnapshot(spoke, reserveInfo, user);

    vm.startPrank(user);
    _logAction('WITHDRAW', reserveInfo.symbol, amount);
    (uint256 returnedShares, uint256 withdrawnAmount) = spoke.withdraw({
      reserveId: reserveInfo.reserveId,
      amount: amount,
      onBehalfOf: user
    });
    vm.stopPrank();

    Types.PositionSnapshot memory snapshotAfter = _getPositionSnapshot(spoke, reserveInfo, user);

    if (amount >= snapshotBefore.user.collateralAssets) {
      assertEq(snapshotAfter.user.collateralAssets, 0, 'WITHDRAW: user assets should be zero');
      assertEq(snapshotAfter.user.collateralShares, 0, 'WITHDRAW: user shares should be zero');
    } else {
      assertEq(
        snapshotAfter.user.collateralAssets,
        snapshotBefore.user.collateralAssets - withdrawnAmount,
        'WITHDRAW: user assets mismatch'
      );
      assertEq(
        snapshotBefore.user.collateralShares - snapshotAfter.user.collateralShares,
        returnedShares,
        'WITHDRAW: user shares delta mismatch'
      );
    }
    // Hub spoke
    assertEq(
      snapshotBefore.hubSpoke.collateralAssets - snapshotAfter.hubSpoke.collateralAssets,
      withdrawnAmount,
      'WITHDRAW: hub assets mismatch'
    );
    uint256 expectedSharesDelta = IHubBase(reserveInfo.hub).previewRemoveByAssets(
      reserveInfo.assetId,
      withdrawnAmount
    );
    assertEq(returnedShares, expectedSharesDelta, 'WITHDRAW: returnedShares mismatch');
    assertEq(
      snapshotBefore.hubSpoke.collateralShares - snapshotAfter.hubSpoke.collateralShares,
      expectedSharesDelta,
      'WITHDRAW: hub shares mismatch'
    );
  }

  function _borrow(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    address user,
    uint256 amount
  ) internal {
    Types.PositionSnapshot memory snapshotBefore = _getPositionSnapshot(spoke, reserveInfo, user);
    uint256 expectedDrawnShares = IHubBase(reserveInfo.hub).previewDrawByAssets(
      reserveInfo.assetId,
      amount
    );

    _logAction('BORROW', reserveInfo.symbol, amount);
    vm.prank(user);
    (uint256 returnedShares, uint256 returnedAssets) = spoke.borrow({
      reserveId: reserveInfo.reserveId,
      amount: amount,
      onBehalfOf: user
    });

    Types.PositionSnapshot memory snapshotAfter = _getPositionSnapshot(spoke, reserveInfo, user);

    assertEq(returnedAssets, amount, 'BORROW: returnedAssets mismatch');
    assertEq(returnedShares, expectedDrawnShares, 'BORROW: returnedShares mismatch');

    // User debt
    assertEq(
      snapshotAfter.user.totalDebt,
      snapshotBefore.user.totalDebt + amount,
      'BORROW: user debt mismatch'
    );
    assertEq(
      snapshotAfter.user.drawnDebt,
      snapshotBefore.user.drawnDebt + returnedAssets,
      'BORROW: user drawn debt mismatch'
    );
    // Hub spoke
    assertEq(
      snapshotAfter.hubSpoke.totalDebt,
      snapshotBefore.hubSpoke.totalDebt + amount,
      'BORROW: hub debt mismatch'
    );
    assertEq(
      snapshotAfter.hubSpoke.drawnShares,
      snapshotBefore.hubSpoke.drawnShares + expectedDrawnShares,
      'BORROW: hub drawn shares mismatch'
    );
  }

  function _repay(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    address user,
    uint256 amount
  ) internal {
    Types.PositionSnapshot memory snapshotBefore = _getPositionSnapshot(spoke, reserveInfo, user);
    uint256 effectiveRepayAmount = amount >= snapshotBefore.user.totalDebt
      ? snapshotBefore.user.totalDebt
      : amount;
    uint256 expectedRestoredShares = IHubBase(reserveInfo.hub).previewRestoreByAssets(
      reserveInfo.assetId,
      effectiveRepayAmount
    );

    vm.startPrank(user);
    // deal additional to ensure full repay possible
    deal2(reserveInfo.underlying, user, amount * 2);
    IERC20(reserveInfo.underlying).forceApprove(address(spoke), amount * 2);
    _logAction('REPAY', reserveInfo.symbol, amount);
    (uint256 returnedShares, uint256 returnedAssets) = spoke.repay({
      reserveId: reserveInfo.reserveId,
      amount: amount,
      onBehalfOf: user
    });
    vm.stopPrank();

    Types.PositionSnapshot memory snapshotAfter = _getPositionSnapshot(spoke, reserveInfo, user);

    assertEq(returnedAssets, effectiveRepayAmount, 'REPAY: returnedAssets mismatch');
    assertEq(returnedShares, expectedRestoredShares, 'REPAY: returnedShares mismatch');

    if (amount >= snapshotBefore.user.totalDebt) {
      assertEq(snapshotAfter.user.totalDebt, 0, 'REPAY: user debt should be zero');
    } else {
      assertEq(
        stdMath.delta(snapshotAfter.user.totalDebt, snapshotBefore.user.totalDebt),
        amount,
        'REPAY: user debt mismatch'
      );
    }
    // Hub spoke
    assertEq(
      stdMath.delta(snapshotBefore.hubSpoke.totalDebt, snapshotAfter.hubSpoke.totalDebt),
      effectiveRepayAmount,
      'REPAY: hub debt mismatch'
    );
    assertEq(
      stdMath.delta(snapshotBefore.hubSpoke.drawnShares, snapshotAfter.hubSpoke.drawnShares),
      expectedRestoredShares,
      'REPAY: hub drawn shares mismatch'
    );
  }

  function _liquidationCall(
    ISpoke spoke,
    Types.ReserveInfo memory collateralInfo,
    Types.ReserveInfo memory debtInfo,
    address liquidator,
    address borrower,
    uint256 debtToCover,
    bool receiveShares
  ) internal {
    Types.PositionSnapshot memory collateralSnapshotBefore = _getPositionSnapshot(
      spoke,
      collateralInfo,
      borrower
    );
    Types.PositionSnapshot memory debtSnapshotBefore = _getPositionSnapshot(
      spoke,
      debtInfo,
      borrower
    );
    assertGt(debtSnapshotBefore.user.totalDebt, 0, 'LIQUIDATE: borrower has no debt');

    vm.startPrank(liquidator);
    uint256 dealAmount = debtSnapshotBefore.user.totalDebt * 2;
    deal2(debtInfo.underlying, liquidator, dealAmount);
    IERC20(debtInfo.underlying).forceApprove(address(spoke), debtToCover);

    if (debtToCover == UINT256_MAX) {
      console.log(
        'LIQUIDATE: %s, DebtToCover: UINT256_MAX, TotalDebt: %e',
        debtInfo.symbol,
        debtSnapshotBefore.user.totalDebt
      );
    } else {
      console.log(
        'LIQUIDATE: %s, DebtToCover: %e, TotalDebt: %e',
        debtInfo.symbol,
        debtToCover,
        debtSnapshotBefore.user.totalDebt
      );
    }

    spoke.liquidationCall({
      collateralReserveId: collateralInfo.reserveId,
      debtReserveId: debtInfo.reserveId,
      user: borrower,
      debtToCover: debtToCover,
      receiveShares: receiveShares
    });
    vm.stopPrank();

    Types.PositionSnapshot memory collateralSnapshotAfter = _getPositionSnapshot(
      spoke,
      collateralInfo,
      borrower
    );
    Types.PositionSnapshot memory debtSnapshotAfter = _getPositionSnapshot(
      spoke,
      debtInfo,
      borrower
    );

    // Debt decreased
    assertLt(
      debtSnapshotAfter.user.totalDebt,
      debtSnapshotBefore.user.totalDebt,
      'LIQUIDATE: debt did not decrease'
    );
    assertLt(
      debtSnapshotAfter.hubSpoke.totalDebt,
      debtSnapshotBefore.hubSpoke.totalDebt,
      'LIQUIDATE: hub debt did not decrease'
    );
    // Collateral decreased
    assertLt(
      collateralSnapshotAfter.user.collateralAssets,
      collateralSnapshotBefore.user.collateralAssets,
      'LIQUIDATE: collateral did not decrease'
    );
  }
}
