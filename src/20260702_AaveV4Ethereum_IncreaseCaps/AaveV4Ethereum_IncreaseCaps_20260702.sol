// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Payload, IAaveV4ConfigEngine} from 'aave-v4/config-engine/AaveV4Payload.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, ISpoke, IHub} from 'aave-address-book/AaveV4Ethereum.sol';

/**
 * @title Increase add and draw caps on Core, Plus, Prime and Global Dollar Hubs
 * @author Llama Risk (implemented by Aave Labs)
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/34
 * - To be executed by the Aave Security Council
 */
contract AaveV4Ethereum_IncreaseCaps_20260702 is AaveV4Payload {
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
    IHub PLUS = AaveV4EthereumHubs.PLUS_HUB;
    IHub PRIME = AaveV4EthereumHubs.PRIME_HUB;
    IHub PAXOS = AaveV4EthereumHubs.PAXOS_HUB;

    IAaveV4ConfigEngine.SpokeConfigUpdate[]
      memory updates = new IAaveV4ConfigEngine.SpokeConfigUpdate[](23);

    uint256 i = 0;

    // ========================
    // Core Hub
    // ========================
    //                         hub    spoke                                        asset                                        addCap      drawCap
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.ETHERFI_ESPOKE,          AaveV4EthereumAssets.weETH_UNDERLYING,       18_000,     KC);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.FOREX_SPOKE,             AaveV4EthereumAssets.frxUSD_UNDERLYING,      KC,         1_000_000);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.GOLD_SPOKE,              AaveV4EthereumAssets.XAUt_UNDERLYING,        2_500,      KC);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.MAIN_SPOKE,              AaveV4EthereumAssets.LINK_UNDERLYING,        750_000,    KC);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.MAIN_SPOKE,              AaveV4EthereumAssets.USDG_UNDERLYING,        50_000_000, KC);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.MAIN_SPOKE,              AaveV4EthereumAssets.WBTC_UNDERLYING,        1_150,      100);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.MAIN_SPOKE,              AaveV4EthereumAssets.cbBTC_UNDERLYING,       220,        14);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.MAIN_SPOKE,              AaveV4EthereumAssets.frxUSD_UNDERLYING,      50_000_000, 34_000_000);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.MAIN_SPOKE,              AaveV4EthereumAssets.weETH_UNDERLYING,       4_000,      KC);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.MAIN_SPOKE,              AaveV4EthereumAssets.wstETH_UNDERLYING,      10_000,     KC);

    // ========================
    // Plus Hub
    // ========================
    //                         hub    spoke                                        asset                                        addCap      drawCap
    updates[i++] = _capUpdate(PLUS,  AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.USDC_UNDERLYING,        6_000_000,  6_375_000);
    updates[i++] = _capUpdate(PLUS,  AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.USDT_UNDERLYING,        6_000_000,  6_375_000);
    updates[i++] = _capUpdate(PLUS,  AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.sUSDe_UNDERLYING,       6_000_000,  KC);
    updates[i++] = _capUpdate(PLUS,  AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE, AaveV4EthereumAssets.USDe_UNDERLYING,        5_200_000,  KC);
    updates[i++] = _capUpdate(PLUS,  AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.GHO_UNDERLYING,         3_450_000,  KC);

    // ========================
    // Prime Hub
    // ========================
    //                         hub    spoke                                        asset                                        addCap      drawCap
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,          AaveV4EthereumAssets.wstETH_UNDERLYING,      7_000,      KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,          AaveV4EthereumAssets.USDC_UNDERLYING,        12_590_000, KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,          AaveV4EthereumAssets.USDT_UNDERLYING,        13_125_000, KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,          AaveV4EthereumAssets.GHO_UNDERLYING,         8_440_000,  KC);

    // ========================
    // Global Dollar Hub
    // ========================
    //                         hub    spoke                                        asset                                        addCap      drawCap
    updates[i++] = _capUpdate(PAXOS, AaveV4EthereumSpokes.USDG_PENDLE_SPOKE,       AaveV4EthereumAssets.PT_USDG_24SEP2026_UNDERLYING, 30_000_000, KC);

    // ========================
    // Credit Lines (cross-hub draws from Core)
    // ========================
    //                         hub    spoke                                        asset                                        addCap      drawCap
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.BLUECHIP_SPOKE,          AaveV4EthereumAssets.frxUSD_UNDERLYING,      KC,         5_000_000);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.frxUSD_UNDERLYING,      KC,         500_000);
    updates[i++] = _capUpdate(CORE,  AaveV4EthereumSpokes.USDG_PENDLE_SPOKE,       AaveV4EthereumAssets.USDG_UNDERLYING,        KC,         15_000_000);

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
