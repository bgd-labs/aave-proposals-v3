// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title LRT and wstETH Unification Summary
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-core-instance-add-ezeth-and-update-rseth-emode-parameters/21505
 */
contract AaveV3Ethereum_LRTAndWstETHUnificationSummary_20250324 is AaveV3PayloadEthereum {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](1);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.rsETH_UNDERLYING,
      supplyCap: 550_000,
      borrowCap: EngineFlags.KEEP_CURRENT
    });

    return capsUpdate;
  }
  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](6);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 7,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'ezETH_WETH'
    });
    eModeUpdates[1] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 8,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'ezETH_wstETH'
    });
    eModeUpdates[2] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 9,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'rsETH_WETH'
    });
    eModeUpdates[3] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 10,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'weETH_WETH'
    });
    eModeUpdates[4] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 11,
      ltv: 93_50,
      liqThreshold: 95_50,
      liqBonus: 1_00,
      label: 'wstETH_WETH'
    });
    eModeUpdates[5] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: 12,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'rsETH_wstETH'
    });

    return eModeUpdates;
  }
  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](2);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.WETH_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.ETH_CORRELATED,
      borrowable: EngineFlags.ENABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.weETH_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.ETH_CORRELATED,
      borrowable: EngineFlags.KEEP_CURRENT,
      collateral: EngineFlags.ENABLED
    });

    return assetEModeUpdates;
  }
}
