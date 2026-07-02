// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Payload, IAaveV4ConfigEngine} from 'aave-v4/config-engine/AaveV4Payload.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, ISpoke, IHub} from 'aave-address-book/AaveV4Ethereum.sol';

/**
 * @title Increase add and draw caps on Core, Prime and Plus hubs
 * @author Llama Risk (implemented by Aave Labs)
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/27
 * - To be executed by the Aave Security Council
 */
contract AaveV4Ethereum_IncreaseCaps_20260603 is AaveV4Payload {
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
    IHub PLUS = AaveV4EthereumHubs.PLUS_HUB;

    IAaveV4ConfigEngine.SpokeConfigUpdate[]
      memory updates = new IAaveV4ConfigEngine.SpokeConfigUpdate[](50);

    uint256 i = 0;

    // ========================
    // Core Hub
    // ========================
    //                         hub   spoke                                   asset                                   addCap      drawCap
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.ETHERFI_ESPOKE,    AaveV4EthereumAssets.weETH_UNDERLYING,  11_000,     KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.FOREX_SPOKE,        AaveV4EthereumAssets.EURC_UNDERLYING,   4_300_000,  4_500_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.FOREX_SPOKE,        AaveV4EthereumAssets.USDC_UNDERLYING,   10_000_000, 3_330_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.FOREX_SPOKE,        AaveV4EthereumAssets.USDT_UNDERLYING,   10_000_000, 3_330_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,         AaveV4EthereumAssets.EURC_UNDERLYING,   KC,         100_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,         AaveV4EthereumAssets.GHO_UNDERLYING,    KC,         125_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,         AaveV4EthereumAssets.RLUSD_UNDERLYING,  KC,         125_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,         AaveV4EthereumAssets.USDC_UNDERLYING,   KC,         500_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,         AaveV4EthereumAssets.USDG_UNDERLYING,   KC,         500_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,         AaveV4EthereumAssets.USDT_UNDERLYING,   KC,         800_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,         AaveV4EthereumAssets.XAUt_UNDERLYING,   1_000,      KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,         AaveV4EthereumAssets.frxUSD_UNDERLYING, KC,         500_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.LIDO_ESPOKE,       AaveV4EthereumAssets.wstETH_UNDERLYING, 5_900,      KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.LOMBARD_BTC_SPOKE,  AaveV4EthereumAssets.LBTC_UNDERLYING,   45,         KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.AAVE_UNDERLYING,   67_000,     KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.EURC_UNDERLYING,   4_300_000,  2_900_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.GHO_UNDERLYING,    10_000_000, 10_000_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.LINK_UNDERLYING,   610_000,    KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.RLUSD_UNDERLYING,  5_000_000,  3_400_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.USDC_UNDERLYING,   10_000_000, 10_000_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.USDG_UNDERLYING,   30_000_000, 20_400_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.USDT_UNDERLYING,   12_500_000, 12_500_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.WBTC_UNDERLYING,   240,        21);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.WETH_UNDERLYING,   24_000,     2_050);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.cbBTC_UNDERLYING,  115,        7);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.frxUSD_UNDERLYING, 30_000_000, 20_400_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.weETH_UNDERLYING,  1_500,      KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,         AaveV4EthereumAssets.wstETH_UNDERLYING, 4_400,      KC);

    // ========================
    // Prime Hub
    // ========================
    //                         hub    spoke                                  asset                                   addCap      drawCap
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.GHO_UNDERLYING,    7_500_000,  8_440_000);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.USDC_UNDERLYING,   12_500_000, 14_590_000);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.USDT_UNDERLYING,   12_500_000, 15_625_000);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.WBTC_UNDERLYING,   185,        KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.WETH_UNDERLYING,   3_200,      KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.cbBTC_UNDERLYING,  90,         KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.wstETH_UNDERLYING, 4_100,      KC);

    // ========================
    // Plus Hub
    // ========================
    //                         hub   spoke                                          asset                                          addCap     drawCap
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE, AaveV4EthereumAssets.PT_USDe_7MAY2026_UNDERLYING,  0,         KC);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE, AaveV4EthereumAssets.PT_sUSDE_7MAY2026_UNDERLYING, 0,         KC);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE, AaveV4EthereumAssets.USDe_UNDERLYING,              5_000_000, 5_200_000);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE, AaveV4EthereumAssets.sUSDe_UNDERLYING,             4_060_000, KC);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.GHO_UNDERLYING,               3_000_000, 3_450_000);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.PT_USDe_7MAY2026_UNDERLYING,  0,         KC);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.PT_sUSDE_7MAY2026_UNDERLYING, 0,         KC);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.USDC_UNDERLYING,              3_000_000, 3_750_000);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.USDT_UNDERLYING,              3_000_000, 3_750_000);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.USDe_UNDERLYING,              5_000_000, 4_800_000);
    updates[i++] = _capUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.sUSDe_UNDERLYING,             4_060_000, KC);

    // ========================
    // Credit Lines
    // ========================
    //                         hub   spoke                                  asset                                   addCap  drawCap
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.frxUSD_UNDERLYING, KC,     3_000_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.USDC_UNDERLYING,   KC,     2_000_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.USDT_UNDERLYING,   KC,     2_500_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.EURC_UNDERLYING,   KC,     300_000);

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
