// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Arbitrum eMode Update - rsETH and ezETH
 * @author @TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-arbitrum-emode-update-rseth-and-ezeth/22731/3
 */
contract AaveV3Ethereum_ArbitrumEModeUpdateRsETHAndEzETH_20250805 is AaveV3PayloadEthereum {
  function eModeCategoryCreations()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryCreation[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryCreation[]
      memory eModeCreations = new IAaveV3ConfigEngine.EModeCategoryCreation[](1);

    address[] memory collateralAssets_WeETHWstETH = new address[](1);
    address[] memory borrowableAssets_WeETHWstETH = new address[](1);

    collateralAssets_WeETHWstETH[0] = AaveV3EthereumAssets.weETH_UNDERLYING;
    borrowableAssets_WeETHWstETH[0] = AaveV3EthereumAssets.wstETH_UNDERLYING;

    eModeCreations[0] = IAaveV3ConfigEngine.EModeCategoryCreation({
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: 'weETH/wstETH',
      collaterals: collateralAssets_WeETHWstETH,
      borrowables: borrowableAssets_WeETHWstETH
    });

    return eModeCreations;
  }
}
