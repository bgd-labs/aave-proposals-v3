// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumHorizonCustom} from 'src/utils/AaveV3EthereumHorizonCustom.sol';
import {AaveV3PayloadHorizonEthereum} from 'src/utils/AaveV3PayloadHorizonEthereum.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';

/**
 * @title Horizon Listing — mGLOBAL
 * @author Aave Labs
 * @dev Lists mGLOBAL (Midas Global Diversified Alternative Debt Fund) as an RWA collateral asset
 *      on the Horizon pool.
 */
contract AaveV3Horizon_mGLOBALListing_20260616 is AaveV3PayloadHorizonEthereum {
  address public constant MGLOBAL = AaveV3EthereumHorizonCustom.MGLOBAL_UNDERLYING;
  address public constant MGLOBAL_PRICE_FEED = AaveV3EthereumHorizonCustom.MGLOBAL_PRICE_FEED;

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
        ltv: 70_00,
        liqThreshold: 75_00,
        liqBonus: 6_00,
        reserveFactor: EngineFlags.KEEP_CURRENT,
        supplyCap: 60_000_000,
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
}
