// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';
import {IAaveV4ConfigEngine} from 'aave-v4/config-engine/interfaces/IAaveV4ConfigEngine.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumSpokes, AaveV4EthereumSpokePriceFeeds} from 'aave-address-book/AaveV4Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';

import {AaveV4PayloadEthereumSpoke} from '../helpers/v4-spoke/AaveV4PayloadSpoke.sol';

/**
 * @title Onboard PT-USDG-24SEP2026 on V4 Paxos Hub / USDG Pendle
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/3
 */
contract AaveV4Ethereum_OnboardPTUSDG24SEP2026OnV4PaxosUSDGPendle_20260514 is
  AaveV4PayloadEthereumSpoke
{
  // Freshly-deployed isolated Paxos Hub, sharing the protocol AccessManager.
  // https://etherscan.io/address/0x62d63197660c080236193CA60b70E49A08E90368
  IHub internal constant PAXOS_HUB = IHub(0x62d63197660c080236193CA60b70E49A08E90368);

  // The USDG Pendle spoke carrying PT-USDG collateral.
  // https://etherscan.io/address/0x956d8e0A89cfa3744428C4641b5a53B56167a7f9
  address internal constant USDG_PENDLE_SPOKE = 0x956d8e0A89cfa3744428C4641b5a53B56167a7f9;

  // https://etherscan.io/address/0xc1906aeCf868749a2DeE203F59b904c0cf212140
  address internal constant PT_USDG_24SEP2026_UNDERLYING =
    0xc1906aeCf868749a2DeE203F59b904c0cf212140;

  // https://etherscan.io/address/0x89F6Eb404AbF19FE817426dD2E2E0F14D1a5712e
  address internal constant PT_USDG_24SEP2026_PRICE_FEED =
    0x89F6Eb404AbF19FE817426dD2E2E0F14D1a5712e;
  // https://etherscan.io/address/0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4
  address internal constant USDG_PRICE_FEED = 0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4;

  // https://etherscan.io/address/0xD7eC225DC053151100A0ef47b94a77AAD9C413b7
  address internal constant PAXOS_HUB_IR_STRATEGY = 0xD7eC225DC053151100A0ef47b94a77AAD9C413b7;

  string internal constant TOKEN_NAME = 'PT_USDG_24SEP2026';
  uint256 internal constant TOKENIZATION_SPOKE_ADD_CAP = 0;

  uint256 internal constant USDC_TOKENIZATION_SPOKE_ADD_CAP = 13_000_000;
  uint256 internal constant USDT_TOKENIZATION_SPOKE_ADD_CAP = 13_000_000;

  function spoke() public pure override returns (address) {
    return USDG_PENDLE_SPOKE;
  }

  function tokenizationSpokeName() public pure returns (string memory) {
    return _tokenizationName(PAXOS_HUB, TOKEN_NAME);
  }

  function tokenizationSpokeSymbol() public pure returns (string memory) {
    return _tokenizationSymbol(PAXOS_HUB, TOKEN_NAME);
  }

  function newHubs() public pure override returns (IHub[] memory) {
    IHub[] memory hubs = new IHub[](1);
    hubs[0] = PAXOS_HUB;
    return hubs;
  }

  function _preExecute() internal override {
    AaveV4Ethereum.ACCESS_MANAGER.grantRole({
      roleId: Roles.SPOKE_CONFIGURATOR_DOMAIN_ADMIN_ROLE,
      account: GovernanceV3Ethereum.EXECUTOR_LVL_1,
      executionDelay: 0
    });
  }

  function _hubName(IHub hub) internal pure override returns (string memory) {
    if (hub == PAXOS_HUB) return 'Paxos';
    return super._hubName(hub);
  }

  function _hubAssetListings() internal view override returns (HubAssetListing[] memory) {
    HubAssetListing[] memory listings = new HubAssetListing[](3);
    listings[0] = HubAssetListing({
      hub: PAXOS_HUB,
      underlying: PT_USDG_24SEP2026_UNDERLYING,
      liquidityFee: 0,
      irStrategy: PAXOS_HUB_IR_STRATEGY,
      irData: _nonBorrowableIRData(),
      tokenization: _tokenization(PAXOS_HUB, TOKEN_NAME, TOKENIZATION_SPOKE_ADD_CAP)
    });
    listings[1] = HubAssetListing({
      hub: PAXOS_HUB,
      underlying: AaveV4EthereumAssets.USDC_UNDERLYING,
      liquidityFee: 10_00,
      irStrategy: PAXOS_HUB_IR_STRATEGY,
      irData: _borrowableIRData(),
      tokenization: _tokenization(
        PAXOS_HUB,
        IERC20Metadata(AaveV4EthereumAssets.USDC_UNDERLYING).symbol(),
        USDC_TOKENIZATION_SPOKE_ADD_CAP
      )
    });
    listings[2] = HubAssetListing({
      hub: PAXOS_HUB,
      underlying: AaveV4EthereumAssets.USDT_UNDERLYING,
      liquidityFee: 10_00,
      irStrategy: PAXOS_HUB_IR_STRATEGY,
      irData: _borrowableIRData(),
      tokenization: _tokenization(
        PAXOS_HUB,
        IERC20Metadata(AaveV4EthereumAssets.USDT_UNDERLYING).symbol(),
        USDT_TOKENIZATION_SPOKE_ADD_CAP
      )
    });
    return listings;
  }

  function _spokeAssetConfigs() internal pure override returns (SpokeAssetConfig[] memory) {
    SpokeAssetConfig[] memory configs = new SpokeAssetConfig[](4);
    configs[0] = SpokeAssetConfig({
      hub: PAXOS_HUB,
      underlying: PT_USDG_24SEP2026_UNDERLYING,
      addCap: 15_000_000,
      drawCap: 0,
      riskPremiumThreshold: 0
    });
    configs[1] = SpokeAssetConfig({
      hub: PAXOS_HUB,
      underlying: AaveV4EthereumAssets.USDC_UNDERLYING,
      addCap: 13_000_000,
      drawCap: 13_000_000,
      riskPremiumThreshold: 0
    });
    configs[2] = SpokeAssetConfig({
      hub: PAXOS_HUB,
      underlying: AaveV4EthereumAssets.USDT_UNDERLYING,
      addCap: 13_000_000,
      drawCap: 13_000_000,
      riskPremiumThreshold: 0
    });
    configs[3] = SpokeAssetConfig({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      addCap: 0,
      drawCap: 30_000_000,
      riskPremiumThreshold: 0
    });
    return configs;
  }

  function _spokeReserves() internal pure override returns (ReserveListing[] memory) {
    ReserveListing[] memory listings = new ReserveListing[](4);
    listings[0] = ReserveListing({
      hub: PAXOS_HUB,
      underlying: PT_USDG_24SEP2026_UNDERLYING,
      priceSource: PT_USDG_24SEP2026_PRICE_FEED,
      collateralRisk: 0,
      borrowable: false,
      receiveSharesEnabled: true,
      collateralFactor: 94_00,
      maxLiquidationBonus: 103_20,
      liquidationFee: 10_00
    });
    listings[1] = ReserveListing({
      hub: PAXOS_HUB,
      underlying: AaveV4EthereumAssets.USDC_UNDERLYING,
      priceSource: AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDC_PRICE_FEED,
      collateralRisk: 0,
      borrowable: true,
      receiveSharesEnabled: true,
      collateralFactor: 0,
      maxLiquidationBonus: 100_00,
      liquidationFee: 0
    });
    listings[2] = ReserveListing({
      hub: PAXOS_HUB,
      underlying: AaveV4EthereumAssets.USDT_UNDERLYING,
      priceSource: AaveV4EthereumSpokePriceFeeds.MAIN_SPOKE_USDT_PRICE_FEED,
      collateralRisk: 0,
      borrowable: true,
      receiveSharesEnabled: true,
      collateralFactor: 0,
      maxLiquidationBonus: 100_00,
      liquidationFee: 0
    });
    listings[3] = ReserveListing({
      hub: AaveV4EthereumHubs.CORE_HUB,
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      priceSource: USDG_PRICE_FEED,
      collateralRisk: 0,
      borrowable: true,
      receiveSharesEnabled: false,
      collateralFactor: 0,
      maxLiquidationBonus: 100_00,
      liquidationFee: 0
    });
    return listings;
  }

  /// @dev Repoints USDG to the CAPO on the existing FOREX/GOLD/MAIN spokes; price source only.
  function spokeReserveConfigUpdates()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.ReserveConfigUpdate[] memory)
  {
    address[3] memory usdgSpokes = [
      address(AaveV4EthereumSpokes.FOREX_SPOKE),
      address(AaveV4EthereumSpokes.GOLD_SPOKE),
      address(AaveV4EthereumSpokes.MAIN_SPOKE)
    ];
    IAaveV4ConfigEngine.ReserveConfigUpdate[]
      memory updates = new IAaveV4ConfigEngine.ReserveConfigUpdate[](usdgSpokes.length);
    for (uint256 i; i < usdgSpokes.length; ++i) {
      updates[i] = IAaveV4ConfigEngine.ReserveConfigUpdate({
        spokeConfigurator: _spokeConfigurator(),
        spoke: usdgSpokes[i],
        hub: address(AaveV4EthereumHubs.CORE_HUB),
        underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
        priceSource: USDG_PRICE_FEED,
        collateralRisk: EngineFlags.KEEP_CURRENT,
        paused: EngineFlags.KEEP_CURRENT,
        frozen: EngineFlags.KEEP_CURRENT,
        borrowable: EngineFlags.KEEP_CURRENT,
        receiveSharesEnabled: EngineFlags.KEEP_CURRENT
      });
    }
    return updates;
  }

  function _spokeLiquidation() internal pure override returns (LiquidationConfigUpdate memory) {
    return
      LiquidationConfigUpdate({
        targetHealthFactor: 1.0277e18,
        healthFactorForMaxBonus: 0.99e18,
        liquidationBonusFactor: 100_00
      });
  }

  /// @dev IR preset for the natively-suppliable, borrowable Paxos Hub assets (USDC, USDT). Pairs
  ///      with {AaveV4PayloadHub._nonBorrowableIRData} used by the PT-USDG collateral listing.
  function _borrowableIRData()
    private
    pure
    returns (IAssetInterestRateStrategy.InterestRateData memory)
  {
    return
      IAssetInterestRateStrategy.InterestRateData({
        optimalUsageRatio: 92_00,
        baseDrawnRate: 0,
        rateGrowthBeforeOptimal: 4_00,
        rateGrowthAfterOptimal: 20_00
      });
  }
}
