// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Payload, IAaveV4ConfigEngine} from 'aave-v4/config-engine/AaveV4Payload.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, ISpoke, IHub} from 'aave-address-book/AaveV4Ethereum.sol';

/**
 * @title Increase add and draw caps on Core and Prime Hubs
 * @author Llama Risk (implemented by Aave Labs)
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/38
 * - To be executed by the Aave Security Council
 */
contract AaveV4Ethereum_IncreaseCaps_20260723 is AaveV4Payload {
  constructor() AaveV4Payload(AaveV4Ethereum.CONFIG_ENGINE) {}

  // prettier-ignore
  function hubSpokeConfigUpdates()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.SpokeConfigUpdate[] memory)
  {
    uint256 KC = EngineFlags.KEEP_CURRENT;

    IHub CORE = AaveV4EthereumHubs.CORE_HUB;
    IHub PRIME = AaveV4EthereumHubs.PRIME_HUB;

    IAaveV4ConfigEngine.SpokeConfigUpdate[]
      memory updates = new IAaveV4ConfigEngine.SpokeConfigUpdate[](13);

    uint256 i = 0;

    // ========================
    // Core Hub
    // ========================
    //                             hub   spoke                                   asset                                       addCap      drawCap
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.ETHERFI_ESPOKE,    AaveV4EthereumAssets.WETH_UNDERLYING,       KC,         20_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.ETHERFI_ESPOKE,    AaveV4EthereumAssets.weETH_UNDERLYING,      28_000,     KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,        AaveV4EthereumAssets.USDG_UNDERLYING,       KC,         2_000_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,        AaveV4EthereumAssets.XAUt_UNDERLYING,       3_800,      KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,        AaveV4EthereumAssets.frxUSD_UNDERLYING,     KC,         2_000_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.LINK_UNDERLYING,       900_000,    KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.USDG_UNDERLYING,       65_000_000, 35_000_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.WBTC_UNDERLYING,       1_350,      120);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.WETH_UNDERLYING,       38_000,     3_300);

    // ========================
    // Prime Hub
    // ========================
    //                             hub    spoke                                  asset                                       addCap      drawCap
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,   AaveV4EthereumAssets.WBTC_UNDERLYING,       700,        KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,   AaveV4EthereumAssets.WETH_UNDERLYING,       8_000,      KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,   AaveV4EthereumAssets.cbBTC_UNDERLYING,      300,        KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,   AaveV4EthereumAssets.wstETH_UNDERLYING,     14_000,     KC);

    require(i == updates.length, 'Invalid number of updates');
    return updates;
  }

  function _capUpdate(
    IHub hub,
    ISpoke spoke,
    address underlying,
    uint256 addCap,
    uint256 drawCap
  ) internal pure returns (IAaveV4ConfigEngine.SpokeConfigUpdate memory) {
    return
      IAaveV4ConfigEngine.SpokeConfigUpdate({
        hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
        hub: address(hub),
        underlying: underlying,
        spoke: address(spoke),
        addCap: addCap,
        drawCap: drawCap,
        riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
        active: EngineFlags.KEEP_CURRENT,
        halted: EngineFlags.KEEP_CURRENT
      });
  }
}
