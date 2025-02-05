// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {MiscLinea} from 'aave-address-book/MiscLinea.sol';
import {AaveV3PayloadLinea} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadLinea.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';

/**
 * @title Aave v3 Linea Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/s:aave.eth/proposal/0x5ae276cb67c8d40868916e99f2ef113de02049dd412c3eb47539f97648f50878
 * - Discussion: https://governance.aave.com/t/arfc-deployment-of-aave-on-linea/19852/6
 */
contract AaveV3Linea_AaveV3LineaActivation_20250121 is AaveV3PayloadLinea {
  using SafeERC20 for IERC20;

  // https://lineascan.build/address/0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f
  address public constant WETH = 0xe5D7C2a44FfDDf6b295A15c148167daaAf5Cf34f;
  uint256 public constant WETH_SEED_AMOUNT = 0.025e18;

  // https://lineascan.build/address/0x3aAB2285ddcDdaD8edf438C1bAB47e1a9D05a9b4
  address public constant WBTC = 0x3aAB2285ddcDdaD8edf438C1bAB47e1a9D05a9b4;
  uint256 public constant WBTC_SEED_AMOUNT = 0.001e8;

  // https://lineascan.build/address/0x176211869cA2b568f2A7D4EE941E073a821EE1ff
  address public constant USDC = 0x176211869cA2b568f2A7D4EE941E073a821EE1ff;
  uint256 public constant USDC_SEED_AMOUNT = 10e6;

  // https://lineascan.build/address/0xA219439258ca9da29E9Cc4cE5596924745e12B93
  address public constant USDT = 0xA219439258ca9da29E9Cc4cE5596924745e12B93;
  uint256 public constant USDT_SEED_AMOUNT = 10e6;

  // https://lineascan.build/address/0xB5beDd42000b71FddE22D3eE8a79Bd49A568fC8F
  address public constant wstETH = 0xB5beDd42000b71FddE22D3eE8a79Bd49A568fC8F;
  uint256 public constant wstETH_SEED_AMOUNT = 0.025e18;

  // https://lineascan.build/address/0x2416092f143378750bb29b79eD961ab195CcEea5
  address public constant ezETH = 0x2416092f143378750bb29b79eD961ab195CcEea5;
  uint256 public constant ezETH_SEED_AMOUNT = 0.025e18;

  // https://lineascan.build/address/0x1Bf74C010E6320bab11e2e5A532b5AC15e0b8aA6
  address public constant weETH = 0x1Bf74C010E6320bab11e2e5A532b5AC15e0b8aA6;
  uint256 public constant weETH_SEED_AMOUNT = 0.025e18;

  // https://lineascan.build/address/0xac140648435d03f784879cd789130F22Ef588Fcd
  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    AaveV3Linea.ACL_MANAGER.addPoolAdmin(MiscLinea.PROTOCOL_GUARDIAN);
    AaveV3Linea.ACL_MANAGER.addRiskAdmin(AaveV3Linea.RISK_STEWARD);

    _supplyAndConfigureLMAdmin(WETH, WETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(WBTC, WBTC_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDC, USDC_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDT, USDT_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(wstETH, wstETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(weETH, weETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(ezETH, ezETH_SEED_AMOUNT);
  }

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](3);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 1,
      ltv: 93_50,
      liqThreshold: 95_50,
      liqBonus: 1_00,
      label: 'wstETH correlated'
    });
    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 2,
      ltv: 90_00,
      liqThreshold: 93_00,
      liqBonus: 1_00,
      label: 'ezETH correlated'
    });
    eModeUpdates[2] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 3,
      ltv: 90_00,
      liqThreshold: 93_00,
      liqBonus: 1_00,
      label: 'weETH correlated'
    });

    return eModeUpdates;
  }

  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](6);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: WETH,
      eModeCategory: 1,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: wstETH,
      eModeCategory: 1,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: WETH,
      eModeCategory: 2,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: ezETH,
      eModeCategory: 2,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });
    assetEModeUpdates[4] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: WETH,
      eModeCategory: 3,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.DISABLED
    });
    assetEModeUpdates[5] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: weETH,
      eModeCategory: 3,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.ENABLED
    });

    return assetEModeUpdates;
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](7);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x3c6Cd9Cc7c7a4c2Cf5a82734CD249D7D593354dA,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_00,
      liqThreshold: 83_00,
      liqBonus: 6_00,
      reserveFactor: 15_00,
      supplyCap: 1_200,
      borrowCap: 1_100,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_70,
        variableRateSlope2: 80_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: WBTC,
      assetSymbol: 'WBTC',
      priceFeed: 0x7A99092816C8BD5ec8ba229e3a6E6Da1E628E1F9,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 73_00,
      liqThreshold: 78_00,
      liqBonus: 7_00,
      reserveFactor: 20_00,
      supplyCap: 25,
      borrowCap: 12,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_00,
        variableRateSlope2: 300_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0x14ac9f8a8646D11D66fbaA9E9F5A869dC08B5D71,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 12_000_000,
      borrowCap: 11_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 60_00
      })
    });
    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: USDT,
      assetSymbol: 'USDT',
      priceFeed: 0x0DccbA847D677d4dc3c22C9Dc17DC468226d08Ed,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 7_800_000,
      borrowCap: 7_150_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_50,
        variableRateSlope2: 60_00
      })
    });
    listings[4] = IAaveV3ConfigEngine.Listing({
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: 0x96014CA32e2902A5F07c6ADF00eB17D3DE9aC364,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 79_00,
      liqBonus: 7_00,
      reserveFactor: 5_00,
      supplyCap: 800,
      borrowCap: 400,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_00,
        variableRateSlope2: 300_00
      })
    });
    listings[5] = IAaveV3ConfigEngine.Listing({
      asset: ezETH,
      assetSymbol: 'ezETH',
      priceFeed: 0x1217a8A40cea4dB5429fbF6EDeB3B606b99CC9b0,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 1_200,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_00,
        variableRateSlope2: 300_00
      })
    });
    listings[6] = IAaveV3ConfigEngine.Listing({
      asset: weETH,
      assetSymbol: 'weETH',
      priceFeed: 0x0abf2f5642d945b49B8d2DBC6f85c2D8e0424C85,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_50,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 1_200,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 7_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount) internal {
    IERC20(asset).forceApprove(address(AaveV3Linea.POOL), seedAmount);
    AaveV3Linea.POOL.supply(asset, seedAmount, address(AaveV3Linea.COLLECTOR), 0);

    (address aToken, , ) = AaveV3Linea.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(asset);
    IEmissionManager(AaveV3Linea.EMISSION_MANAGER).setEmissionAdmin(asset, LM_ADMIN);
    IEmissionManager(AaveV3Linea.EMISSION_MANAGER).setEmissionAdmin(aToken, LM_ADMIN);
  }
}
