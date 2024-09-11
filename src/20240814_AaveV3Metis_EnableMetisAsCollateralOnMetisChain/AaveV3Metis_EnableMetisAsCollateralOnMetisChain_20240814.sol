// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {AaveV3PayloadMetis} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMetis.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';

/**
 * @title Enable Metis as Collateral on Metis Chain
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x2e15c7011a6696de1be8fb3476db30395225eb533f849b63bdbff2b33a605ffd
 * - Discussion: https://governance.aave.com/t/arfc-enable-metis-as-collateral-on-metis-chain/16658
 */
contract AaveV3Metis_EnableMetisAsCollateralOnMetisChain_20240814 is AaveV3PayloadMetis {
  function _preExecute() internal override {
    AaveV3Metis.POOL_CONFIGURATOR.setDebtCeiling(AaveV3MetisAssets.Metis_UNDERLYING, 1_000_000_00);
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
      asset: AaveV3MetisAssets.Metis_UNDERLYING,
      ltv: 30_00,
      liqThreshold: 40_00,
      liqBonus: 10_00,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: 10_00
    });

    return collateralUpdate;
  }
}
