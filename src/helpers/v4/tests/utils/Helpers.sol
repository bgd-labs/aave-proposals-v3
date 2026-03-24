// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {ISpoke} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/ISpoke.sol';
import {IHubConfigurator} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IHubConfigurator.sol';
import {IAaveOracle} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/interfaces/IAaveOracle.sol';
import {AaveV4EthereumAddresses} from 'src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4EthereumAddresses.sol';
import {Types} from './Types.sol';
import {Actions} from './Actions.sol';

/// @title Helpers
/// @notice Query and utility functions for V4 e2e tests.
abstract contract Helpers is Actions {
  /// @notice Build ReserveInfo[] for all reserves on a spoke.
  function _getReserveInfo(ISpoke spoke) internal view returns (Types.ReserveInfo[] memory) {
    uint256 count = spoke.getReserveCount();
    Types.ReserveInfo[] memory info = new Types.ReserveInfo[](count);

    for (uint256 i; i < count; i++) {
      ISpoke.Reserve memory reserve = spoke.getReserve(i);
      ISpoke.ReserveConfig memory config = spoke.getReserveConfig(i);
      ISpoke.DynamicReserveConfig memory dynamicConfig = spoke.getDynamicReserveConfig(
        i,
        reserve.dynamicConfigKey
      );

      string memory symbol = _safeSymbol(reserve.underlying);

      info[i] = Types.ReserveInfo({
        reserveId: i,
        underlying: reserve.underlying,
        hub: address(reserve.hub),
        assetId: reserve.assetId,
        symbol: symbol,
        decimals: reserve.decimals,
        paused: config.paused,
        frozen: config.frozen,
        borrowable: config.borrowable,
        collateralEnabled: dynamicConfig.collateralFactor > 0,
        collateralFactor: dynamicConfig.collateralFactor,
        maxLiquidationBonus: dynamicConfig.maxLiquidationBonus,
        liquidationFee: dynamicConfig.liquidationFee
      });
    }
    return info;
  }

  /// @notice Return all usable collaterals: not paused, not frozen, collateralFactor > 0.
  function _getAllUsableCollaterals(
    Types.ReserveInfo[] memory infos
  ) internal pure returns (Types.ReserveInfo[] memory) {
    uint256 count;
    for (uint256 i; i < infos.length; i++) {
      if (!infos[i].paused && !infos[i].frozen && infos[i].collateralEnabled) {
        count++;
      }
    }
    Types.ReserveInfo[] memory result = new Types.ReserveInfo[](count);
    uint256 index;
    for (uint256 i; i < infos.length; i++) {
      if (!infos[i].paused && !infos[i].frozen && infos[i].collateralEnabled) {
        result[index] = infos[i];
        index++;
      }
    }
    return result;
  }

  /// @notice Return all usable debt reserves: not paused, not frozen, borrowable.
  function _getAllUsableDebtReserves(
    Types.ReserveInfo[] memory infos
  ) internal pure returns (Types.ReserveInfo[] memory) {
    uint256 count;
    for (uint256 i; i < infos.length; i++) {
      if (!infos[i].paused && !infos[i].frozen && infos[i].borrowable) {
        count++;
      }
    }
    Types.ReserveInfo[] memory result = new Types.ReserveInfo[](count);
    uint256 index;
    for (uint256 i; i < infos.length; i++) {
      if (!infos[i].paused && !infos[i].frozen && infos[i].borrowable) {
        result[index] = infos[i];
        index++;
      }
    }
    return result;
  }

  /// @notice Ensure the hub has enough liquidity for a borrow by supplying on the given spoke.
  ///         Assumes addCaps have been set to max via _setCapsToMax before calling.
  function _ensureLiquidity(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    uint256 amount
  ) internal {
    _supply({spoke: spoke, reserveInfo: reserveInfo, user: vm.randomAddress(), amount: amount});
  }

  /// @notice Supply collateral to borrower on the same spoke, then enable as collateral.
  ///         Assumes addCaps have been set to max via _setCapsToMax before calling.
  function _ensureCollateral(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    address borrower,
    uint256 amount
  ) internal {
    _supply({spoke: spoke, reserveInfo: reserveInfo, user: borrower, amount: amount});
    vm.prank(borrower);
    spoke.setUsingAsCollateral({
      reserveId: reserveInfo.reserveId,
      usingAsCollateral: true,
      onBehalfOf: borrower
    });
  }

  /// @notice Ensure borrower has enough collateral to borrow a given dollar amount.
  ///         Loops over all collateral-enabled reserves, supplying until capacity is sufficient.
  ///         Compares against CF-adjusted totalCollateralValue, so it may use multiple reserves.
  function _ensureBorrowCapacity(
    ISpoke spoke,
    address borrower,
    uint256 borrowAmountInDollars
  ) internal {
    Types.ReserveInfo[] memory goodCollaterals = _getAllUsableCollaterals(_getReserveInfo(spoke));
    address oracleAddr = spoke.ORACLE();
    uint8 oracleDecimals = IAaveOracle(oracleAddr).decimals();
    uint256 targetCollateralDollarAmount = borrowAmountInDollars * 3;
    uint256 targetCollateralValue = targetCollateralDollarAmount * 10 ** oracleDecimals;

    for (uint256 i; i < goodCollaterals.length; i++) {
      uint256 supplyAmount = _getTokenAmountByDollarValue({
        oracleAddr: oracleAddr,
        reserveInfo: goodCollaterals[i],
        dollarValue: targetCollateralDollarAmount
      });

      _ensureCollateral({
        spoke: spoke,
        reserveInfo: goodCollaterals[i],
        borrower: borrower,
        amount: supplyAmount
      });

      // Check after supplying — totalCollateralValue is CF-adjusted, so we may need
      // multiple reserves to reach the target raw collateral value.
      ISpoke.UserAccountData memory account = spoke.getUserAccountData(borrower);
      if (account.totalCollateralValue > targetCollateralValue) {
        break;
      }
    }
  }

  /// @notice Convert a dollar value to token amount using the spoke oracle.
  function _getTokenAmountByDollarValue(
    address oracleAddr,
    Types.ReserveInfo memory reserveInfo,
    uint256 dollarValue
  ) internal view returns (uint256) {
    IAaveOracle oracle = IAaveOracle(oracleAddr);
    uint256 price = oracle.getReservePrice(reserveInfo.reserveId);
    uint8 oracleDecimals = oracle.decimals();
    return (dollarValue * 10 ** (oracleDecimals + reserveInfo.decimals)) / price;
  }

  /// @notice Supply up to `extraCount` of additional collaterals for the user, up to `maxUserReserves`.
  function _supplyRandomExtraCollaterals(
    ISpoke spoke,
    Types.ReserveInfo[] memory goodCollaterals,
    uint256 primaryIndex,
    uint256 testAssetReserveId,
    address oracleAddr,
    address user,
    uint256 extraCount
  ) internal {
    if (goodCollaterals.length <= 1 || extraCount == 0) {
      return;
    }

    uint16 maxUserReserves = spoke.MAX_USER_RESERVES_LIMIT();

    // Track collateral count before starting
    ISpoke.UserAccountData memory accountBefore = spoke.getUserAccountData(user);
    uint256 expectedCollateralCount = accountBefore.activeCollateralCount;

    uint256 supplied;
    for (uint256 index; index < goodCollaterals.length && supplied < extraCount; index++) {
      // skip the primary collateral and the test asset
      if (index == primaryIndex || goodCollaterals[index].reserveId == testAssetReserveId) {
        continue;
      }

      // When at the limit, assert the next collateral enable reverts, then restore state
      if (expectedCollateralCount + 1 > maxUserReserves) {
        _assertMaxUserReservesReverts({
          spoke: spoke,
          reserveInfo: goodCollaterals[index],
          oracleAddr: oracleAddr,
          user: user,
          isCollateral: true
        });
        break;
      }

      // adding too much collateral will mean user's HF is too high to make liquidatable easily
      uint256 extraDollars = vm.randomUint(1_000, 10_000);
      uint256 extraAmount = _getTokenAmountByDollarValue({
        oracleAddr: oracleAddr,
        reserveInfo: goodCollaterals[index],
        dollarValue: extraDollars
      });

      _supply({spoke: spoke, reserveInfo: goodCollaterals[index], user: user, amount: extraAmount});
      vm.prank(user);
      spoke.setUsingAsCollateral({
        reserveId: goodCollaterals[index].reserveId,
        usingAsCollateral: true,
        onBehalfOf: user
      });

      supplied++;
      expectedCollateralCount++;

      // Verify activeCollateralCount matches expected
      ISpoke.UserAccountData memory accountAfter = spoke.getUserAccountData(user);
      assertEq(
        accountAfter.activeCollateralCount,
        expectedCollateralCount,
        'EXTRA_COLLATERAL: activeCollateralCount mismatch'
      );
      assertLe(
        accountAfter.activeCollateralCount,
        maxUserReserves,
        'EXTRA_COLLATERAL: exceeds MAX_USER_RESERVES_LIMIT'
      );
    }
  }

  /// @notice Borrow from a random number of extra debt reserves for the user.
  ///         Supplies liquidity from a separate provider before each borrow.
  function _borrowRandomExtraReserves(
    ISpoke spoke,
    Types.ReserveInfo[] memory usableDebtReserves,
    uint256 primaryReserveId,
    address oracleAddr,
    address user,
    uint256 extraCount
  ) internal {
    if (usableDebtReserves.length <= 1 || extraCount == 0) {
      return;
    }

    uint16 maxUserReserves = spoke.MAX_USER_RESERVES_LIMIT();

    ISpoke.UserAccountData memory accountBefore = spoke.getUserAccountData(user);
    uint256 expectedBorrowCount = accountBefore.borrowCount;

    uint256 borrowed;
    for (uint256 index; index < usableDebtReserves.length && borrowed < extraCount; index++) {
      Types.ReserveInfo memory debtReserve = usableDebtReserves[index];

      if (debtReserve.reserveId == primaryReserveId) {
        continue;
      }

      // When at the limit, assert the next borrow reverts, then restore state
      if (expectedBorrowCount + 1 > maxUserReserves) {
        _assertMaxUserReservesReverts({
          spoke: spoke,
          reserveInfo: debtReserve,
          oracleAddr: oracleAddr,
          user: user,
          isCollateral: false
        });
        break;
      }

      uint256 extraDollars = vm.randomUint(100, 1_000);
      uint256 extraAmount = _getTokenAmountByDollarValue({
        oracleAddr: oracleAddr,
        reserveInfo: debtReserve,
        dollarValue: extraDollars
      });

      _ensureLiquidity({spoke: spoke, reserveInfo: debtReserve, amount: extraAmount});
      _borrow({spoke: spoke, reserveInfo: debtReserve, user: user, amount: extraAmount});

      borrowed++;
      expectedBorrowCount++;

      // Verify borrowCount within limit
      ISpoke.UserAccountData memory accountAfter = spoke.getUserAccountData(user);
      assertLe(
        accountAfter.borrowCount,
        maxUserReserves,
        'EXTRA_BORROW: exceeds MAX_USER_RESERVES_LIMIT'
      );
      assertEq(accountAfter.borrowCount, expectedBorrowCount, 'EXTRA_BORROW: borrowCount mismatch');
    }
  }

  /// @notice Assert that exceeding MAX_USER_RESERVES_LIMIT reverts, then restore state.
  function _assertMaxUserReservesReverts(
    ISpoke spoke,
    Types.ReserveInfo memory reserveInfo,
    address oracleAddr,
    address user,
    bool isCollateral
  ) internal {
    uint256 snapshot = vm.snapshotState();

    uint256 dollarValue = vm.randomUint(1_000, 50_000);
    uint256 amount = _getTokenAmountByDollarValue({
      oracleAddr: oracleAddr,
      reserveInfo: reserveInfo,
      dollarValue: dollarValue
    });

    if (isCollateral) {
      _supply({spoke: spoke, reserveInfo: reserveInfo, user: user, amount: amount});
      vm.prank(user);
      vm.expectRevert(ISpoke.MaximumUserReservesExceeded.selector);
      spoke.setUsingAsCollateral({
        reserveId: reserveInfo.reserveId,
        usingAsCollateral: true,
        onBehalfOf: user
      });
    } else {
      _ensureLiquidity({spoke: spoke, reserveInfo: reserveInfo, amount: amount});
      vm.prank(user);
      vm.expectRevert(ISpoke.MaximumUserReservesExceeded.selector);
      spoke.borrow({reserveId: reserveInfo.reserveId, amount: amount, onBehalfOf: user});
    }

    vm.revertToState(snapshot);
  }

  /// @notice Set all addCap/drawCap to max for every reserve on the spoke.
  function _setCapsToMax(ISpoke spoke) internal {
    address hubConfigurator = AaveV4EthereumAddresses.HUB_CONFIGURATOR;

    Types.ReserveInfo[] memory infos = _getReserveInfo(spoke);
    vm.mockCall(
      AaveV4EthereumAddresses.ACCESS_MANAGER,
      abi.encodeWithSelector(bytes4(keccak256('canCall(address,address,bytes4)'))),
      abi.encode(true, uint32(0))
    );
    for (uint256 i; i < infos.length; i++) {
      IHubConfigurator(hubConfigurator).updateSpokeCaps({
        hub: infos[i].hub,
        assetId: infos[i].assetId,
        spoke: address(spoke),
        addCap: type(uint40).max,
        drawCap: type(uint40).max
      });
    }
    vm.clearMockedCalls();
  }

  /// @notice Set all addCap to max for every reserve on the spoke (leaves drawCap unchanged).
  function _setAddCapsToMax(ISpoke spoke) internal {
    address hubConfigurator = AaveV4EthereumAddresses.HUB_CONFIGURATOR;

    Types.ReserveInfo[] memory infos = _getReserveInfo(spoke);
    vm.mockCall(
      AaveV4EthereumAddresses.ACCESS_MANAGER,
      abi.encodeWithSelector(bytes4(keccak256('canCall(address,address,bytes4)'))),
      abi.encode(true, uint32(0))
    );
    for (uint256 i; i < infos.length; i++) {
      IHubConfigurator(hubConfigurator).updateSpokeAddCap({
        hub: infos[i].hub,
        assetId: infos[i].assetId,
        spoke: address(spoke),
        addCap: type(uint40).max
      });
    }
    vm.clearMockedCalls();
  }

  /// @notice Safely get the ERC20 symbol, fallback to "UNKNOWN".
  function _safeSymbol(address token) internal view returns (string memory) {
    try IERC20Metadata(token).symbol() returns (string memory s) {
      return s;
    } catch {
      return 'UNKNOWN';
    }
  }

  /// @notice Half a token in the asset's native decimals.
  function _halfToken(uint8 decimals) internal pure returns (uint256) {
    return 10 ** decimals / 2;
  }
}
