// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumAssets, AaveV4EthereumSpokes} from 'aave-address-book/AaveV4Ethereum.sol';
import {AaveV4PayloadEthereum} from 'aave-helpers/src/v4-config-engine/AaveV4PayloadEthereum.sol';
import {IAaveV4ConfigEngine as IConfigEngine} from 'aave-address-book/AaveV4.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';

/**
 * @title Aave V4 Round 11 Cap Updates
 * @author LlamaRisk (implemented by Aave Labs)
 * - Snapshot: direct-to-aip
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/38
 */
contract AaveV4Ethereum_AaveV4Round11CapUpdates_20260723 is AaveV4PayloadEthereum {
  function hubSpokeConfigUpdates()
    public
    pure
    override
    returns (IConfigEngine.SpokeConfigUpdate[] memory)
  {
    IConfigEngine.SpokeConfigUpdate[] memory items = new IConfigEngine.SpokeConfigUpdate[](13);
    items[0] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.WETH_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.ETHERFI_ESPOKE),
      addCap: EngineFlags.KEEP_CURRENT,
      drawCap: 20_000,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[1] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.weETH_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.ETHERFI_ESPOKE),
      addCap: 28_000,
      drawCap: EngineFlags.KEEP_CURRENT,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[2] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.GOLD_SPOKE),
      addCap: EngineFlags.KEEP_CURRENT,
      drawCap: 2_000_000,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[3] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.XAUt_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.GOLD_SPOKE),
      addCap: 3_800,
      drawCap: EngineFlags.KEEP_CURRENT,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[4] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.frxUSD_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.GOLD_SPOKE),
      addCap: EngineFlags.KEEP_CURRENT,
      drawCap: 2_000_000,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[5] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.LINK_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.MAIN_SPOKE),
      addCap: 900_000,
      drawCap: EngineFlags.KEEP_CURRENT,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[6] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.USDG_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.MAIN_SPOKE),
      addCap: 65_000_000,
      drawCap: 35_000_000,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[7] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.WBTC_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.MAIN_SPOKE),
      addCap: 1_350,
      drawCap: 120,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[8] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.CORE_HUB),
      underlying: AaveV4EthereumAssets.WETH_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.MAIN_SPOKE),
      addCap: 38_000,
      drawCap: 3_300,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[9] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.PRIME_HUB),
      underlying: AaveV4EthereumAssets.WBTC_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),
      addCap: 700,
      drawCap: EngineFlags.KEEP_CURRENT,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[10] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.PRIME_HUB),
      underlying: AaveV4EthereumAssets.WETH_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),
      addCap: 8_000,
      drawCap: EngineFlags.KEEP_CURRENT,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[11] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.PRIME_HUB),
      underlying: AaveV4EthereumAssets.cbBTC_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),
      addCap: 300,
      drawCap: EngineFlags.KEEP_CURRENT,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    items[12] = IConfigEngine.SpokeConfigUpdate({
      hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
      hub: address(AaveV4EthereumHubs.PRIME_HUB),
      underlying: AaveV4EthereumAssets.wstETH_UNDERLYING,
      spoke: address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),
      addCap: 14_000,
      drawCap: EngineFlags.KEEP_CURRENT,
      riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
      active: EngineFlags.KEEP_CURRENT,
      halted: EngineFlags.KEEP_CURRENT
    });
    return items;
  }
}
