// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3PayloadInkWhitelabel} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadInkWhitelabel.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Post Activation Risk Update
 * @author BGD Labs (@bgdlabs)
 */
contract AaveV3InkWhitelabel_PostActivationRiskUpdate_20251013 is AaveV3PayloadInkWhitelabel {
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](4);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.WETH_UNDERLYING,
      supplyCap: 40_000,
      borrowCap: 10_000
    });
    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.kBTC_UNDERLYING,
      supplyCap: 1_500,
      borrowCap: 200
    });
    capsUpdate[2] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.USDT_UNDERLYING,
      supplyCap: 250_000_000,
      borrowCap: 220_000_000
    });
    capsUpdate[3] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.USDG_UNDERLYING,
      supplyCap: 50_000_000,
      borrowCap: 40_000_000
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
      memory collateralUpdate = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    collateralUpdate[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3InkWhitelabelAssets.USDT_UNDERLYING,
      ltv: 75_00,
      liqThreshold: 78_00,
      liqBonus: 4_50,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: 10_00
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
      memory borrowUpdates = new IAaveV3ConfigEngine.BorrowUpdate[](2);

    borrowUpdates[0] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3InkWhitelabelAssets.USDT_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });
    borrowUpdates[1] = IAaveV3ConfigEngine.BorrowUpdate({
      asset: AaveV3InkWhitelabelAssets.USDG_UNDERLYING,
      enabledToBorrow: EngineFlags.KEEP_CURRENT,
      flashloanable: EngineFlags.KEEP_CURRENT,
      borrowableInIsolation: EngineFlags.ENABLED,
      withSiloedBorrowing: EngineFlags.KEEP_CURRENT,
      reserveFactor: EngineFlags.KEEP_CURRENT
    });

    return borrowUpdates;
  }
}
