// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumSpokePriceFeeds} from 'aave-address-book/AaveV4Ethereum.sol';

import {AaveV4PayloadEthereumSpoke} from '../helpers/v4-spoke/AaveV4PayloadEthereumSpoke.sol';

/**
 * @title Onboard PT-USDG-24SEP2026 on V4 Core / USDG Correlated
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/3
 */
contract AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4CoreUSDGCorrelated_20260514 is
  AaveV4PayloadEthereumSpoke
{
  // https://etherscan.io/address/0x956d8e0A89cfa3744428C4641b5a53B56167a7f9
  address internal constant USDG_CORRELATED_SPOKE = 0x956d8e0A89cfa3744428C4641b5a53B56167a7f9;

  // PT-USDG-24SEP2026 is not yet in the V4 address book.
  // https://etherscan.io/address/0xc1906aeCf868749a2DeE203F59b904c0cf212140
  address internal constant PT_USDG_24SEP2026_UNDERLYING =
    0xc1906aeCf868749a2DeE203F59b904c0cf212140;
  // https://etherscan.io/address/0xD2417d928B7649feb50E61D9cCA38e56EFB34902
  address internal constant PT_USDG_24SEP2026_PRICE_FEED =
    0xD2417d928B7649feb50E61D9cCA38e56EFB34902;

  // Same IR strategy already used by every other asset on CORE_HUB.
  // https://etherscan.io/address/0xAD88791B0F81D1FA242f637eB05bee0cbc53fe2f
  address internal constant CORE_HUB_IR_STRATEGY = 0xAD88791B0F81D1FA242f637eB05bee0cbc53fe2f;

  string internal constant TOKEN_NAME = 'PT_USDG_24SEP2026';
  uint256 public constant TOKENIZATION_SPOKE_ADD_CAP = 0;

  function spoke() public pure override returns (address) {
    return USDG_CORRELATED_SPOKE;
  }

  function TOKENIZATION_SPOKE_NAME() public pure returns (string memory) {
    return _tokenizationName(AaveV4EthereumHubs.CORE_HUB, TOKEN_NAME);
  }

  function TOKENIZATION_SPOKE_SYMBOL() public pure returns (string memory) {
    return _tokenizationSymbol(AaveV4EthereumHubs.CORE_HUB, TOKEN_NAME);
  }

  function _preExecute() internal override {
    AaveV4Ethereum.ACCESS_MANAGER.grantRole({
      roleId: Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      account: address(this),
      executionDelay: 0
    });
  }

  function _hubAssetListings() internal pure override returns (HubAssetListing[] memory) {
    HubAssetListing[] memory listings = new HubAssetListing[](1);
    listings[0] = HubAssetListing({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: PT_USDG_24SEP2026_UNDERLYING,
      liquidityFee: 0,
      irStrategy: CORE_HUB_IR_STRATEGY,
      irData: _nonBorrowableIRData(),
      tokenization: _tokenization(
        AaveV4EthereumHubs.CORE_HUB,
        TOKEN_NAME,
        TOKENIZATION_SPOKE_ADD_CAP
      )
    });
    return listings;
  }

  function _spokeAssetConfigs() internal pure override returns (SpokeAssetConfig[] memory) {
    SpokeAssetConfig[] memory configs = new SpokeAssetConfig[](2);
    configs[0] = SpokeAssetConfig({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: PT_USDG_24SEP2026_UNDERLYING,
      addCap: 15_000_000,
      drawCap: 0,
      riskPremiumThreshold: 0
    });
    configs[1] = SpokeAssetConfig({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      addCap: 0,
      drawCap: 13_000_000,
      riskPremiumThreshold: 0
    });
    return configs;
  }

  function _spokeReserves() internal pure override returns (ReserveListing[] memory) {
    ReserveListing[] memory listings = new ReserveListing[](2);
    listings[0] = ReserveListing({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: PT_USDG_24SEP2026_UNDERLYING,
      priceSource: PT_USDG_24SEP2026_PRICE_FEED,
      collateralRisk: 0,
      borrowable: false,
      receiveSharesEnabled: true,
      collateralFactor: 95_00,
      maxLiquidationBonus: 102_00,
      liquidationFee: 10_00
    });
    listings[1] = ReserveListing({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      priceSource: AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDG_PRICE_FEED,
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
        targetHealthFactor: 1.0277e18,
        healthFactorForMaxBonus: 0.99e18,
        liquidationBonusFactor: 100_00
      });
  }
}
