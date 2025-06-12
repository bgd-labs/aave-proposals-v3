// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLidoEModes} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3PayloadEthereumLido} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Update Prime RsETH LST eMode on Aave V3 Ethereum Lido
 * @author ACI
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xd3e9abb877952861eb14a70a89fd01bdeccec1f6d159807acfaa514200831769
 * - Discussion: https://governance.aave.com/t/arfc-lrt-and-wsteth-unification/21739#p-55276-rseth-ltv-lt-update-4
 */
contract AaveV3EthereumLido_UpdatePrimeRsETHLSTEmode_20250602 is AaveV3PayloadEthereumLido {
  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3EthereumLidoEModes.RSETH_LST_MAIN,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: 1_00,
      label: EngineFlags.KEEP_CURRENT_STRING
    });

    return eModeUpdates;
  }
}
