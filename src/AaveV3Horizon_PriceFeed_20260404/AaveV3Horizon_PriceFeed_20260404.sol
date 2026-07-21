// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumHorizonAssets} from 'aave-address-book-latest/AaveV3EthereumHorizon.sol';
import {AaveV3PayloadHorizonEthereum} from 'src/utils/AaveV3PayloadHorizonEthereum.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title RLUSD & USDC Price Feed Update on Horizon
 * @author Aave Labs
 * @dev Update RLUSD and USDC oracles to stable cap adapters.
 */
contract AaveV3Horizon_PriceFeed_20260404 is AaveV3PayloadHorizonEthereum {
  // https://etherscan.io/address/0x9E7c31e9b3C76Ea759D9f7464210353862F0c957
  address public constant NEW_RLUSD_ORACLE = 0x9E7c31e9b3C76Ea759D9f7464210353862F0c957; // stable cap adapter
  // https://etherscan.io/address/0x46f94aff8cF7DdC8557eF69f7276087b01C8f363
  address public constant NEW_USDC_ORACLE = 0x46f94aff8cF7DdC8557eF69f7276087b01C8f363; // stable cap adapter

  function priceFeedsUpdates() public pure override returns (IEngine.PriceFeedUpdate[] memory) {
    IEngine.PriceFeedUpdate[] memory updates = new IEngine.PriceFeedUpdate[](2);
    updates[0] = IEngine.PriceFeedUpdate({
      asset: AaveV3EthereumHorizonAssets.RLUSD_UNDERLYING,
      priceFeed: NEW_RLUSD_ORACLE
    });
    updates[1] = IEngine.PriceFeedUpdate({
      asset: AaveV3EthereumHorizonAssets.USDC_UNDERLYING,
      priceFeed: NEW_USDC_ORACLE
    });
    return updates;
  }
}
