// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

/**
 * @title Onboard sUSDe and USDe to Aave V3 Avalanche Instance
 * @author Aave-chan Initiative
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-onboard-susde-and-usde-to-aave-v3-avalanche-instance/23081
 */
contract AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013 is
  AaveV3PayloadAvalanche
{
  using SafeERC20 for IERC20;

  address public constant USDe = 0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34;
  uint256 public constant USDe_SEED_AMOUNT = 100e18;
  address public constant USDe_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  address public constant sUSDe = 0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2;
  uint256 public constant sUSDe_SEED_AMOUNT = 100e18;
  address public constant sUSDe_LM_ADMIN = 0xac140648435d03f784879cd789130F22Ef588Fcd;

  function _postExecute() internal override {
    _supplyAndConfigureLMAdmin(USDe, USDe_SEED_AMOUNT, USDe_LM_ADMIN);

    _supplyAndConfigureLMAdmin(sUSDe, sUSDe_SEED_AMOUNT, sUSDe_LM_ADMIN);
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](2);

    address[] memory collateralAssets_USDeStablecoin = new address[](1);
    address[] memory borrowableAssets_USDeStablecoin = new address[](3);

    collateralAssets_USDeStablecoin[0] = USDe;
    borrowableAssets_USDeStablecoin[0] = AaveV3AvalancheAssets.USDC_UNDERLYING;
    borrowableAssets_USDeStablecoin[1] = AaveV3AvalancheAssets.USDt_UNDERLYING;
    borrowableAssets_USDeStablecoin[2] = AaveV3AvalancheAssets.GHO_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 89_00,
      liqThreshold: 92_00,
      liqBonus: 2_00,
      label: 'USDe/Stablecoin',
      collaterals: collateralAssets_USDeStablecoin,
      borrowables: borrowableAssets_USDeStablecoin
    });

    address[] memory collateralAssets_SUSDeStablecoin = new address[](1);
    address[] memory borrowableAssets_SUSDeStablecoin = new address[](4);

    collateralAssets_SUSDeStablecoin[0] = sUSDe;
    borrowableAssets_SUSDeStablecoin[0] = USDe;
    borrowableAssets_SUSDeStablecoin[1] = AaveV3AvalancheAssets.USDC_UNDERLYING;
    borrowableAssets_SUSDeStablecoin[2] = AaveV3AvalancheAssets.USDt_UNDERLYING;
    borrowableAssets_SUSDeStablecoin[3] = AaveV3AvalancheAssets.GHO_UNDERLYING;

    eModeCreations[1] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 89_00,
      liqThreshold: 91_00,
      liqBonus: 4_00,
      label: 'sUSDe/Stablecoin',
      collaterals: collateralAssets_SUSDeStablecoin,
      borrowables: borrowableAssets_SUSDeStablecoin
    });

    return eModeCreations;
  }
  function newListings() public pure override returns (IAaveV3ConfigEngine.Listing[] memory) {
    IAaveV3ConfigEngine.Listing[] memory listings = new IAaveV3ConfigEngine.Listing[](2);

    listings[0] = IAaveV3ConfigEngine.Listing({
      asset: USDe,
      assetSymbol: 'USDe',
      priceFeed: AaveV3AvalancheAssets.USDt_ORACLE,
      enabledToBorrow: EngineFlags.ENABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 73_00,
      liqBonus: 8_50,
      reserveFactor: 25_00,
      supplyCap: 50_000_000,
      borrowCap: 42_500_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      rateStrategyParams: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 6_50,
        variableRateSlope2: 50_00
      })
    });
    listings[1] = IAaveV3ConfigEngine.Listing({
      asset: sUSDe,
      assetSymbol: 'sUSDe',
      priceFeed: 0x8Fb2db0A3b25db76B9BE2013751F8390ea8E5f0A,
      enabledToBorrow: EngineFlags.DISABLED,
      borrowableInIsolation: EngineFlags.DISABLED,
      withSiloedBorrowing: EngineFlags.DISABLED,
      flashloanable: EngineFlags.ENABLED,
      ltv: 70_00,
      liqThreshold: 73_00,
      liqBonus: 8_50,
      reserveFactor: 45_00,
      supplyCap: 50_000_000,
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
    IERC20(asset).forceApprove(address(AaveV3Avalanche.POOL), seedAmount);
    AaveV3Avalanche.POOL.supply(asset, seedAmount, address(AaveV3Avalanche.DUST_BIN), 0);

    if (lmAdmin != address(0)) {
      address aToken = AaveV3Avalanche.POOL.getReserveAToken(asset);
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(asset, lmAdmin);
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setEmissionAdmin(aToken, lmAdmin);
    }
  }
}
