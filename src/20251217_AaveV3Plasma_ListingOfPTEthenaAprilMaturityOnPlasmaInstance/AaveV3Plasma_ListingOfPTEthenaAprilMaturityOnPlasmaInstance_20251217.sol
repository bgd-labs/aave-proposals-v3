// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {AaveV3PayloadPlasma} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPlasma.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Listing of PT Ethena April Maturity on Plasma Instance
 * @author ACI
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-april-expiry-pt-tokens-on-aave-v3-plasma-instance/23515/3
 */
contract AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217 is
  AaveV3PayloadPlasma
{
  using SafeERC20 for IERC20;

  address public constant PT_sUSDE_9APR2026 = 0xab509448ad489e2E1341e25CC500f2596464Cc82;
  uint256 public constant PT_sUSDE_9APR2026_SEED_AMOUNT = 100e18;
  address public constant PT_sUSDE_9APR2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant PT_USDe_9APR2026 = 0x54Dc267be2839303ff1e323584A16e86CeC4Aa44;
  uint256 public constant PT_USDe_9APR2026_SEED_AMOUNT = 100e18;
  address public constant PT_USDe_9APR2026_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(
      PT_sUSDE_9APR2026,
      PT_sUSDE_9APR2026_SEED_AMOUNT,
      PT_sUSDE_9APR2026_LM_ADMIN
    );

    _supplyAndConfigureLMAdmin(
      PT_USDe_9APR2026,
      PT_USDe_9APR2026_SEED_AMOUNT,
      PT_USDe_9APR2026_LM_ADMIN
    );
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](4);

    address[] memory collateralAssets_PT_USDe_9APR2026__Stablecoins = new address[](3);
    address[] memory borrowableAssets_PT_USDe_9APR2026__Stablecoins = new address[](2);

    collateralAssets_PT_USDe_9APR2026__Stablecoins[0] = AaveV3PlasmaAssets.USDe_UNDERLYING;
    collateralAssets_PT_USDe_9APR2026__Stablecoins[1] = AaveV3PlasmaAssets.weETH_UNDERLYING;
    collateralAssets_PT_USDe_9APR2026__Stablecoins[2] = AaveV3PlasmaAssets
      .PT_USDe_15JAN2026_UNDERLYING;
    borrowableAssets_PT_USDe_9APR2026__Stablecoins[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;
    borrowableAssets_PT_USDe_9APR2026__Stablecoins[1] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 86_40,
      liqThreshold: 88_40,
      liqBonus: 4_70,
      label: 'PT_USDe_9APR2026__Stablecoins',
      collaterals: collateralAssets_PT_USDe_9APR2026__Stablecoins,
      borrowables: borrowableAssets_PT_USDe_9APR2026__Stablecoins
    });

    address[] memory collateralAssets_PT_USDe_9APR2026__USDe = new address[](3);
    address[] memory borrowableAssets_PT_USDe_9APR2026__USDe = new address[](2);

    collateralAssets_PT_USDe_9APR2026__USDe[0] = AaveV3PlasmaAssets.USDe_UNDERLYING;
    collateralAssets_PT_USDe_9APR2026__USDe[1] = AaveV3PlasmaAssets.weETH_UNDERLYING;
    collateralAssets_PT_USDe_9APR2026__USDe[2] = AaveV3PlasmaAssets.PT_USDe_15JAN2026_UNDERLYING;
    borrowableAssets_PT_USDe_9APR2026__USDe[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;
    borrowableAssets_PT_USDe_9APR2026__USDe[1] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 87_20,
      liqThreshold: 89_20,
      liqBonus: 3_70,
      label: 'PT_USDe_9APR2026__USDe',
      collaterals: collateralAssets_PT_USDe_9APR2026__USDe,
      borrowables: borrowableAssets_PT_USDe_9APR2026__USDe
    });

    address[] memory collateralAssets_PT_sUSDe_9APR2026__Stablecoins = new address[](3);
    address[] memory borrowableAssets_PT_sUSDe_9APR2026__Stablecoins = new address[](2);

    collateralAssets_PT_sUSDe_9APR2026__Stablecoins[0] = AaveV3PlasmaAssets.sUSDe_UNDERLYING;
    collateralAssets_PT_sUSDe_9APR2026__Stablecoins[1] = AaveV3PlasmaAssets.XAUt0_UNDERLYING;
    collateralAssets_PT_sUSDe_9APR2026__Stablecoins[2] = AaveV3PlasmaAssets
      .PT_sUSDE_15JAN2026_UNDERLYING;
    borrowableAssets_PT_sUSDe_9APR2026__Stablecoins[0] = AaveV3PlasmaAssets.USDT0_UNDERLYING;
    borrowableAssets_PT_sUSDe_9APR2026__Stablecoins[1] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    eModeCreations[2] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 85_50,
      liqThreshold: 87_50,
      liqBonus: 5_70,
      label: 'PT_sUSDe_9APR2026__Stablecoins',
      collaterals: collateralAssets_PT_sUSDe_9APR2026__Stablecoins,
      borrowables: borrowableAssets_PT_sUSDe_9APR2026__Stablecoins
    });

    address[] memory collateralAssets_PT_sUSDe_9APR2026__USDe = new address[](3);
    address[] memory borrowableAssets_PT_sUSDe_9APR2026__USDe = new address[](1);

    collateralAssets_PT_sUSDe_9APR2026__USDe[0] = AaveV3PlasmaAssets.sUSDe_UNDERLYING;
    collateralAssets_PT_sUSDe_9APR2026__USDe[1] = AaveV3PlasmaAssets.XAUt0_UNDERLYING;
    collateralAssets_PT_sUSDe_9APR2026__USDe[2] = AaveV3PlasmaAssets.PT_sUSDE_15JAN2026_UNDERLYING;
    borrowableAssets_PT_sUSDe_9APR2026__USDe[0] = AaveV3PlasmaAssets.USDe_UNDERLYING;

    eModeCreations[3] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 87_20,
      liqThreshold: 89_20,
      liqBonus: 3_70,
      label: 'PT_sUSDe_9APR2026__USDe',
      collaterals: collateralAssets_PT_sUSDe_9APR2026__USDe,
      borrowables: borrowableAssets_PT_sUSDe_9APR2026__USDe
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](2);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: PT_sUSDE_9APR2026,
      assetSymbol: 'PT_sUSDE_9APR2026',
      priceFeed: 0x13f2EA8dfa948c5247826283079615Ee4d0A1AA5,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 100_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: PT_USDe_9APR2026,
      assetSymbol: 'PT_USDe_9APR2026',
      priceFeed: 0x37f3a8b02BAbe4dd71acb5f214F22C09AFf607f3,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 5,
      liqThreshold: 10,
      liqBonus: 7_50,
      reserveFactor: 45_00,
      supplyCap: 40_000_000,
      borrowCap: 1,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 45_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 10_00,
        variableRateSlope2: 300_00
      })
    });

    return listings;
  }
  function _supplyAndConfigureLMAdmin(address asset, uint256 seedAmount, address lmAdmin) internal {
    IERC20(asset).forceApprove(address(AaveV3Plasma.POOL), seedAmount);
    AaveV3Plasma.POOL.supply(asset, seedAmount, address(AaveV3Plasma.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Plasma.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }
}
