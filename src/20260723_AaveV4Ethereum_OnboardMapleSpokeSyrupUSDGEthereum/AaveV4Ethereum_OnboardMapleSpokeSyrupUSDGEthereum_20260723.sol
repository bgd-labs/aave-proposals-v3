// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumPositionManagers} from 'aave-address-book/AaveV4Ethereum.sol';
import {AaveV4PayloadEthereum} from 'aave-helpers/src/v4-config-engine/AaveV4PayloadEthereum.sol';
import {IAaveV4ConfigEngine as IConfigEngine} from 'aave-address-book/AaveV4.sol';
import {IHub} from 'aave-v4/hub/interfaces/IHub.sol';
import {ISpoke} from 'aave-v4/spoke/interfaces/ISpoke.sol';
import {IAssetInterestRateStrategy} from 'aave-v4/hub/interfaces/IAssetInterestRateStrategy.sol';
import {Roles} from 'aave-v4/deployments/utils/libraries/Roles.sol';

/**
 * @title OnboardMapleSpokeSyrupUSDGEthereum
 * @author Aave Labs
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-syrupusdg-on-aave-v4-global-dollar-hub/25281
 */
contract AaveV4Ethereum_OnboardMapleSpokeSyrupUSDGEthereum_20260723 is AaveV4PayloadEthereum {
  // https://etherscan.io/address/0x774b9655413c34809c1f1b16b654465A89EBE989
  address public constant MAPLE_SPOKE = 0x774b9655413c34809c1f1b16b654465A89EBE989;

  // https://etherscan.io/address/0x87b65C4aAFFA76881f9E96F3e7ED945ddFC3Cd7A
  address public constant SYRUPUSDG = 0x87b65C4aAFFA76881f9E96F3e7ED945ddFC3Cd7A;

  // https://etherscan.io/address/0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9
  address public constant SECURITY_COUNCIL_V4 = 0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9;

  // https://etherscan.io/address/0xD7eC225DC053151100A0ef47b94a77AAD9C413b7
  address public constant PAXOS_HUB_USDG_IR_STRATEGY = 0xD7eC225DC053151100A0ef47b94a77AAD9C413b7;
  // https://etherscan.io/address/0xD7eC225DC053151100A0ef47b94a77AAD9C413b7
  address public constant PAXOS_HUB_SYRUPUSDG_IR_STRATEGY =
    0xD7eC225DC053151100A0ef47b94a77AAD9C413b7;

  // https://etherscan.io/address/0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4
  address public constant MAPLE_SPOKE_USDG_PRICE_FEED = 0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4;
  // https://etherscan.io/address/0x31745e344fc5986c900826940E5ac2C5DC97b4DE
  address public constant MAPLE_SPOKE_SYRUPUSDG_PRICE_FEED =
    0x31745e344fc5986c900826940E5ac2C5DC97b4DE;

  function accessManagerTargetFunctionRoleUpdates()
    public
    pure
    override
    returns (IConfigEngine.TargetFunctionRoleUpdate[] memory)
  {
    IConfigEngine.TargetFunctionRoleUpdate[]
      memory items = new IConfigEngine.TargetFunctionRoleUpdate[](1);
    items[0] = IConfigEngine.TargetFunctionRoleUpdate({
      authority: address(AaveV4Ethereum.ACCESS_MANAGER),
      target: MAPLE_SPOKE,
      selectors: Roles.getSpokeConfiguratorRoleSelectors(),
      roleId: Roles.SPOKE_CONFIGURATOR_ROLE
    });
    return items;
  }

  function hubAssetListings() public pure override returns (IConfigEngine.AssetListing[] memory) {
    IConfigEngine.AssetListing[] memory items = new IConfigEngine.AssetListing[](2);
    items[0] = IConfigEngine.AssetListing({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.PAXOS_HUB),
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      feeReceiver: address(AaveV4Ethereum.TREASURY_SPOKE),
      liquidityFee: 20_00,
      irStrategy: PAXOS_HUB_USDG_IR_STRATEGY,
      irData: IAssetInterestRateStrategy.InterestRateData({
        optimalUsageRatio: uint16(90_00),
        baseDrawnRate: uint32(0),
        rateGrowthBeforeOptimal: uint32(4_00),
        rateGrowthAfterOptimal: uint32(35_00)
      }),
      tokenization: IConfigEngine.TokenizationSpokeConfig({
        addCap: 1000000,
        proxyAdminOwner: SECURITY_COUNCIL_V4,
        name: 'Wrapped Aave Paxos USDG',
        symbol: 'waPaxosUSDG'
      })
    });
    items[1] = IConfigEngine.AssetListing({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.PAXOS_HUB),
      underlying: SYRUPUSDG,
      feeReceiver: address(AaveV4Ethereum.TREASURY_SPOKE),
      liquidityFee: 0,
      irStrategy: PAXOS_HUB_SYRUPUSDG_IR_STRATEGY,
      irData: IAssetInterestRateStrategy.InterestRateData({
        optimalUsageRatio: uint16(99_00),
        baseDrawnRate: uint32(0),
        rateGrowthBeforeOptimal: uint32(0),
        rateGrowthAfterOptimal: uint32(0)
      }),
      tokenization: IConfigEngine.TokenizationSpokeConfig({
        addCap: 0,
        proxyAdminOwner: address(0),
        name: '',
        symbol: ''
      })
    });
    return items;
  }

  function spokeReserveListings()
    public
    pure
    override
    returns (IConfigEngine.ReserveListing[] memory)
  {
    IConfigEngine.ReserveListing[] memory items = new IConfigEngine.ReserveListing[](2);
    items[0] = IConfigEngine.ReserveListing({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: MAPLE_SPOKE,
      hub: address(AaveV4EthereumHubs.PAXOS_HUB),
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      priceSource: MAPLE_SPOKE_USDG_PRICE_FEED,
      config: ISpoke.ReserveConfig({
        collateralRisk: uint24(0),
        paused: false,
        frozen: false,
        borrowable: true,
        receiveSharesEnabled: true
      }),
      dynamicConfig: ISpoke.DynamicReserveConfig({
        collateralFactor: uint16(0),
        maxLiquidationBonus: uint32(100_00),
        liquidationFee: uint16(0)
      })
    });
    items[1] = IConfigEngine.ReserveListing({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: MAPLE_SPOKE,
      hub: address(AaveV4EthereumHubs.PAXOS_HUB),
      underlying: SYRUPUSDG,
      priceSource: MAPLE_SPOKE_SYRUPUSDG_PRICE_FEED,
      config: ISpoke.ReserveConfig({
        collateralRisk: uint24(0),
        paused: false,
        frozen: false,
        borrowable: false,
        receiveSharesEnabled: true
      }),
      dynamicConfig: ISpoke.DynamicReserveConfig({
        collateralFactor: uint16(92_00),
        maxLiquidationBonus: uint32(104_00),
        liquidationFee: uint16(10_00)
      })
    });
    return items;
  }

  function spokeLiquidationConfigUpdates()
    public
    pure
    override
    returns (IConfigEngine.LiquidationConfigUpdate[] memory)
  {
    IConfigEngine.LiquidationConfigUpdate[]
      memory items = new IConfigEngine.LiquidationConfigUpdate[](1);
    items[0] = IConfigEngine.LiquidationConfigUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: MAPLE_SPOKE,
      targetHealthFactor: 1_027_700_000_000_000_000,
      healthFactorForMaxBonus: 990_000_000_000_000_000,
      liquidationBonusFactor: 10_000
    });
    return items;
  }

  function hubSpokeToAssetsAdditions()
    public
    pure
    override
    returns (IConfigEngine.SpokeToAssetsAddition[] memory)
  {
    IConfigEngine.SpokeToAssetsAddition[] memory items = new IConfigEngine.SpokeToAssetsAddition[](
      2
    );
    {
      IConfigEngine.SpokeAssetConfig[] memory subAssets = new IConfigEngine.SpokeAssetConfig[](1);
      subAssets[0] = IConfigEngine.SpokeAssetConfig({
        underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
        config: IHub.SpokeConfig({
          addCap: 10000000,
          drawCap: 9500000,
          riskPremiumThreshold: 0,
          active: true,
          halted: false
        })
      });
      items[0] = IConfigEngine.SpokeToAssetsAddition({
        hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
        hub: address(AaveV4EthereumHubs.PAXOS_HUB),
        spoke: MAPLE_SPOKE,
        assets: subAssets
      });
    }
    {
      IConfigEngine.SpokeAssetConfig[] memory subAssets = new IConfigEngine.SpokeAssetConfig[](1);
      subAssets[0] = IConfigEngine.SpokeAssetConfig({
        underlying: SYRUPUSDG,
        config: IHub.SpokeConfig({
          addCap: 10000000,
          drawCap: 0,
          riskPremiumThreshold: 0,
          active: true,
          halted: false
        })
      });
      items[1] = IConfigEngine.SpokeToAssetsAddition({
        hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
        hub: address(AaveV4EthereumHubs.PAXOS_HUB),
        spoke: MAPLE_SPOKE,
        assets: subAssets
      });
    }
    return items;
  }

  function spokePositionManagerUpdates()
    public
    pure
    override
    returns (IConfigEngine.PositionManagerUpdate[] memory)
  {
    IConfigEngine.PositionManagerUpdate[] memory items = new IConfigEngine.PositionManagerUpdate[](
      4
    );
    items[0] = IConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: MAPLE_SPOKE,
      positionManager: address(AaveV4EthereumPositionManagers.GIVER_POSITION_MANAGER),
      active: true
    });
    items[1] = IConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: MAPLE_SPOKE,
      positionManager: address(AaveV4EthereumPositionManagers.TAKER_POSITION_MANAGER),
      active: true
    });
    items[2] = IConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: MAPLE_SPOKE,
      positionManager: address(AaveV4EthereumPositionManagers.CONFIG_POSITION_MANAGER),
      active: true
    });
    items[3] = IConfigEngine.PositionManagerUpdate({
      spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
      spoke: MAPLE_SPOKE,
      positionManager: address(AaveV4EthereumPositionManagers.SIGNATURE_GATEWAY),
      active: true
    });
    return items;
  }
}
