// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/v3-config-engine/AaveV3PayloadBase.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Increase weETH Caps on Base
 * @author Aave Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-increase-supply-and-borrow-caps-for-weeth-on-base/18248
 */
contract AaveV3Base_IncreaseWeETHCapsOnBase_20240714 is AaveV3PayloadBase {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3BaseAssets.weETH_UNDERLYING,
      supplyCap: 20_000,
      borrowCap: 9_000
    });

    return capsUpdate;
  }
}
