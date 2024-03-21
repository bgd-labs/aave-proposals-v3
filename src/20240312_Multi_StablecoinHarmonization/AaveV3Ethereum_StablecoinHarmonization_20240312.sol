// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/v3-config-engine/AaveV3PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title stablecoin harmonization
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x22407c9362bc3294e3ddd5428fdd5c08312459595573a864ec8ebac61ad95b94
 * - Discussion: https://governance.aave.com/t/arfc-stablecoin-harmonization-and-asset-parameters-optimization/16802
 */
contract AaveV3Ethereum_StablecoinHarmonization_20240312 is AaveV3PayloadEthereum {
  function _postExecute() internal override {
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveFreeze(AaveV3EthereumAssets.STG_UNDERLYING, true);
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveFreeze(AaveV3EthereumAssets.KNC_UNDERLYING, true);
    AaveV3Ethereum.POOL_CONFIGURATOR.setReserveFreeze(AaveV3EthereumAssets.FXS_UNDERLYING, true);
  }

  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](7);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.LUSD_UNDERLYING,
      ltv: 0,
      liqThreshold: 77_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[1] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.BAL_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 59_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[2] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.UNI_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 74_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[3] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.FRAX_UNDERLYING,
      ltv: 0,
      liqThreshold: 72_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[4] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.STG_UNDERLYING,
      ltv: 0,
      liqThreshold: 37_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[5] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.KNC_UNDERLYING,
      ltv: 0,
      liqThreshold: 37_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });
    collateralUpdate[6] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3EthereumAssets.FXS_UNDERLYING,
      ltv: 0,
      liqThreshold: 42_00,
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
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](3);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3EthereumAssets.DAI_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 25_00
    });
    borrowUpdates[1] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3EthereumAssets.LUSD_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 20_00
    });
    borrowUpdates[2] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3EthereumAssets.FRAX_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      stableRateModeEnabled: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.KEEP_CURRENT,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: 20_00
    });

    return borrowUpdates;
  }
}
