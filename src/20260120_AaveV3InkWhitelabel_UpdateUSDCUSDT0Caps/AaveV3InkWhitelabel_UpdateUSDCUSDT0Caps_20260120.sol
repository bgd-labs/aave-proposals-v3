// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3PayloadInkWhitelabel} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadInkWhitelabel.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Update USDC & USDT0 caps
 * @author ACI
 */
contract AaveV3InkWhitelabel_UpdateUSDCUSDT0Caps_20260120 is AaveV3PayloadInkWhitelabel {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](2);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.USDT_UNDERLYING,
      supplyCap: 375_000_000,
      borrowCap: 340_000_000
    });
    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.USDC_UNDERLYING,
      supplyCap: 250_000_000,
      borrowCap: 225_000_000
    });

    return capsUpdate;
  }
}
