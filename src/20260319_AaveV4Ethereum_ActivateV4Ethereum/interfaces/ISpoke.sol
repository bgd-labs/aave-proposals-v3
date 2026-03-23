// SPDX-License-Identifier: LicenseRef-BUSL
pragma solidity ^0.8.0;

import {IHubBase} from './IHubBase.sol';

interface ISpoke {
  struct Reserve {
    address underlying;
    address hub;
    uint16 assetId;
    uint8 decimals;
    uint24 collateralRisk;
    uint8 flags;
    uint32 dynamicConfigKey;
  }

  struct ReserveConfig {
    uint24 collateralRisk;
    bool paused;
    bool frozen;
    bool borrowable;
    bool receiveSharesEnabled;
  }

  struct DynamicReserveConfig {
    uint16 collateralFactor;
    uint32 maxLiquidationBonus;
    uint16 liquidationFee;
  }

  struct LiquidationConfig {
    uint128 targetHealthFactor;
    uint64 healthFactorForMaxBonus;
    uint16 liquidationBonusFactor;
  }

  struct UserPosition {
    uint120 drawnShares;
    uint120 premiumShares;
    int200 premiumOffsetRay;
    uint120 suppliedShares;
    uint32 dynamicConfigKey;
  }

  struct UserAccountData {
    uint256 riskPremium;
    uint256 avgCollateralFactor;
    uint256 healthFactor;
    uint256 totalCollateralValue;
    uint256 totalDebtValueRay;
    uint256 activeCollateralCount;
    uint256 borrowCount;
  }

  error ReservePaused();
  error ReserveFrozen();
  error ReserveNotBorrowable();
  error HealthFactorBelowThreshold();
  error MaximumUserReservesExceeded();

  function getReserveCount() external view returns (uint256);
  function getReserveId(address hub, uint256 assetId) external view returns (uint256);
  function getReserve(uint256 reserveId) external view returns (Reserve memory);
  function getReserveConfig(uint256 reserveId) external view returns (ReserveConfig memory);
  function getDynamicReserveConfig(
    uint256 reserveId,
    uint32 dynamicConfigKey
  ) external view returns (DynamicReserveConfig memory);

  function getUserSuppliedAssets(uint256 reserveId, address user) external view returns (uint256);
  function getUserSuppliedShares(uint256 reserveId, address user) external view returns (uint256);
  function getUserDebt(
    uint256 reserveId,
    address user
  ) external view returns (uint256 drawn, uint256 premium);
  function getUserTotalDebt(uint256 reserveId, address user) external view returns (uint256);
  function getUserPosition(
    uint256 reserveId,
    address user
  ) external view returns (UserPosition memory);
  function getUserAccountData(address user) external view returns (UserAccountData memory);
  function getReserveSuppliedAssets(uint256 reserveId) external view returns (uint256);
  function getReserveSuppliedShares(uint256 reserveId) external view returns (uint256);
  function getReserveDebt(uint256 reserveId) external view returns (uint256 drawn, uint256 premium);
  function getReserveTotalDebt(uint256 reserveId) external view returns (uint256);

  function ORACLE() external view returns (address);
  function MAX_USER_RESERVES_LIMIT() external view returns (uint16);

  function supply(
    uint256 reserveId,
    uint256 amount,
    address onBehalfOf
  ) external returns (uint256, uint256);
  function withdraw(
    uint256 reserveId,
    uint256 amount,
    address onBehalfOf
  ) external returns (uint256, uint256);
  function borrow(
    uint256 reserveId,
    uint256 amount,
    address onBehalfOf
  ) external returns (uint256, uint256);
  function repay(
    uint256 reserveId,
    uint256 amount,
    address onBehalfOf
  ) external returns (uint256, uint256);
  function liquidationCall(
    uint256 collateralReserveId,
    uint256 debtReserveId,
    address user,
    uint256 debtToCover,
    bool receiveShares
  ) external;
  function setUsingAsCollateral(
    uint256 reserveId,
    bool usingAsCollateral,
    address onBehalfOf
  ) external;
  function setUserPositionManager(address positionManager, bool approved) external;
}
