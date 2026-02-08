// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3CeloAssets} from 'aave-address-book/AaveV3Celo.sol';
import {AaveV3PayloadCelo} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadCelo.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Enhancing Market Granularity in Aave v3.6
 * @author Chaos Labs (implemented by the ACI via Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-enhancing-market-granularity-in-aave-v3-6-restricting-borrowability-and-collateralization-outside-of-liquid-emodes/23592
 */
contract AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112 is AaveV3PayloadCelo {
  function borrowsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    IAaveV3ConfigEngine.BorrowUpdate[]
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](1);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3CeloAssets.CELO_UNDERLYING,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });

    return borrowUpdates;
  }
}
