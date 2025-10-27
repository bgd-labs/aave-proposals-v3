// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3PayloadGnosis} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadGnosis.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title USDC (old) deprecation on Gnosis Chain Instance
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x438b460559aa8c3a039f28212362af9a0e3b94a88e4a2b8230fe2c5e8f4d43da
 * - Discussion: https://governance.aave.com/t/arfc-usdc-old-deprecation-on-gnosis-chain-instance/23189
 */
contract AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024 is AaveV3PayloadGnosis {
  function _postExecute() internal override {
    AaveV3Gnosis.POOL_CONFIGURATOR.setReserveFreeze(AaveV3GnosisAssets.USDC_UNDERLYING, true);
  }

  function borrowsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.BorrowUpdate[] memory)
  {
    IAaveV3ConfigEngine.BorrowUpdate[]
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](1);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3GnosisAssets.USDC_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 80_00
    });

    return borrowUpdates;
  }
}
