// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4EthereumHubs} from 'aave-address-book/AaveV4Ethereum.sol';

import {AaveV4PayloadEthereumSpoke} from '../AaveV4PayloadEthereumSpoke.sol';

contract MockSpokeProposal is AaveV4PayloadEthereumSpoke {
  address internal constant SPOKE = address(0x7777777777777777777777777777777777777777);
  address internal constant COLLATERAL = address(0x1111111111111111111111111111111111111111);
  address internal constant COLLATERAL_FEED = address(0x2222222222222222222222222222222222222222);
  address internal constant BORROW = address(0x3333333333333333333333333333333333333333);
  address internal constant BORROW_FEED = address(0x4444444444444444444444444444444444444444);
  address internal constant IR_STRATEGY = address(0x5555555555555555555555555555555555555555);

  function spoke() public pure override returns (address) {
    return SPOKE;
  }

  function _hubAssetListings() internal pure override returns (HubAssetListing[] memory) {
    HubAssetListing[] memory listings = new HubAssetListing[](1);
    listings[0] = HubAssetListing({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: COLLATERAL,
      liquidityFee: 0,
      irStrategy: IR_STRATEGY,
      irData: _nonBorrowableIRData(),
      tokenization: _tokenization(AaveV4EthereumHubs.CORE_HUB, 'MOCK', 0)
    });
    return listings;
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
