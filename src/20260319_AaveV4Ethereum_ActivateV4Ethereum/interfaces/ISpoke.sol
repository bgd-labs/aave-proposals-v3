// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

  function getReserveCount() external view returns (uint256);
  function getReserveId(address hub, uint256 assetId) external view returns (uint256);
  function getReserve(uint256 reserveId) external view returns (Reserve memory);
  function getReserveConfig(uint256 reserveId) external view returns (ReserveConfig memory);
  function getDynamicReserveConfig(
    uint256 reserveId,
    uint32 dynamicConfigKey
  ) external view returns (DynamicReserveConfig memory);
}
