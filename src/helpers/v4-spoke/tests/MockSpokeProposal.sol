// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {AaveV4EthereumHubs} from 'aave-address-book/AaveV4Ethereum.sol';

import {AaveV4PayloadEthereumSpoke} from '../AaveV4PayloadSpoke.sol';

contract MockSpokeProposal is AaveV4PayloadEthereumSpoke {
  address internal constant SPOKE = address(0x7777777777777777777777777777777777777777);
  address internal constant COLLATERAL = address(0x1111111111111111111111111111111111111111);
  address internal constant COLLATERAL_FEED = address(0x2222222222222222222222222222222222222222);
  address internal constant BORROW = address(0x3333333333333333333333333333333333333333);
  address internal constant BORROW_FEED = address(0x4444444444444444444444444444444444444444);

  function spoke() public pure override returns (address) {
    return SPOKE;
  }

  // Spoke-only: no new hub, no hub asset listings.
  function newHubs() public pure override returns (IHub[] memory) {
    return new IHub[](0);
  }

  function _hubAssetListings() internal pure override returns (HubAssetListing[] memory) {
    return new HubAssetListing[](0);
  }

  function _spokeAssetConfigs() internal pure override returns (SpokeAssetConfig[] memory) {
    SpokeAssetConfig[] memory configs = new SpokeAssetConfig[](2);
    configs[0] = SpokeAssetConfig({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: COLLATERAL,
      addCap: 2_000_000,
      drawCap: 0,
      riskPremiumThreshold: 0
    });
    configs[1] = SpokeAssetConfig({
      hub: AaveV4EthereumHubs.PLUS_HUB,
      underlying: BORROW,
      addCap: 0,
      drawCap: 1_000_000,
      riskPremiumThreshold: 0
    });
    return configs;
  }

  function _spokeReserves() internal pure override returns (ReserveListing[] memory) {
    ReserveListing[] memory listings = new ReserveListing[](2);
    listings[0] = ReserveListing({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: COLLATERAL,
      priceSource: COLLATERAL_FEED,
      collateralRisk: 0,
      borrowable: false,
      receiveSharesEnabled: true,
      collateralFactor: 95_00,
      maxLiquidationBonus: 102_00,
      liquidationFee: 10_00
    });
    listings[1] = ReserveListing({
      hub: AaveV4EthereumHubs.PLUS_HUB,
      underlying: BORROW,
      priceSource: BORROW_FEED,
      collateralRisk: 0,
      borrowable: true,
      receiveSharesEnabled: false,
      collateralFactor: 0,
      maxLiquidationBonus: 100_00,
      liquidationFee: 0
    });
    return listings;
  }

  function _spokeLiquidation() internal pure override returns (LiquidationConfigUpdate memory) {
    return
      LiquidationConfigUpdate({
        targetHealthFactor: 1.02e18,
        healthFactorForMaxBonus: 0.99e18,
        liquidationBonusFactor: 100_00
      });
  }
}

/// @dev Two assets on Core + one on Plus, to exercise per-hub grouping in hubSpokeToAssetsAdditions.
contract MockMultiAssetSpokeProposal is AaveV4PayloadEthereumSpoke {
  address internal constant SPOKE = address(0x8888888888888888888888888888888888888888);
  address internal constant CORE_ASSET_A = address(0xA1);
  address internal constant CORE_ASSET_B = address(0xA2);
  address internal constant PLUS_ASSET = address(0xB1);

  function spoke() public pure override returns (address) {
    return SPOKE;
  }

  function newHubs() public pure override returns (IHub[] memory) {
    return new IHub[](0);
  }

  function _hubAssetListings() internal pure override returns (HubAssetListing[] memory) {
    return new HubAssetListing[](0);
  }

  function _spokeAssetConfigs() internal pure override returns (SpokeAssetConfig[] memory) {
    SpokeAssetConfig[] memory configs = new SpokeAssetConfig[](3);
    configs[0] = SpokeAssetConfig({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: CORE_ASSET_A,
      addCap: 1,
      drawCap: 0,
      riskPremiumThreshold: 0
    });
    configs[1] = SpokeAssetConfig({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: CORE_ASSET_B,
      addCap: 2,
      drawCap: 0,
      riskPremiumThreshold: 0
    });
    configs[2] = SpokeAssetConfig({
      hub: AaveV4EthereumHubs.PLUS_HUB,
      underlying: PLUS_ASSET,
      addCap: 0,
      drawCap: 3,
      riskPremiumThreshold: 0
    });
    return configs;
  }

  function _spokeReserves() internal pure override returns (ReserveListing[] memory) {
    return new ReserveListing[](0);
  }

  function _spokeLiquidation() internal pure override returns (LiquidationConfigUpdate memory) {
    return
      LiquidationConfigUpdate({
        targetHealthFactor: 1e18,
        healthFactorForMaxBonus: 1e18,
        liquidationBonusFactor: 100_00
      });
  }
}
