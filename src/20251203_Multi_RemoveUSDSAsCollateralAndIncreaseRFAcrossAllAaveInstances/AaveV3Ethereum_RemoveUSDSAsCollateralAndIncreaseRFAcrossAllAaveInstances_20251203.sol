// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Remove USDS as collateral and increase RF across all Aave Instances
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xeb05b887d9db47d2f4a42d4f4fcb7141080d091dc8c1b32e9a75597071f949ea
 * - Discussion: https://governance.aave.com/t/arfc-remove-usds-as-collateral-and-increase-rf-across-all-aave-instances/23426
 */
contract AaveV3Ethereum_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203 is
  AaveV3PayloadEthereum
{
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](2);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.DAI_UNDERLYING,
      supplyCap: 200_000_000,
      borrowCap: 180_000_000
    });
    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      supplyCap: 160_000_000,
      borrowCap: 144_000_000
    });

    return capsUpdate;
  }
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](2);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.DAI_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return collateralUpdate;
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
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 25_00
    });

    return borrowUpdates;
  }
  function assetsEModeUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.AssetEModeUpdate[] memory)
  {
    IAaveV3ConfigEngine.AssetEModeUpdate[]
      memory assetEModeUpdates = new IAaveV3ConfigEngine.AssetEModeUpdate[](11);

    assetEModeUpdates[0] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.USDe_sUSDe__USDC_USDT_USDS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[1] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.sUSDe_PT_sUSDE_31JUL2025__USDC_USDT_USDS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[2] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.PT_eUSDE_29MAY2025_eUSDe__USDC_USDT_USDS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[3] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.USDe_PT_USDe_31JUL2025__USDC_USDT_USDS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[4] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.USDe__USDC_USDT_USDS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[5] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.PT_eUSDE_14AUG2025_eUSDe__USDC_USDT_USDS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[6] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes.eUSDe__USDC_USDT_USDS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[7] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes
        .sUSDe_PT_sUSDE_31JUL2025_PT_sUSDE_25SEP2025__USDC_USDT_USDe_USDS_USDtb,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[8] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes
        .USDe_PT_USDe_31JUL2025_PT_eUSDE_14AUG2025_PT_USDe_25SEP2025__USDC_USDT_USDe_USDS,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[9] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes
        .sUSDe_PT_sUSDE_25SEP2025_PT_sUSDE_27NOV2025__USDC_USDT_USDe_USDS_USDtb,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });
    assetEModeUpdates[10] = IAaveV3ConfigEngine.AssetEModeUpdate({
      asset: AaveV3EthereumAssets.USDS_UNDERLYING,
      eModeCategory: AaveV3EthereumEModes
        .PT_USDe_25SEP2025_PT_USDe_27NOV2025__USDC_USDT_USDe_USDS_USDtb,
      borrowable: EngineFlags.DISABLED,
      collateral: EngineFlags.KEEP_CURRENT
    });

    return assetEModeUpdates;
  }
}
