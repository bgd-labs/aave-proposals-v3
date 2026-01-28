// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3PayloadOptimism} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadOptimism.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Enhancing Market Granularity in Aave v3.6
 * @author Chaos Labs (implemented by the ACI via Skyward)
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-enhancing-market-granularity-in-aave-v3-6-restricting-borrowability-and-collateralization-outside-of-liquid-emodes/23592
 */
contract AaveV3Optimism_EnhancingMarketGranularityInAaveV36_20260112 is AaveV3PayloadOptimism {
  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](5);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.LINK_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.USDC_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[2] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.AAVE_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[3] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.OP_UNDERLYING,
      ltv: 0,
      liqThreshold: EngineFlags.KEEP_CURRENT,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[4] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3OptimismAssets.rETH_UNDERLYING,
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
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](7);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3OptimismAssets.LINK_UNDERLYING,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });
    borrowUpdates[1] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3OptimismAssets.USDC_UNDERLYING,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });
    borrowUpdates[2] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3OptimismAssets.sUSD_UNDERLYING,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });
    borrowUpdates[3] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3OptimismAssets.OP_UNDERLYING,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });
    borrowUpdates[4] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3OptimismAssets.wstETH_UNDERLYING,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });
    borrowUpdates[5] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3OptimismAssets.LUSD_UNDERLYING,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });
    borrowUpdates[6] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3OptimismAssets.rETH_UNDERLYING,
      enabledToBorrow: EngineFlags.DISABLED,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });

    return borrowUpdates;
  }
}
