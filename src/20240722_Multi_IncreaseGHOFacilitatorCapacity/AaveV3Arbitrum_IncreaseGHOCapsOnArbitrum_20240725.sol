// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Increase GHO Caps On Arbitrum
 * @author Karpatkey_Tokenlogic
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_IncreaseGHOCapsOnArbitrum_20240725 is AaveV3PayloadArbitrum {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](0);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3ArbitrumAssets.GHO_UNDERLYING,
      supplyCap: 5_000_000,
      borrowCap: 4_500_000
    });

    return capsUpdate;
  }
}
