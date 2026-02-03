// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MegaEth} from 'aave-address-book/AaveV3MegaEth.sol';
import {MiscMegaEth} from 'aave-address-book/MiscMegaEth.sol';
import {AaveV3PayloadMegaEth} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMegaEth.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Aave V3.6 MegaETH Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xab1d9c42264c89e1b8f0d807c9ff971f8c3f9f5cc0323072d9e970c110d1e39b
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v3-to-megaeth/23517
 */
contract AaveV3MegaEth_AaveV36MegaETHActivation_20260128 is AaveV3PayloadMegaEth {
  using SafeERC20 for IERC20;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant WETH = 0x4200000000000000000000000000000000000006;
  uint256 public constant WETH_SEED_AMOUNT = 0.0025e18;

  address public constant BTCb = 0xB0F70C0bD6FD87dbEb7C10dC692a2a6106817072;
  uint256 public constant BTCb_SEED_AMOUNT = 0.0005e8;

  address public constant USDT0 = 0xB8CE59FC3717ada4C02eaDF9682A9e934F625ebb;
  uint256 public constant USDT0_SEED_AMOUNT = 10e6;

  address public constant USDm = 0xFAfDdbb3FC7688494971a79cc65DCa3EF82079E7;
  uint256 public constant USDm_SEED_AMOUNT = 10e18;

  address public constant wstETH = 0x601aC63637933D88285A025C685AC4e9a92a98dA;
  uint256 public constant wstETH_SEED_AMOUNT = 0.0025e18;

  address public constant wrsETH = 0x4Fc44BE15e9B6E30C1E774E2C87A21D3E8b5403F;
  uint256 public constant wrsETH_SEED_AMOUNT = 0.0025e18;

  address public constant ezETH = 0x09601A65e7de7BC8A19813D263dD9E98bFdC3c57;
  uint256 public constant ezETH_SEED_AMOUNT = 0.0025e18;

  address public constant PRICE_ORACLE_SENTINEL = 0x98F756B77D6Fde14E08bb064b248ec7512F9f8ba;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(WETH, WETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(BTCb, BTCb_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDT0, USDT0_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDm, USDm_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(wstETH, wstETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(wrsETH, wrsETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(ezETH, ezETH_SEED_AMOUNT);

    AaveV3MegaEth.ACL_MANAGER.addPoolAdmin(MiscMegaEth.PROTOCOL_GUARDIAN);
    AaveV3MegaEth.ACL_MANAGER.addRiskAdmin(AaveV3MegaEth.RISK_STEWARD);

    // configure price-oracle-sentinel
    AaveV3MegaEth.POOL_ADDRESSES_PROVIDER.setPriceOracleSentinel(PRICE_ORACLE_SENTINEL);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](7);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0xcA4e254D95637DE95E2a2F79244b03380d697feD,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 15_00,
      supplyCap: 50_000,
      borrowCap: 46_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_50,
        variableRateSlope2: 8_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: BTCb,
      assetSymbol: 'BTCb',
      priceFeed: 0xc6E3007B597f6F5a6330d43053D1EF73cCbbE721,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 120,
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
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: USDT0,
      assetSymbol: 'USDT0',
      priceFeed: 0xAe95ff42e16468AB1DfD405c9533C9b67d87d66A,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 50_000_000,
      borrowCap: 46_000_000,
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
      asset: USDm,
      assetSymbol: 'USDm',
      priceFeed: 0xe5448B8318493c6e3F72E21e8BDB8242d3299FB5,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 10_00,
      supplyCap: 50_000_000,
      borrowCap: 46_000_000,
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
      asset: wstETH,
      assetSymbol: 'wstETH',
      priceFeed: 0x376397e34eA968e79DC6F629E6210ba25311a3ce,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 12_000,
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
    listings[5] = IAaveV3ConfigEngine.Listing({
      asset: wrsETH,
      assetSymbol: 'wrsETH',
      priceFeed: 0x6356b92Bc636CCe722e0F53DDc24a86baE64216E,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 10_000,
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
      asset: ezETH,
      assetSymbol: 'ezETH',
      priceFeed: 0xd7Da71D3acf07C604A925799B0b48E2Ec607584D,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 0,
      liqThreshold: 0,
      liqBonus: 0,
      reserveFactor: 20_00,
      supplyCap: 10_000,
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

    // WETH Stablecoins
    address[] memory collateralAssets_WETHStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_WETHStablecoinsEMode = new address[](2);
    collateralAssets_WETHStablecoinsEMode[0] = WETH;
    borrowableAssets_WETHStablecoinsEMode[0] = USDT0;
    borrowableAssets_WETHStablecoinsEMode[1] = USDm;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 80_50,
      liqThreshold: 83_00,
      liqBonus: 5_50,
      label: 'WETH Stablecoins',
      collaterals: collateralAssets_WETHStablecoinsEMode,
      borrowables: borrowableAssets_WETHStablecoinsEMode
    });

    // BTCb Stablecoins
    address[] memory collateralAssets_BTCbStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_BTCbStablecoinsEMode = new address[](2);
    collateralAssets_BTCbStablecoinsEMode[0] = BTCb;
    borrowableAssets_BTCbStablecoinsEMode[0] = USDT0;
    borrowableAssets_BTCbStablecoinsEMode[1] = USDm;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 6_50,
      label: 'BTCb Stablecoins',
      collaterals: collateralAssets_BTCbStablecoinsEMode,
      borrowables: borrowableAssets_BTCbStablecoinsEMode
    });

    // wstETH Stablecoins
    address[] memory collateralAssets_wstETHStablecoinsEMode = new address[](1);
    address[] memory borrowableAssets_wstETHStablecoinsEMode = new address[](2);
    collateralAssets_wstETHStablecoinsEMode[0] = wstETH;
    borrowableAssets_wstETHStablecoinsEMode[0] = USDT0;
    borrowableAssets_wstETHStablecoinsEMode[1] = USDm;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 75_00,
      liqThreshold: 79_00,
      liqBonus: 6_50,
      label: 'wstETH Stablecoins',
      collaterals: collateralAssets_wstETHStablecoinsEMode,
      borrowables: borrowableAssets_wstETHStablecoinsEMode
    });

    // wstETH Correlated
    address[] memory collateralAssets_wstETHCorrelatedEMode = new address[](1);
    address[] memory borrowableAssets_wstETHCorrelatedEMode = new address[](1);
    collateralAssets_wstETHCorrelatedEMode[0] = wstETH;
    borrowableAssets_wstETHCorrelatedEMode[0] = WETH;

    eModeCreations[3] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 94_00,
      liqThreshold: 96_00,
      liqBonus: 1_00,
      label: 'wstETH Correlated',
      collaterals: collateralAssets_wstETHCorrelatedEMode,
      borrowables: borrowableAssets_wstETHCorrelatedEMode
    });

    // wrsETH Correlated
    address[] memory collateralAssets_wrsETHCorrelatedEMode = new address[](1);
    address[] memory borrowableAssets_wrsETHCorrelatedEMode = new address[](1);
    collateralAssets_wrsETHCorrelatedEMode[0] = wrsETH;
    borrowableAssets_wrsETHCorrelatedEMode[0] = WETH;

    eModeCreations[4] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'wrsETH Correlated',
      collaterals: collateralAssets_wrsETHCorrelatedEMode,
      borrowables: borrowableAssets_wrsETHCorrelatedEMode
    });

    // ezETH Correlated
    address[] memory collateralAssets_ezETHCorrelatedEMode = new address[](1);
    address[] memory borrowableAssets_ezETHCorrelatedEMode = new address[](1);
    collateralAssets_ezETHCorrelatedEMode[0] = ezETH;
    borrowableAssets_ezETHCorrelatedEMode[0] = WETH;

    eModeCreations[5] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'ezETH Correlated',
      collaterals: collateralAssets_ezETHCorrelatedEMode,
      borrowables: borrowableAssets_ezETHCorrelatedEMode
    });

    return eModeCreations;
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount) internal {
    IERC20(asset).forceApprove(address(AaveV3MegaEth.POOL), seedAmount);
    AaveV3MegaEth.POOL.supply(asset, seedAmount, address(AaveV3MegaEth.DUST_BIN), 0);

    address aToken = AaveV3MegaEth.POOL.getReserveAToken(asset);
    IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).setEmissionAdmin(asset, LM_ADMIN);
    IEmissionManager(AaveV3MegaEth.EMISSION_MANAGER).setEmissionAdmin(aToken, LM_ADMIN);
  }
}
