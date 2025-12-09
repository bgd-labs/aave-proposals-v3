// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Alter mUSD Oracle Price Implementation
 * @author Chaos Labs
 * - Discussion: https://governance.aave.com/t/direct-to-aip-alter-musd-oracle-price-implementation/23489
 */
contract AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204 is AaveV3PayloadEthereum {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.mUSD_UNDERLYING,
      supplyCap: 5_000_000,
      borrowCap: 4_500_000
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
      asset: AaveV3EthereumAssets.mUSD_UNDERLYING,
      priceFeed: 0x8adb5187695F773513dEC4b569d21db0341931dA
    });

    return priceFeedUpdates;
  }
}
