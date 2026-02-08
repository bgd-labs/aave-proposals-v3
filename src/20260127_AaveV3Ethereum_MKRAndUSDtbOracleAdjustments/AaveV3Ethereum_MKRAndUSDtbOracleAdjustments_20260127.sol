// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title MKR and USDtb oracle adjustments
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A
 * - Discussion: https://governance.aave.com/t/direct-to-aip-mkr-and-usdtb-oracle-adjustments/23911
 */
contract AaveV3Ethereum_MKRAndUSDtbOracleAdjustments_20260127 is AaveV3PayloadEthereum {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](2);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.MKR_UNDERLYING,
      priceFeed: 0x44Bb2a64bAf94210B583338D3D97b1e8288Bd478
    });

    priceFeedUpdates[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.USDtb_UNDERLYING,
      priceFeed: 0x88025072A7dB6Db5e54E46d43850bb44CA93D6C0
    });

    return priceFeedUpdates;
  }
}
