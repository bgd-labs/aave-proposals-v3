// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IStakeToken {
  struct AssetConfigInput {
    uint128 emissionPerSecond;
    uint256 totalStaked;
    address underlyingAsset;
  }

  function assets(
    address
  ) external view returns (uint128 emissionPerSecond, uint128 lastUpdateTimestamp, uint256 index);

  function configureAssets(AssetConfigInput[] memory assetsConfigInput) external;

  function distributionEnd() external view returns (uint256);

  function getTotalRewardsBalance(address staker) external view returns (uint256);

  function setDistributionEnd(uint256 newDistributionEnd) external;

  function stake(address to, uint256 amount) external;
}
