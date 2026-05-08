// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Payload, IAaveV4ConfigEngine} from 'aave-v4/config-engine/AaveV4Payload.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, ISpoke, IHub} from 'aave-address-book/AaveV4Ethereum.sol';

/**
 * @title Increase add and draw caps on Core and Prime hubs
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/21
 * - To be executed by the Aave Security Council
 */
contract AaveV4Ethereum_IncreaseCaps_20260504 is AaveV4Payload {
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
      memory updates = new IAaveV4ConfigEngine.SpokeConfigUpdate[](23);

    uint256 i = 0;

    // ========================
    // Core Hub
    // ========================
    //                         hub  spoke                                          asset                                                    addCap     drawCap
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.ETHERFI_E_SPOKE, AaveV4EthereumAssets.WETH_UNDERLYING,                    KC,        6_500);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.ETHERFI_E_SPOKE, AaveV4EthereumAssets.weETH_UNDERLYING,                   6_500,     KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.LIDO_E_SPOKE,    AaveV4EthereumAssets.WETH_UNDERLYING,                    KC,        4_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.LIDO_E_SPOKE,    AaveV4EthereumAssets.wstETH_UNDERLYING,                  4_000,     KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,      AaveV4EthereumAssets.LINK_UNDERLYING,                    185_000,   KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,      AaveV4EthereumAssets.USDG_UNDERLYING,                    3_500_000, 2_360_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,      AaveV4EthereumAssets.USDT_UNDERLYING,                    7_000_000, 7_000_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,      AaveV4EthereumAssets.WBTC_UNDERLYING,                    110,       9);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,      AaveV4EthereumAssets.WETH_UNDERLYING,                    14_500,    1_250);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,      AaveV4EthereumAssets.cbBTC_UNDERLYING,                   50,        KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,      AaveV4EthereumAssets.frxUSD_UNDERLYING,                  4_500_000, 3_060_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,      AaveV4EthereumAssets.weETH_UNDERLYING,                   800,       KC);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,      AaveV4EthereumAssets.wstETH_UNDERLYING,                  2_150,     KC);

    // ========================
    // Prime Hub
    // ========================
    //                        hub    spoke                                         asset                                                    addCap     drawCap
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE, AaveV4EthereumAssets.USDC_UNDERLYING,                    2_500_000, 2_910_000);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE, AaveV4EthereumAssets.USDT_UNDERLYING,                    2_500_000, 3_130_000);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE, AaveV4EthereumAssets.WBTC_UNDERLYING,                    90,        KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE, AaveV4EthereumAssets.WETH_UNDERLYING,                    1_700,     KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE, AaveV4EthereumAssets.cbBTC_UNDERLYING,                   45,        KC);
    updates[i++] = _capUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE, AaveV4EthereumAssets.wstETH_UNDERLYING,                  1_800,     KC);

    // ========================
    // Credit Lines
    // ========================
    //                        hub   spoke                                                 asset                                                        addCap  drawCap
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.BLUECHIP_SPOKE,         AaveV4EthereumAssets.USDT_UNDERLYING,                        KC,     625_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.BLUECHIP_SPOKE,         AaveV4EthereumAssets.frxUSD_UNDERLYING,                      KC,     300_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,             AaveV4EthereumAssets.USDT_UNDERLYING,                        KC,     200_000);
    updates[i++] = _capUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,             AaveV4EthereumAssets.frxUSD_UNDERLYING,                      KC,     100_000);

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
