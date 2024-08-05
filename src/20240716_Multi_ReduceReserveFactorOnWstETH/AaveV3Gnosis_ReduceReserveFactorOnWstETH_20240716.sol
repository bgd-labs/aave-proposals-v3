// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3PayloadGnosis} from 'aave-helpers/v3-config-engine/AaveV3PayloadGnosis.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Reduce Reserve Factor on wstETH
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x7ef3a8d68fa8a1b69d298aceddfafe9d2a24eefb19365d995c839b1cd1b0b97d
 * - Discussion: https://governance.aave.com/t/arfc-reduce-reserve-factor-on-wsteth/18044/1
 */
contract AaveV3Gnosis_ReduceReserveFactorOnWstETH_20240716 is AaveV3PayloadGnosis {
  function borrowsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    IAaveV3ConfigEngine.BorrowUpdate[]
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](1);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3GnosisAssets.wstETH_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 5_00
    });

    return borrowUpdates;
  }
}
