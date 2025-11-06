// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3PayloadGnosis} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadGnosis.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Reinstate Supply and Borrow Caps on Aave V3 Gnosis Instance
 * @author Chaos Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/direct-to-aip-reinstate-supply-and-borrow-caps-on-aave-v3-gnosis-instance/23373
 */
contract AaveV3Gnosis_ReinstateSupplyAndBorrowCapsOnAaveV3GnosisInstance_20251106 is
  AaveV3PayloadGnosis
{
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](8);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3GnosisAssets.WETH_UNDERLYING,
      supplyCap: 3_600,
      borrowCap: 2_400
    });
    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3GnosisAssets.wstETH_UNDERLYING,
      supplyCap: 150_000,
      borrowCap: 150
    });
    capsUpdate[2] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3GnosisAssets.GNO_UNDERLYING,
      supplyCap: 140_000,
      borrowCap: 20_000
    });
    capsUpdate[3] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3GnosisAssets.WXDAI_UNDERLYING,
      supplyCap: 4_000_000,
      borrowCap: 3_700_000
    });
    capsUpdate[4] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3GnosisAssets.EURe_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 22_500_000
    });
    capsUpdate[5] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3GnosisAssets.sDAI_UNDERLYING,
      supplyCap: 24_000_000,
      borrowCap: 1
    });
    capsUpdate[6] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3GnosisAssets.USDCe_UNDERLYING,
      supplyCap: 12_000_000,
      borrowCap: 11_000_000
    });
    capsUpdate[7] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3GnosisAssets.GHO_UNDERLYING,
      supplyCap: 1_500_000,
      borrowCap: 1_400_000
    });

    return capsUpdate;
  }
}
