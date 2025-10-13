// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBase.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Addition of cbBTC/Stablecoin E-Mode to Aave V3 Base Instance
 * @author Aave-chan Initiative
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-addition-of-cbbtc-stablecoin-e-mode-to-aave-v3-base-instance/23174
 */
contract AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007 is
  AaveV3PayloadBase
{
  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_CbBTCStablecoins = new address[](1);
    address[] memory borrowableAssets_CbBTCStablecoins = new address[](2);

    collateralAssets_CbBTCStablecoins[0] = AaveV3BaseAssets.cbBTC_UNDERLYING;
    borrowableAssets_CbBTCStablecoins[0] = AaveV3BaseAssets.USDC_UNDERLYING;
    borrowableAssets_CbBTCStablecoins[1] = AaveV3BaseAssets.GHO_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 80_00,
      liqThreshold: 83_00,
      liqBonus: 4_00,
      label: 'cbBTC Stablecoins',
      collaterals: collateralAssets_CbBTCStablecoins,
      borrowables: borrowableAssets_CbBTCStablecoins
    });

    return eModeCreations;
  }
}
