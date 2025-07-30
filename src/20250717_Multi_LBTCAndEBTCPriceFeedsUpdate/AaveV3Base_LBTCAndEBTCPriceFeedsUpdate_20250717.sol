// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title LBTC and eBTC Price Feeds Update
 * @author BGD Labs @bgdlabs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-lbtc-oracle-and-capo-implementation-update/22614
 */
contract AaveV3Base_LBTCAndEBTCPriceFeedsUpdate_20250717 is AaveV3PayloadBase {
  // https://basescan.org/address/0xA04669FE5cba4Bb21f265B562D23e562E45A1C67
  address public constant LBTC_CAPO_ADAPTER = 0xA04669FE5cba4Bb21f265B562D23e562E45A1C67;

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3BaseAssets.LBTC_UNDERLYING,
      priceFeed: LBTC_CAPO_ADAPTER
    });

    return priceFeedUpdates;
  }
}
