// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';

/**
 * @title PTs caps update
 * @author ACI
 * - Discussion: Direct-To-AIP
 */
contract AaveV3Ethereum_PTsCapsUpdate_20250912 is AaveV3PayloadEthereum {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](2);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.PT_sUSDE_27NOV2025_UNDERLYING,
      supplyCap: 1_200_000_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.PT_USDe_27NOV2025_UNDERLYING,
      supplyCap: 1_000_000_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
