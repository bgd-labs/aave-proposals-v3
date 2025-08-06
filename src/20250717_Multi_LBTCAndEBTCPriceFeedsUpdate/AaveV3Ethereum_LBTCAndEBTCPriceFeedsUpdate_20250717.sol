// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IPriceCapAdapter} from '../interfaces/IPriceCapAdapter.sol';

/**
 * @title LBTC and eBTC Price Feeds Update
 * @author BGD Labs @bgdlabs
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-lbtc-oracle-and-capo-implementation-update/22614
 */
contract AaveV3Ethereum_LBTCAndEBTCPriceFeedsUpdate_20250717 is AaveV3PayloadEthereum {
  // https://etherscan.io/address/0xf8c04B50499872A5B5137219DEc0F791f7f620D0
  address public constant LBTC_CAPO_ADAPTER = 0xf8c04B50499872A5B5137219DEc0F791f7f620D0;

  uint104 public constant EBTC_SNAPSHOT_RATIO = 1_00000000;
  uint48 public constant EBTC_SNAPSHOT_TIMESTAMP = 1750023287;
  uint16 public constant EBTC_SNAPSHOT_MAX_YEARLY_RATIO_GROWTH_PERCENTAGE = 1_90;

  function _postExecute() internal override {
    IPriceCapAdapter.PriceCapUpdateParams memory params = IPriceCapAdapter.PriceCapUpdateParams({
      snapshotRatio: EBTC_SNAPSHOT_RATIO,
      snapshotTimestamp: EBTC_SNAPSHOT_TIMESTAMP,
      maxYearlyRatioGrowthPercent: EBTC_SNAPSHOT_MAX_YEARLY_RATIO_GROWTH_PERCENTAGE
    });
    IPriceCapAdapter(AaveV3EthereumAssets.eBTC_ORACLE).setCapParameters(params);
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
      asset: AaveV3EthereumAssets.LBTC_UNDERLYING,
      priceFeed: LBTC_CAPO_ADAPTER
    });

    return priceFeedUpdates;
  }
}
