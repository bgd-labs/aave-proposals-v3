// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';
import {AaveV3PayloadLinea} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadLinea.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title  Increase rsETH Supply Cap on Aave V3 Linea Instance
 * @author Aave-Chan Initiative
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/direct-to-aip-increase-rseth-supply-cap-on-aave-v3-linea-instance/23073
 */
contract AaveV3Linea_IncreaseRsETHSupplyCapOnAaveV3LineaInstance_20250905 is AaveV3PayloadLinea {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3LineaAssets.wrsETH_UNDERLYING,
      supplyCap: 70_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
}
