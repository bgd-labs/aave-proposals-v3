// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Test
 * @author BGD
 * - Snapshot: link
 * - Discussion: link
 */
contract AaveV3Ethereum_Test_20231024 is AaveV3PayloadEthereum {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      supplyCap: 10_000_000,
      borrowCap: 100_000
    });

    return capsUpdate;
  }
}
