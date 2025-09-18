// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Aave V3.5 Plasma Activation
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xa2b9d0717a82a111acc27e514bed07caa9b8636c12dd68fb61ae4dc57503c3cd
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v3-on-plasma/21494
 */
contract AaveV3Plasma_AaveV35PlasmaActivation_20250917 is AaveV3PayloadPlasma {
  using SafeERC20 for IERC20;

  address public constant USDT0 = 0xB8CE59FC3717ada4C02eaDF9682A9e934F625ebb;
  uint256 public constant USDT0_SEED_AMOUNT = 10e6;

  address public constant USDe = 0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34;
  uint256 public constant USDe_SEED_AMOUNT = 10e18;

  address public constant sUSDe = 0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2;
  uint256 public constant sUSDe_SEED_AMOUNT = 10e18;

  address public constant XAUt0 = 0x1B64B9025EEbb9A6239575dF9Ea4b9Ac46D4d193;
  uint256 public constant XAUt0_SEED_AMOUNT = 0.01e6;

  address public constant weETH = 0xA3D68b74bF0528fdD07263c60d6488749044914b;
  uint256 public constant weETH_SEED_AMOUNT = 0.005e18;

  address public constant WETH = 0x9895D81bB462A195b4922ED7De0e3ACD007c32CB;
  uint256 public constant WETH_SEED_AMOUNT = 0.005e18;

  address public constant LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(USDT0, USDT0_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(USDe, USDe_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(sUSDe, sUSDe_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(XAUt0, XAUt0_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(weETH, weETH_SEED_AMOUNT);
    _supplyAndConfigureLMAdmin(WETH, WETH_SEED_AMOUNT);

    AaveV3Plasma.ACL_MANAGER.addPoolAdmin(MiscPlasma.PROTOCOL_GUARDIAN);
    AaveV3Plasma.ACL_MANAGER.addRiskAdmin(AaveV3Plasma.RISK_STEWARD);
  }

  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](6);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDT0,
      assetSymbol: 'USDT0',
      priceFeed: 0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 4_50,
      reserveFactor: 10_00,
      supplyCap: 100_000,
      borrowCap: 50_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 92_00,
        baseVariableBorrowRate: 2_50,
        variableRateSlope1: 4_00,
        variableRateSlope2: 20_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: USDe,
      assetSymbol: 'USDe',
      priceFeed: 0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 72_00,
      liqThreshold: 75_00,
      liqBonus: 8_50,
      reserveFactor: 25_00,
      supplyCap: 100_000,
      borrowCap: 50_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 85_00,
        baseVariableBorrowRate: 2_50,
        variableRateSlope1: 5_00,
        variableRateSlope2: 50_00
      })
    });
    listings[2] = IAaveV3ConfigEngine.Listing({
      asset: sUSDe,
      assetSymbol: 'sUSDe',
      priceFeed: 0x40eE40D7332995CACA49Db46B94237Fa64647Bd4,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 8_50,
      reserveFactor: 20_00,
      supplyCap: 100_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 60_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_00,
        variableRateSlope2: 75_00
      })
    });
    listings[3] = IAaveV3ConfigEngine.Listing({
      asset: XAUt0,
      assetSymbol: 'XAUt0',
      priceFeed: 0x921371Fa4d4A30cD350D29762ccB8A5861724E29,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 7_50,
      reserveFactor: 20_00,
      supplyCap: 30,
      borrowCap: 1,
      debtCeiling: 18_000_000,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 60_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_00,
        variableRateSlope2: 75_00
      })
    });
    listings[4] = IAaveV3ConfigEngine.Listing({
      asset: weETH,
      assetSymbol: 'weETH',
      priceFeed: 0xA7786e3042435f88869e5a4e384B0AD6B009800b,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_00,
      reserveFactor: 20_00,
      supplyCap: 20,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 60_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 9_00,
        variableRateSlope2: 75_00
      })
    });
    listings[5] = IAaveV3ConfigEngine.Listing({
      asset: WETH,
      assetSymbol: 'WETH',
      priceFeed: 0x43A7dd2125266c5c4c26EB86cd61241132426Fe7,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 80_50,
      liqThreshold: 83_00,
      liqBonus: 5_50,
      reserveFactor: 15_00,
      supplyCap: 20,
      borrowCap: 10,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 92_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 2_70,
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
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](4);

    // USDe Stablecoins
    address[] memory collateralAssets_USDeEmode = new address[](1);
    address[] memory borrowableAssets_USDeEmode = new address[](1);
    collateralAssets_USDeEmode[0] = USDe;
    borrowableAssets_USDeEmode[0] = USDT0;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 93_00,
      liqBonus: 2_00,
      label: 'USDe Stablecoins',
      collaterals: collateralAssets_USDeEmode,
      borrowables: borrowableAssets_USDeEmode
    });

    // sUSDe Stablecoins
    address[] memory collateralAssets_sUSDeEmode = new address[](2);
    address[] memory borrowableAssets_sUSDeEmode = new address[](1);
    collateralAssets_sUSDeEmode[0] = USDe;
    collateralAssets_sUSDeEmode[1] = sUSDe;
    borrowableAssets_sUSDeEmode[0] = USDT0;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 90_00,
      liqThreshold: 92_00,
      liqBonus: 4_00,
      label: 'sUSDe Stablecoins',
      collaterals: collateralAssets_sUSDeEmode,
      borrowables: borrowableAssets_sUSDeEmode
    });

    // weETH WETH
    address[] memory collateralAssets_weETH_ETH_Emode = new address[](1);
    address[] memory borrowableAssets_weETH_ETH_Emode = new address[](1);
    collateralAssets_weETH_ETH_Emode[0] = weETH;
    borrowableAssets_weETH_ETH_Emode[0] = WETH;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'weETH WETH',
      collaterals: collateralAssets_weETH_ETH_Emode,
      borrowables: borrowableAssets_weETH_ETH_Emode
    });

    // weETH Stablecoins
    address[] memory collateralAssets_weETH_Stables_Emode = new address[](1);
    address[] memory borrowableAssets_weETH_Stables_Emode = new address[](1);
    collateralAssets_weETH_Stables_Emode[0] = weETH;
    borrowableAssets_weETH_Stables_Emode[0] = USDT0;

    eModeCreations[3] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 7_50,
      label: 'weETH Stablecoins',
      collaterals: collateralAssets_weETH_Stables_Emode,
      borrowables: borrowableAssets_weETH_Stables_Emode
    });

    return eModeCreations;
  }

  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount) internal {
    IERC20(asset).forceApprove(address(AaveV3Plasma.POOL), seedAmount);
    AaveV3Plasma.POOL.supply(asset, seedAmount, address(AaveV3Plasma.DUST_BIN), 0);

    address aToken = AaveV3Plasma.POOL.getReserveAToken(asset);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(asset, LM_ADMIN);
    IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(aToken, LM_ADMIN);
  }
}
