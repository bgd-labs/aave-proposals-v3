// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IHub, ISpoke, ITokenizationSpoke} from 'aave-address-book/AaveV4.sol';
import {AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumTokenizationSpokes} from 'aave-address-book/AaveV4Ethereum.sol';

/// @dev Helper that returns all hubs as an array (address-book only exposes individual constants).
library AaveV4EthereumHubHelpers {
  function getHubs() internal pure returns (IHub[] memory) {
    IHub[] memory hubs = new IHub[](3);
    hubs[0] = AaveV4EthereumHubs.CORE_HUB;
    hubs[1] = AaveV4EthereumHubs.PLUS_HUB;
    hubs[2] = AaveV4EthereumHubs.PRIME_HUB;
    return hubs;
  }
}

/// @dev Helper that returns spoke arrays (address-book only exposes individual constants).
library AaveV4EthereumSpokeHelpers {
  function getUserSpokes() internal pure returns (ISpoke[] memory) {
    ISpoke[] memory spokes = new ISpoke[](10);
    spokes[0] = AaveV4EthereumSpokes.MAIN_SPOKE;
    spokes[1] = AaveV4EthereumSpokes.BLUECHIP_SPOKE;
    spokes[2] = AaveV4EthereumSpokes.ETHENA_CORRELATED_SPOKE;
    spokes[3] = AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE;
    spokes[4] = AaveV4EthereumSpokes.ETHERFI_E_SPOKE;
    spokes[5] = AaveV4EthereumSpokes.FOREX_SPOKE;
    spokes[6] = AaveV4EthereumSpokes.GOLD_SPOKE;
    spokes[7] = AaveV4EthereumSpokes.KELP_E_SPOKE;
    spokes[8] = AaveV4EthereumSpokes.LIDO_E_SPOKE;
    spokes[9] = AaveV4EthereumSpokes.LOMBARD_BTC_SPOKE;
    return spokes;
  }
}

/// @dev Helper that returns all tokenization spokes as an address array.
library AaveV4EthereumTokenizationSpokeHelpers {
  function getTokenizationSpokes() internal pure returns (address[] memory) {
    address[] memory spokes = new address[](31);
    // Core Hub
    spokes[0] = address(AaveV4EthereumTokenizationSpokes.CORE_WETH_TOKENIZATION_SPOKE);
    spokes[1] = address(AaveV4EthereumTokenizationSpokes.CORE_wstETH_TOKENIZATION_SPOKE);
    spokes[2] = address(AaveV4EthereumTokenizationSpokes.CORE_weETH_TOKENIZATION_SPOKE);
    spokes[3] = address(AaveV4EthereumTokenizationSpokes.CORE_rsETH_TOKENIZATION_SPOKE);
    spokes[4] = address(AaveV4EthereumTokenizationSpokes.CORE_WBTC_TOKENIZATION_SPOKE);
    spokes[5] = address(AaveV4EthereumTokenizationSpokes.CORE_cbBTC_TOKENIZATION_SPOKE);
    spokes[6] = address(AaveV4EthereumTokenizationSpokes.CORE_LBTC_TOKENIZATION_SPOKE);
    spokes[7] = address(AaveV4EthereumTokenizationSpokes.CORE_USDT_TOKENIZATION_SPOKE);
    spokes[8] = address(AaveV4EthereumTokenizationSpokes.CORE_USDC_TOKENIZATION_SPOKE);
    spokes[9] = address(AaveV4EthereumTokenizationSpokes.CORE_LINK_TOKENIZATION_SPOKE);
    spokes[10] = address(AaveV4EthereumTokenizationSpokes.CORE_AAVE_TOKENIZATION_SPOKE);
    spokes[11] = address(AaveV4EthereumTokenizationSpokes.CORE_GHO_TOKENIZATION_SPOKE);
    spokes[12] = address(AaveV4EthereumTokenizationSpokes.CORE_EURC_TOKENIZATION_SPOKE);
    spokes[13] = address(AaveV4EthereumTokenizationSpokes.CORE_RLUSD_TOKENIZATION_SPOKE);
    spokes[14] = address(AaveV4EthereumTokenizationSpokes.CORE_USDG_TOKENIZATION_SPOKE);
    spokes[15] = address(AaveV4EthereumTokenizationSpokes.CORE_frxUSD_TOKENIZATION_SPOKE);
    spokes[16] = address(AaveV4EthereumTokenizationSpokes.CORE_XAUt_TOKENIZATION_SPOKE);
    // Plus Hub
    spokes[17] = address(AaveV4EthereumTokenizationSpokes.PLUS_USDT_TOKENIZATION_SPOKE);
    spokes[18] = address(AaveV4EthereumTokenizationSpokes.PLUS_USDC_TOKENIZATION_SPOKE);
    spokes[19] = address(AaveV4EthereumTokenizationSpokes.PLUS_GHO_TOKENIZATION_SPOKE);
    spokes[20] = address(AaveV4EthereumTokenizationSpokes.PLUS_USDe_TOKENIZATION_SPOKE);
    spokes[21] = address(AaveV4EthereumTokenizationSpokes.PLUS_sUSDe_TOKENIZATION_SPOKE);
    spokes[22] = address(
      AaveV4EthereumTokenizationSpokes.PLUS_PT_sUSDE_7MAY2026_TOKENIZATION_SPOKE
    );
    spokes[23] = address(AaveV4EthereumTokenizationSpokes.PLUS_PT_USDe_7MAY2026_TOKENIZATION_SPOKE);
    // Prime Hub
    spokes[24] = address(AaveV4EthereumTokenizationSpokes.PRIME_WETH_TOKENIZATION_SPOKE);
    spokes[25] = address(AaveV4EthereumTokenizationSpokes.PRIME_wstETH_TOKENIZATION_SPOKE);
    spokes[26] = address(AaveV4EthereumTokenizationSpokes.PRIME_WBTC_TOKENIZATION_SPOKE);
    spokes[27] = address(AaveV4EthereumTokenizationSpokes.PRIME_cbBTC_TOKENIZATION_SPOKE);
    spokes[28] = address(AaveV4EthereumTokenizationSpokes.PRIME_USDT_TOKENIZATION_SPOKE);
    spokes[29] = address(AaveV4EthereumTokenizationSpokes.PRIME_USDC_TOKENIZATION_SPOKE);
    spokes[30] = address(AaveV4EthereumTokenizationSpokes.PRIME_GHO_TOKENIZATION_SPOKE);
    return spokes;
  }
}
