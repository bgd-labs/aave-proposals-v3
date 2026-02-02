// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Mantle} from 'aave-address-book/AaveV3Mantle.sol';
import {MiscMantle} from 'aave-address-book/MiscMantle.sol';
import {AaveV3PayloadMantle} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMantle.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Aave V3.6 Mantle Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xa3dc5b82f2dc5176c2a7543a6cc10aa75cccf96a73afe06478795182cff9d771
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/12
 */
contract AaveV3Mantle_AaveV36MantleActivation_20260117 is AaveV3PayloadMantle {
  using SafeERC20 for IERC20;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant WETH = 0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111;
  uint256 public constant WETH_SEED_AMOUNT = 0.0025e18;

  address public constant WMNT = 0x78c1b0C915c4FAA5FffA6CAbf0219DA63d7f4cb8;
  uint256 public constant WMNT_SEED_AMOUNT = 10e18;

  address public constant USDT0 = 0x779Ded0c9e1022225f8E0630b35a9b54bE713736;
  uint256 public constant USDT0_SEED_AMOUNT = 10e6;

  address public constant USDC = 0x09Bc4E0D864854c6aFB6eB9A9cdF58aC190D0dF9;
  uint256 public constant USDC_SEED_AMOUNT = 10e6;

  address public constant USDe = 0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34;
  uint256 public constant USDe_SEED_AMOUNT = 10e18;

  address public constant sUSDe = 0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2;
  uint256 public constant sUSDe_SEED_AMOUNT = 10e18;

  address public constant FBTC = 0xC96dE26018A54D51c097160568752c4E3BD6C364;
  uint256 public constant FBTC_SEED_AMOUNT = 0.0005e8;

  address public constant syrupUSDT = 0x051665f2455116e929b9972c36d23070F5054Ce0;
  uint256 public constant syrupUSDT_SEED_AMOUNT = 10e6;

  address public constant wrsETH = 0x93e855643e940D025bE2e529272e4Dbd15a2Cf74;
  uint256 public constant wrsETH_SEED_AMOUNT = 0.0025e18;

  address public constant GHO = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73;
  uint256 public constant GHO_SEED_AMOUNT = 10e18;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(WETH, WETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(WMNT, WMNT_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDT0, USDT0_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDC, USDC_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDe, USDe_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(sUSDe, sUSDe_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(FBTC, FBTC_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(syrupUSDT, syrupUSDT_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(wrsETH, wrsETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(GHO, GHO_SEED_AMOUNT);

    AaveV3Mantle.ACL_MANAGER.addPoolAdmin(MiscMantle.PROTOCOL_GUARDIAN);
    AaveV3Mantle.ACL_MANAGER.addRiskAdmin(AaveV3Mantle.RISK_STEWARD);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](10);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x5bc7Cf88EB131DB18b5d7930e793095140799aD5,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_50,
      liqThreshold: 83_00,
      liqBonus: 5_50,
      reserveFactor: 15_00,
      supplyCap: 30_000,
      borrowCap: 28_000,
      debtCeiling: 30_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_50,
        variableRateSlope2: 8_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: WMNT,
      assetSymbol: 'WMNT',
      priceFeed: 0xD97F20bEbeD74e8144134C4b148fE93417dd0F96,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 40_00,
      liqThreshold: 45_00,
      liqBonus: 10_00,
      reserveFactor: 20_00,
      supplyCap: 5_000_000,
      borrowCap: 1,
      debtCeiling: 2_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 20_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: USDT0,
      assetSymbol: 'USDT0',
      priceFeed: 0xFA5dEcEd7cdCEAB065addd0E32D9527ABd1069Ee,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 50_000_000,
      borrowCap: 47_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 10_00
      })
    });
    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: USDC,
      assetSymbol: 'USDC',
      priceFeed: 0x3876FB349c14613e0633b5cAe08C4E3B1d4904fB,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 10_000_000,
      borrowCap: 9_500_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 10_00
      })
    });
    listings[4] = IAaveV3ConfigEngine.Listing({
      asset: USDe,
      assetSymbol: 'USDe',
      priceFeed: 0xFA5dEcEd7cdCEAB065addd0E32D9527ABd1069Ee,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 20_000_000,
      borrowCap: 17_500_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 85_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_25,
        variableRateSlope2: 12_00
      })
    });
    listings[5] = IAaveV3ConfigEngine.Listing({
      asset: sUSDe,
      assetSymbol: 'sUSDe',
      priceFeed: 0x8b47EC48ac560793861D94A997d020872c1cE3f5,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 20_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 20_00
      })
    });
    listings[6] = IAaveV3ConfigEngine.Listing({
      asset: FBTC,
      assetSymbol: 'FBTC',
      priceFeed: 0x7db2275279F52D0914A481e14c4Ce5a59705A25b,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 50,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 20_00
      })
    });
    listings[7] = IAaveV3ConfigEngine.Listing({
      asset: syrupUSDT,
      assetSymbol: 'syrupUSDT',
      priceFeed: 0xCF1700Ee060AB65fa16d5f44A6fBf16721EB0D9b,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 70_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 20_00
      })
    });
    listings[8] = IAaveV3ConfigEngine.Listing({
      asset: wrsETH,
      assetSymbol: 'wrsETH',
      priceFeed: 0xFED794060D37391d966F931B9509378063C5B0fB,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 18_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 5_00,
        variableRateSlope2: 20_00
      })
    });
    listings[9] = IAaveV3ConfigEngine.Listing({
      asset: GHO,
      assetSymbol: 'GHO',
      priceFeed: 0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 20_000_000,
      borrowCap: 18_000_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 2_00,
        variableRateSlope1: 3_00,
        variableRateSlope2: 40_00
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
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](5);

    // sUSDe Stablecoins
    address[] memory collateralAssets_sUSDeStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_sUSDeStablecoinsEMode = new address[](4);
    collateralAssets_sUSDeStablecoinsEMode[0] = sUSDe;
    borrowableAssets_sUSDeStablecoinsEMode[0] = USDe;
    borrowableAssets_sUSDeStablecoinsEMode[1] = USDT0;
    borrowableAssets_sUSDeStablecoinsEMode[2] = USDC;
    borrowableAssets_sUSDeStablecoinsEMode[3] = GHO;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'sUSDe Stablecoins',
      collaterals: collateralAssets_sUSDeStablecoinsEMode,
      borrowables: borrowableAssets_sUSDeStablecoinsEMode
    });

    // USDe Stablecoins
    address[] memory collateralAssets_USDeStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_USDeStablecoinsEMode = new address[](3);
    collateralAssets_USDeStablecoinsEMode[0] = USDe;
    borrowableAssets_USDeStablecoinsEMode[0] = USDT0;
    borrowableAssets_USDeStablecoinsEMode[1] = USDC;
    borrowableAssets_USDeStablecoinsEMode[2] = GHO;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 93_00,
      liqBonus: 2_00,
      label: 'USDe Stablecoins',
      collaterals: collateralAssets_USDeStablecoinsEMode,
      borrowables: borrowableAssets_USDeStablecoinsEMode
    });

    // fBTC Stablecoins
    address[] memory collateralAssets_fBTCStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_fBTCStablecoinsEMode = new address[](3);
    collateralAssets_fBTCStablecoinsEMode[0] = FBTC;
    borrowableAssets_fBTCStablecoinsEMode[0] = USDT0;
    borrowableAssets_fBTCStablecoinsEMode[1] = USDC;
    borrowableAssets_fBTCStablecoinsEMode[2] = USDe;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 75_00,
      liqThreshold: 79_00,
      liqBonus: 8_00,
      label: 'fBTC Stablecoins',
      collaterals: collateralAssets_fBTCStablecoinsEMode,
      borrowables: borrowableAssets_fBTCStablecoinsEMode
    });

    // syrupUSDT Stablecoins
    address[] memory collateralAssets_syrupUSDTStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_syrupUSDTStablecoinsEMode = new address[](3);
    collateralAssets_syrupUSDTStablecoinsEMode[0] = syrupUSDT;
    borrowableAssets_syrupUSDTStablecoinsEMode[0] = USDT0;
    borrowableAssets_syrupUSDTStablecoinsEMode[1] = USDC;
    borrowableAssets_syrupUSDTStablecoinsEMode[2] = GHO;

    eModeCreations[3] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'syrupUSDT Stablecoins',
      collaterals: collateralAssets_syrupUSDTStablecoinsEMode,
      borrowables: borrowableAssets_syrupUSDTStablecoinsEMode
    });

    // wrsETH Correlated
    address[] memory collateralAssets_wrsEthEMode = new address[](1);
    address[] memory borrowableAssets_wrsEthEMode = new address[](1);
    collateralAssets_wrsEthEMode[0] = wrsETH;
    borrowableAssets_wrsEthEMode[0] = WETH;

    eModeCreations[4] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'wrsETH Correlated',
      collaterals: collateralAssets_wrsEthEMode,
      borrowables: borrowableAssets_wrsEthEMode
    });

    return eModeCreations;
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount) internal {
    IERC20(asset).forceApprove(address(AaveV3Mantle.POOL), seedAmount);
    AaveV3Mantle.POOL.supply(asset, seedAmount, address(AaveV3Mantle.DUST_BIN), 0);

    address aToken = AaveV3Mantle.POOL.getReserveAToken(asset);
    IEmissionManager(AaveV3Mantle.EMISSION_MANAGER).setEmissionAdmin(asset, LM_ADMIN);
    IEmissionManager(AaveV3Mantle.EMISSION_MANAGER).setEmissionAdmin(aToken, LM_ADMIN);
  }
}
