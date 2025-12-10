// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';
import {AaveV3PayloadLinea} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadLinea.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Alter mUSD Oracle Price Implementation
 * @author Chaos Labs
 * - Discussion: https://governance.aave.com/t/direct-to-aip-alter-musd-oracle-price-implementation/23489
 */
contract AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204 is AaveV3PayloadLinea {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3LineaAssets.mUSD_UNDERLYING,
      supplyCap: 20_000_000,
      borrowCap: 18_000_000
    });

    return capsUpdate;
  }

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3LineaAssets.mUSD_UNDERLYING,
      priceFeed: 0xA77b1C51a76bbB72D17BF467393a540868103097
    });

    return priceFeedUpdates;
  }
}
