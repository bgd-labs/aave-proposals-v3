// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Payload, IAaveV4ConfigEngine} from 'aave-v4/config-engine/AaveV4Payload.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets} from 'aave-address-book/AaveV4Ethereum.sol';

/**
 * @title Increase add and draw caps across all three hubs (Core, Prime and Plus)
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/19
 * - To be executed by the Aave Security Council
 */
contract AaveV4Ethereum_IncreaseCaps_20260415 is AaveV4Payload {
  constructor() AaveV4Payload(AaveV4Ethereum.CONFIG_ENGINE) {}

  // prettier-ignore
  function hubSpokeConfigUpdates()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.SpokeConfigUpdate[] memory)
  {
    uint256 KC = EngineFlags.KEEP_CURRENT;

    address CORE = address(AaveV4EthereumHubs.CORE_HUB);
    address PRIME = address(AaveV4EthereumHubs.PRIME_HUB);
    address PLUS = address(AaveV4EthereumHubs.PLUS_HUB);

    IAaveV4ConfigEngine.SpokeConfigUpdate[]
      memory updates = new IAaveV4ConfigEngine.SpokeConfigUpdate[](40);

    uint256 i = 0;

    // ========================
    // Core Hub
    // ========================
    //                         hub  spoke                                          asset                                                    addCap     drawCap
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,                    KC,        2_500);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.ETHERFI_E_SPOKE), AaveV4EthereumAssets.weETH_UNDERLYING,                   2_500,     KC);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.FOREX_SPOKE),     AaveV4EthereumAssets.USDC_UNDERLYING,                    400_000,   135_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.FOREX_SPOKE),     AaveV4EthereumAssets.USDT_UNDERLYING,                    400_000,   135_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.GOLD_SPOKE),      AaveV4EthereumAssets.XAUt_UNDERLYING,                    250,       KC);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.KELP_E_SPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,                    KC,        2_500);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.KELP_E_SPOKE),    AaveV4EthereumAssets.rsETH_UNDERLYING,                   2_500,     KC);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.WETH_UNDERLYING,                    KC,        2_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.LIDO_E_SPOKE),    AaveV4EthereumAssets.wstETH_UNDERLYING,                  2_000,     KC);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.AAVE_UNDERLYING,                    12_000,    KC);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.GHO_UNDERLYING,                     1_500_000, 1_500_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.LINK_UNDERLYING,                    75_000,    KC);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDC_UNDERLYING,                    6_000_000, 6_000_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDG_UNDERLYING,                    2_000_000, 1_350_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.USDT_UNDERLYING,                    4_000_000, 4_000_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WBTC_UNDERLYING,                    40,        5);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.WETH_UNDERLYING,                    5_500,     475);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.cbBTC_UNDERLYING,                   20,        3);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.frxUSD_UNDERLYING,                  2_500_000, 1_700_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.weETH_UNDERLYING,                   200,       KC);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.MAIN_SPOKE),      AaveV4EthereumAssets.wstETH_UNDERLYING,                  650,       KC);

    // ========================
    // Prime Hub
    // ========================
    //                        hub    spoke                                         asset                                                    addCap     drawCap
    updates[i++] = _capUpdate(PRIME, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,                     3_000_000, 3_375_000);
    updates[i++] = _capUpdate(PRIME, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,                    1_500_000, 1_750_000);
    updates[i++] = _capUpdate(PRIME, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                    1_500_000, 1_880_000);
    updates[i++] = _capUpdate(PRIME, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WBTC_UNDERLYING,                    30,        KC);
    updates[i++] = _capUpdate(PRIME, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.WETH_UNDERLYING,                    500,       KC);
    updates[i++] = _capUpdate(PRIME, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.cbBTC_UNDERLYING,                   25,        KC);
    updates[i++] = _capUpdate(PRIME, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE), AaveV4EthereumAssets.wstETH_UNDERLYING,                  600,       KC);

    // ========================
    // Plus Hub
    // ========================
    //                        hub   spoke                                                 asset                                                       addCap     drawCap
    updates[i++] = _capUpdate(PLUS, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.GHO_UNDERLYING,                        1_000_000, 1_150_000);
    updates[i++] = _capUpdate(PLUS, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,                       500_000,   625_000);
    updates[i++] = _capUpdate(PLUS, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                       500_000,   625_000);
    updates[i++] = _capUpdate(PLUS, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDe_UNDERLYING,                       1_000_000, 960_000);
    updates[i++] = _capUpdate(PLUS, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.sUSDe_UNDERLYING,                      1_000_000, KC);

    // ========================
    // Credit Lines
    // ========================
    //                        hub   spoke                                                 asset                                                        addCap  drawCap
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDC_UNDERLYING,                        KC,     375_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.USDT_UNDERLYING,                        KC,     375_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE), AaveV4EthereumAssets.frxUSD_UNDERLYING,                      KC,     200_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.USDC_UNDERLYING,                        KC,     375_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.USDT_UNDERLYING,                        KC,     375_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.frxUSD_UNDERLYING,                      KC,     200_000);
    updates[i++] = _capUpdate(CORE, address(AaveV4EthereumSpokes.BLUECHIP_SPOKE),         AaveV4EthereumAssets.EURC_UNDERLYING,                        KC,     150_000);

    require(i == updates.length, 'Invalid number of updates');
    return updates;
  }

  function _capUpdate(
    address hub,
    address spoke,
    address underlying,
    uint256 addCap,
    uint256 drawCap
  ) internal pure returns (IAaveV4ConfigEngine.SpokeConfigUpdate memory) {
    return
      IAaveV4ConfigEngine.SpokeConfigUpdate({
        hubConfigurator: AaveV4Ethereum.HUB_CONFIGURATOR,
        hub: hub,
        underlying: underlying,
        spoke: spoke,
        addCap: addCap,
        drawCap: drawCap,
        riskPremiumThreshold: EngineFlags.KEEP_CURRENT,
        active: EngineFlags.KEEP_CURRENT,
        halted: EngineFlags.KEEP_CURRENT
      });
  }
}
