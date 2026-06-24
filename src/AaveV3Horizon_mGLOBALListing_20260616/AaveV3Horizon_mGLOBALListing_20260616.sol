// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumHorizonCustom} from 'src/utils/AaveV3EthereumHorizonCustom.sol';
import {AaveV3EthereumHorizonAssets} from 'aave-address-book-latest/AaveV3EthereumHorizon.sol';
import {AaveV3PayloadHorizonEthereum} from 'src/utils/AaveV3PayloadHorizonEthereum.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';

/**
 * @title Horizon Listing — mGLOBAL
 * @author Aave Labs
 * @dev Lists mGLOBAL (Midas Global Diversified Alternative Debt Fund) as an RWA collateral asset
 *      on the Horizon pool. The default reserve config uses near-zero LTV/LT so that borrowing
 *      against mGLOBAL outside eMode is negligible; an mGLOBAL/stablecoins eMode (USDC, RLUSD)
 *      provides the intended collateral parameters.
 */
contract AaveV3Horizon_mGLOBALListing_20260616 is AaveV3PayloadHorizonEthereum {
  address public constant MGLOBAL = AaveV3EthereumHorizonCustom.MGLOBAL_UNDERLYING;
  address public constant MGLOBAL_PRICE_FEED = AaveV3EthereumHorizonCustom.MGLOBAL_PRICE_FEED;
  uint8 public constant MGLOBAL_EMODE_CATEGORY = 5;

  function newListingsCustom()
    public
    pure
    override
    returns (IEngine.ListingWithCustomImpl[] memory)
  {
    IEngine.ListingWithCustomImpl[] memory listingsCustom = new IEngine.ListingWithCustomImpl[](1);

    listingsCustom[0] = IEngine.ListingWithCustomImpl(
      IEngine.Listing({
        asset: MGLOBAL,
        assetSymbol: 'mGLOBAL',
        priceFeed: MGLOBAL_PRICE_FEED,
        rateStrategyParams: AaveV3EthereumHorizonCustom.defaultRwaInterestRateInputData(),
        enabledToBorrow: EngineFlags.DISABLED,
        borrowableInIsolation: EngineFlags.DISABLED,
        withSiloedBorrowing: EngineFlags.DISABLED,
        flashloanable: EngineFlags.DISABLED,
        ltv: 5,
        liqThreshold: 10,
        liqBonus: 6_00,
        reserveFactor: EngineFlags.KEEP_CURRENT,
        supplyCap: 50_000_000,
        borrowCap: 0,
        debtCeiling: 0,
        liqProtocolFee: 0
      }),
      IEngine.TokenImplementations({
        aToken: AaveV3EthereumHorizonCustom.RWA_A_TOKEN_IMPL,
        vToken: AaveV3EthereumHorizonCustom.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL
      })
    );

    return listingsCustom;
  }

  function assetsEModeUpdates() public pure override returns (IEngine.AssetEModeUpdate[] memory) {
    IEngine.AssetEModeUpdate[] memory assetsEMode = new IEngine.AssetEModeUpdate[](3);

    // mGLOBAL as collateral in the stablecoins eMode
    assetsEMode[0] = IEngine.AssetEModeUpdate({
      asset: MGLOBAL,
      eModeCategory: MGLOBAL_EMODE_CATEGORY,
      collateral: EngineFlags.ENABLED,
      borrowable: EngineFlags.DISABLED
    });

    // USDC as borrowable in the stablecoins eMode
    assetsEMode[1] = IEngine.AssetEModeUpdate({
      asset: AaveV3EthereumHorizonAssets.USDC_UNDERLYING,
      eModeCategory: MGLOBAL_EMODE_CATEGORY,
      collateral: EngineFlags.DISABLED,
      borrowable: EngineFlags.ENABLED
    });

    // RLUSD as borrowable in the stablecoins eMode
    assetsEMode[2] = IEngine.AssetEModeUpdate({
      asset: AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING,
      eModeCategory: MGLOBAL_EMODE_CATEGORY,
      collateral: EngineFlags.DISABLED,
      borrowable: EngineFlags.ENABLED
    });

    return assetsEMode;
  }

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IEngine.EModeCategoryUpdate[] memory)
  {
    IEngine.EModeCategoryUpdate[] memory eModeCategories = new IEngine.EModeCategoryUpdate[](1);

    // mGLOBAL Stablecoins
    eModeCategories[0] = IEngine.EModeCategoryUpdate({
      eModeCategory: MGLOBAL_EMODE_CATEGORY,
      ltv: 75_00,
      liqThreshold: 80_00,
      liqBonus: 6_00,
      label: 'mGLOBAL Stablecoins'
    });

    return eModeCategories;
  }
}
