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
  // https://etherscan.io/address/0x03bB418e89B75407585f8198178f253DA3216218
  address public constant EBTC_CAPO_ADAPTER = 0x03bB418e89B75407585f8198178f253DA3216218;

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](2);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.LBTC_UNDERLYING,
      priceFeed: LBTC_CAPO_ADAPTER
    });

    priceFeedUpdates[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.eBTC_UNDERLYING,
      priceFeed: EBTC_CAPO_ADAPTER
    });

    return priceFeedUpdates;
  }
}
