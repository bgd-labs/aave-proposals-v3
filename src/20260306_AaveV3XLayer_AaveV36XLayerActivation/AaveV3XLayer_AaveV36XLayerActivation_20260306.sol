// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3XLayer} from 'aave-address-book/AaveV3XLayer.sol';
import {MiscXLayer} from 'aave-address-book/MiscXLayer.sol';
import {AaveV3PayloadXLayer} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadXLayer.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Aave V3.6 XLayer Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v3-on-x-layer/23175/18
 */
contract AaveV3XLayer_AaveV36XLayerActivation_20260306 is AaveV3PayloadXLayer {
  using SafeERC20 for IERC20;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant USDT0 = 0x779Ded0c9e1022225f8E0630b35a9b54bE713736;
  uint256 public constant USDT0_SEED_AMOUNT = 10e6;

  address public constant USDG = 0x4ae46a509F6b1D9056937BA4500cb143933D2dc8;
  uint256 public constant USDG_SEED_AMOUNT = 10e6;

  address public constant xBTC = 0xb7C00000bcDEeF966b20B3D884B98E64d2b06b4f;
  uint256 public constant xBTC_SEED_AMOUNT = 0.0002e8;

  address public constant WOKB = 0xe538905cf8410324e03A5A23C1c177a474D59b2b;
  uint256 public constant WOKB_SEED_AMOUNT = 0.1e18;

  address public constant xETH = 0xE7B000003A45145decf8a28FC755aD5eC5EA025A;
  uint256 public constant xETH_SEED_AMOUNT = 0.005e18;

  address public constant xSOL = 0x505000008DE8748DBd4422ff4687a4FC9bEba15b;
  uint256 public constant xSOL_SEED_AMOUNT = 0.1e9; // 9 decimals

  address public constant xBETH = 0xAFeab3B85B6A56cF5F02317F0f7A23340eb983D7;
  uint256 public constant xBETH_SEED_AMOUNT = 0.005e18;

  address public constant xOKSOL = 0x14a686103854DAB7b8801E31979CAA595835B25d;
  uint256 public constant xOKSOL_SEED_AMOUNT = 0.1e9;

  address public constant GHO = 0xDe6539018B095353A40753Dc54C91C68c9487D4E;
  uint256 public constant GHO_SEED_AMOUNT = 10e18;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(USDT0, USDT0_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDG, USDG_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(xBTC, xBTC_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(WOKB, WOKB_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(xETH, xETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(xSOL, xSOL_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(xBETH, xBETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(xOKSOL, xOKSOL_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(GHO, GHO_SEED_AMOUNT);

    AaveV3XLayer.ACL_MANAGER.addPoolAdmin(MiscXLayer.PROTOCOL_GUARDIAN);
    AaveV3XLayer.ACL_MANAGER.addRiskAdmin(AaveV3XLayer.RISK_STEWARD);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](9);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDT0,
      assetSymbol: 'USDT0',
      priceFeed: 0x7ec7E5497EAf312FE82F8307D05eb0E5f0f157D3,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 10_00,
      supplyCap: 50_000_000,
      borrowCap: 48_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 40_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: USDG,
      assetSymbol: 'USDG',
      priceFeed: 0xcFcBBF3E0C27b936Cf673c4FC8BcC68f721af475,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 5_000_000,
      borrowCap: 4_250_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 45_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: xBTC,
      assetSymbol: 'xBTC',
      priceFeed: 0x4D6f6488a2B3a5f7b088f276887f608a1e9805c4,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 10_00,
      supplyCap: 150,
      borrowCap: 20,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_75,
        variableRateSlope2: 40_00
      })
    });
    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: WOKB,
      assetSymbol: 'WOKB',
      priceFeed: 0x4Ff345b18a2bF894F8627F41501FBf30d5C5e7BE,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 15_00,
      supplyCap: 125_000,
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
    listings[4] = IAaveV3ConfigEngine.Listing({
      asset: xETH,
      assetSymbol: 'xETH',
      priceFeed: 0x8b85b50535551F8E8cDAF78dA235b5Cf1005907b,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 5_000,
      borrowCap: 1_300,
      debtCeiling: 0,
      liqProtocolFee: 15_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_50,
        variableRateSlope2: 20_00
      })
    });
    listings[5] = IAaveV3ConfigEngine.Listing({
      asset: xSOL,
      assetSymbol: 'xSOL',
      priceFeed: 0xF959E1B5cA535C28aD24F7f672Bf1A93900810cF,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 60_00,
      liqThreshold: 65_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 110_000,
      borrowCap: 14_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 20_00
      })
    });
    listings[6] = IAaveV3ConfigEngine.Listing({
      asset: xBETH,
      assetSymbol: 'xBETH',
      priceFeed: 0x2c54487c1a94b753987d980f98b13E8F313A7B44,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 67_00,
      liqThreshold: 72_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 5_700,
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
    listings[7] = IAaveV3ConfigEngine.Listing({
      asset: xOKSOL,
      assetSymbol: 'xOKSOL',
      priceFeed: 0x558891fF1823d6f38A4f2102D357C307a1B09bF6,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 55_00,
      liqThreshold: 60_00,
      liqBonus: 7_50,
      reserveFactor: 15_00,
      supplyCap: 135_000,
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
    listings[8] = IAaveV3ConfigEngine.Listing({
      asset: GHO,
      assetSymbol: 'GHO',
      priceFeed: 0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 5_000_000,
      borrowCap: 4_800_000,
      debtCeiling: 0,
      liqProtocolFee: 0,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 45_00
      })
    });

    return listings;
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](6);

    // xBTC Stablecoins
    address[] memory collateralAssets_xBTCStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_xBTCStablecoinsEMode = new address[](3);
    collateralAssets_xBTCStablecoinsEMode[0] = xBTC;
    borrowableAssets_xBTCStablecoinsEMode[0] = USDT0;
    borrowableAssets_xBTCStablecoinsEMode[1] = USDG;
    borrowableAssets_xBTCStablecoinsEMode[2] = GHO;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 78_00,
      liqThreshold: 81_00,
      liqBonus: 6_00,
      label: 'xBTC__USDT0_USDG_GHO',
      collaterals: collateralAssets_xBTCStablecoinsEMode,
      borrowables: borrowableAssets_xBTCStablecoinsEMode
    });

    // xETH Stablecoins
    address[] memory collateralAssets_xETHStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_xETHStablecoinsEMode = new address[](3);
    collateralAssets_xETHStablecoinsEMode[0] = xETH;
    borrowableAssets_xETHStablecoinsEMode[0] = USDT0;
    borrowableAssets_xETHStablecoinsEMode[1] = USDG;
    borrowableAssets_xETHStablecoinsEMode[2] = GHO;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 78_00,
      liqThreshold: 80_00,
      liqBonus: 6_00,
      label: 'xETH__USDT0_USDG_GHO',
      collaterals: collateralAssets_xETHStablecoinsEMode,
      borrowables: borrowableAssets_xETHStablecoinsEMode
    });

    // xSOL Stablecoins
    address[] memory collateralAssets_xSOLStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_xSOLStablecoinsEMode = new address[](3);
    collateralAssets_xSOLStablecoinsEMode[0] = xSOL;
    borrowableAssets_xSOLStablecoinsEMode[0] = USDT0;
    borrowableAssets_xSOLStablecoinsEMode[1] = USDG;
    borrowableAssets_xSOLStablecoinsEMode[2] = GHO;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 65_00,
      liqThreshold: 70_00,
      liqBonus: 7_50,
      label: 'xSOL__USDT0_USDG_GHO',
      collaterals: collateralAssets_xSOLStablecoinsEMode,
      borrowables: borrowableAssets_xSOLStablecoinsEMode
    });

    // WOKB Stablecoins
    address[] memory collateralAssets_WOKBStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_WOKBStablecoinsEMode = new address[](3);
    collateralAssets_WOKBStablecoinsEMode[0] = WOKB;
    borrowableAssets_WOKBStablecoinsEMode[0] = USDT0;
    borrowableAssets_WOKBStablecoinsEMode[1] = USDG;
    borrowableAssets_WOKBStablecoinsEMode[2] = GHO;

    eModeCreations[3] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 50_00,
      liqThreshold: 55_00,
      liqBonus: 10_00,
      label: 'WOKB__USDT0_USDG_GHO',
      collaterals: collateralAssets_WOKBStablecoinsEMode,
      borrowables: borrowableAssets_WOKBStablecoinsEMode
    });

    // xBETH / xETH Correlated
    address[] memory collateralAssets_xBETHxETHEMode = new address[](1);
    address[] memory borrowableAssets_xBETHxETHEMode = new address[](1);
    collateralAssets_xBETHxETHEMode[0] = xBETH;
    borrowableAssets_xBETHxETHEMode[0] = xETH;

    eModeCreations[4] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 88_00,
      liqThreshold: 90_00,
      liqBonus: 2_00,
      label: 'xBETH__xETH',
      collaterals: collateralAssets_xBETHxETHEMode,
      borrowables: borrowableAssets_xBETHxETHEMode
    });

    // xOKSOL / xSOL Correlated
    address[] memory collateralAssets_xOKSOLxSOLEMode = new address[](1);
    address[] memory borrowableAssets_xOKSOLxSOLEMode = new address[](1);
    collateralAssets_xOKSOLxSOLEMode[0] = xOKSOL;
    borrowableAssets_xOKSOLxSOLEMode[0] = xSOL;

    eModeCreations[5] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 88_00,
      liqThreshold: 90_00,
      liqBonus: 2_00,
      label: 'xOKSOL__xSOL',
      collaterals: collateralAssets_xOKSOLxSOLEMode,
      borrowables: borrowableAssets_xOKSOLxSOLEMode
    });

    return eModeCreations;
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount) internal {
    IERC20(asset).forceApprove(address(AaveV3XLayer.POOL), seedAmount);
    AaveV3XLayer.POOL.supply(asset, seedAmount, address(AaveV3XLayer.DUST_BIN), 0);

    address aToken = AaveV3XLayer.POOL.getReserveAToken(asset);
    IEmissionManager(AaveV3XLayer.EMISSION_MANAGER).setEmissionAdmin(asset, LM_ADMIN);
    IEmissionManager(AaveV3XLayer.EMISSION_MANAGER).setEmissionAdmin(aToken, LM_ADMIN);
  }
}
