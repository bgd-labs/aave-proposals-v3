// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Increase cbBTC Supply Caps
 * @author ACI
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-increase-cbbtc-supply-caps-on-aave-v3-ethereum-market-and-base/19304
 */
contract AaveV3Base_IncreaseCbBTCSupplyCaps_20241004 is AaveV3PayloadBase {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3BaseAssets.cbBTC_UNDERLYING,
      supplyCap: 5_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
