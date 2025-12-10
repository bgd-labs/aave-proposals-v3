// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3PayloadInkWhitelabel} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadInkWhitelabel.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Update AaveV3InkWhitelabel assets caps
 * @author ACI
 */
contract AaveV3InkWhitelabel_UpdateAaveV3InkWhitelabelAssetsCaps_20251127 is
  AaveV3PayloadInkWhitelabel
{
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](3);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.WETH_UNDERLYING,
      supplyCap: 80_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });
    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.GHO_UNDERLYING,
      supplyCap: 20_000_000,
      borrowCap: 18_000_000
    });
    capsUpdate[2] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.USDC_UNDERLYING,
      supplyCap: 20_000_000,
      borrowCap: 19_000_000
    });

    return capsUpdate;
  }
}
