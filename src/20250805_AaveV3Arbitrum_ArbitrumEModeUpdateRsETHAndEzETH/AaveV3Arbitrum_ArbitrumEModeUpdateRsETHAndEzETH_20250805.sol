// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ArbitrumEModes} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from 'aave-helpers/lib/aave-address-book/lib/aave-v3-origin/src/contracts/extensions/v3-config-engine/EngineFlags.sol';

/**
 * @title Arbitrum eMode Update - rsETH and ezETH
 * @author @TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-arbitrum-emode-update-rseth-and-ezeth/22731/3
 */
contract AaveV3Arbitrum_ArbitrumEModeUpdateRsETHAndEzETH_20250805 is AaveV3PayloadArbitrum {
  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](2);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3ArbitrumEModes.EZETH_WSTETH,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: EngineFlags.KEEP_CURRENT_STRING
    });
    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3ArbitrumEModes.RSETH_WSTETH,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: EngineFlags.KEEP_CURRENT_STRING
    });

    return eModeUpdates;
  }

  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_wstETH = new address[](1);
    address[] memory borrowableAssets_wstETH = new address[](1);

    collateralAssets_wstETH[0] = AaveV3ArbitrumAssets.wstETH_UNDERLYING;
    borrowableAssets_wstETH[0] = AaveV3ArbitrumAssets.WETH_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 94_00,
      liqThreshold: 96_00,
      liqBonus: 1_00,
      label: 'wstETH/WETH ETH Correlated',
      collaterals: collateralAssets_wstETH,
      borrowables: borrowableAssets_wstETH
    });

    return eModeCreations;
  }
}
