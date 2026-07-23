// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Avalanche, AaveV4AvalancheHubs, AaveV4AvalancheAssets, AaveV4AvalancheSpokes} from 'aave-address-book/AaveV4Avalanche.sol';
import {AaveV4PayloadAvalanche} from 'aave-helpers/src/v4-config-engine/AaveV4PayloadAvalanche.sol';
import {IAaveV4ConfigEngine as IConfigEngine} from 'aave-address-book/AaveV4.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';

/**
 * @title Aave V4 Round 11 Cap Updates
 * @author LlamaRisk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/38?u=llamarisk
 */
contract AaveV4Avalanche_AaveV4Round11CapUpdates_20260723 is AaveV4PayloadAvalanche {
  function hubSpokeConfigUpdates()
    public
    pure
    override
    returns (IConfigEngine.SpokeConfigUpdate[] memory)
  {
    IConfigEngine.SpokeConfigUpdate[] memory items = new IConfigEngine.SpokeConfigUpdate[](2);
    items[0] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Avalanche.HUB_CONFIGURATOR,
      hub: address(AaveV4AvalancheHubs.CORE_HUB),
      underlying: AaveV4AvalancheAssets.USDC_UNDERLYING,
      spoke: address(AaveV4AvalancheSpokes.FOREX_SPOKE),
      addCap: 400_000,
      drawCap: 350_000,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[1] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Avalanche.HUB_CONFIGURATOR,
      hub: address(AaveV4AvalancheHubs.CORE_HUB),
      underlying: AaveV4AvalancheAssets.USDt_UNDERLYING,
      spoke: address(AaveV4AvalancheSpokes.FOREX_SPOKE),
      addCap: 400_000,
      drawCap: 350_000,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    return items;
  }
}
