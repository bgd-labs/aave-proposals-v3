// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISpokeConfigurator {
  function updateCollateralFactor(
    address spoke,
    uint256 reserveId,
    uint32 dynamicConfigKey,
    uint16 collateralFactor
  ) external;
}
