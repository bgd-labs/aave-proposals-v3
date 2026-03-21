// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Re-enable wstETH borrow caps
 * @author Aavechan Initiative @aci and Chaos Labs
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-re-enable-wsteth-borrow-caps-on-ethereum-core-and-prime-post-capo-incident/24295
 */
contract AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316 is AaveV3PayloadEthereum {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.wstETH_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 180_000
    });

    return capsUpdate;
  }
}
