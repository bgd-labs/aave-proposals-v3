// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Payload, IAaveV4ConfigEngine} from 'aave-v4/config-engine/AaveV4Payload.sol';
import {EngineFlags} from 'aave-v4/config-engine/libraries/EngineFlags.sol';
import {AaveV4Ethereum, AaveV4EthereumHubs, AaveV4EthereumSpokes, AaveV4EthereumAssets, ISpoke, IHub} from 'aave-address-book/AaveV4Ethereum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ChainlinkEthereum} from 'aave-address-book/ChainlinkEthereum.sol';

/**
 * @title Migrate Aave V4 Ethereum reserves to SVR (Secure Value Recapture) Chainlink price feeds.
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/v4-technical-maintenance-updates/24915/2
 * - To be executed by the Aave Security Council
 */
contract AaveV4Ethereum_SVRfeeds_20260507 is AaveV4Payload {
  // ----------------------------------------------------------------
  // Uncapped SVR feeds
  // ----------------------------------------------------------------
  address public constant SVR_WETH = AaveV3EthereumAssets.WETH_ORACLE;
  address public constant SVR_cbBTC = AaveV3EthereumAssets.cbBTC_ORACLE;
  address public constant SVR_AAVE = AaveV3EthereumAssets.AAVE_ORACLE;
  address public constant SVR_LINK = AaveV3EthereumAssets.LINK_ORACLE;

  // ----------------------------------------------------------------
  // Capped SVR feeds
  // ----------------------------------------------------------------
  // Capped wstETH / stETH(ETH) / USD SVR
  address public constant SVR_wstETH = AaveV3EthereumAssets.wstETH_ORACLE;
  // Capped weETH / eETH(ETH) / USD SVR
  address public constant SVR_weETH = AaveV3EthereumAssets.weETH_ORACLE;
  // Capped rsETH / ETH / USD SVR
  address public constant SVR_rsETH = AaveV3EthereumAssets.rsETH_ORACLE;
  // Capped wBTC / BTC / USD SVR
  address public constant SVR_WBTC = AaveV3EthereumAssets.WBTC_ORACLE;
  // Capped LBTC / BTC / USD SVR
  address public constant SVR_LBTC = AaveV3EthereumAssets.LBTC_ORACLE;
  // Capped USDC / USD SVR
  address public constant SVR_USDC = AaveV3EthereumAssets.USDC_ORACLE;

  constructor() AaveV4Payload(AaveV4Ethereum.CONFIG_ENGINE) {}

  // prettier-ignore
  function spokeReserveConfigUpdates()
    public
    pure
    override
    returns (IAaveV4ConfigEngine.ReserveConfigUpdate[] memory)
  {
    IHub CORE = AaveV4EthereumHubs.CORE_HUB;
    IHub PRIME = AaveV4EthereumHubs.PRIME_HUB;
    IHub PLUS = AaveV4EthereumHubs.PLUS_HUB;

    IAaveV4ConfigEngine.ReserveConfigUpdate[]
      memory updates = new IAaveV4ConfigEngine.ReserveConfigUpdate[](27);

    uint256 i = 0;

    // ================================================================
    // Core Hub spokes
    // ================================================================
    //                        hub           spoke                                          asset                                svr feed
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.WETH_UNDERLYING,         SVR_WETH);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.wstETH_UNDERLYING,       SVR_wstETH);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.weETH_UNDERLYING,        SVR_weETH);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.WBTC_UNDERLYING,         SVR_WBTC);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.cbBTC_UNDERLYING,        SVR_cbBTC);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.AAVE_UNDERLYING,         SVR_AAVE);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.LINK_UNDERLYING,         SVR_LINK);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.MAIN_SPOKE,        AaveV4EthereumAssets.USDC_UNDERLYING,         SVR_USDC);

    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.ETHERFI_E_SPOKE,   AaveV4EthereumAssets.WETH_UNDERLYING,         SVR_WETH);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.ETHERFI_E_SPOKE,   AaveV4EthereumAssets.weETH_UNDERLYING,        SVR_weETH);

    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.LIDO_E_SPOKE,      AaveV4EthereumAssets.WETH_UNDERLYING,         SVR_WETH);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.LIDO_E_SPOKE,      AaveV4EthereumAssets.wstETH_UNDERLYING,       SVR_wstETH);

    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.KELP_E_SPOKE,      AaveV4EthereumAssets.WETH_UNDERLYING,         SVR_WETH);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.KELP_E_SPOKE,      AaveV4EthereumAssets.rsETH_UNDERLYING,        SVR_rsETH);

    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.LOMBARD_BTC_SPOKE, AaveV4EthereumAssets.WBTC_UNDERLYING,         SVR_WBTC);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.LOMBARD_BTC_SPOKE, AaveV4EthereumAssets.cbBTC_UNDERLYING,        SVR_cbBTC);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.LOMBARD_BTC_SPOKE, AaveV4EthereumAssets.LBTC_UNDERLYING,         SVR_LBTC);

    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.FOREX_SPOKE,       AaveV4EthereumAssets.USDC_UNDERLYING,         SVR_USDC);
    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.GOLD_SPOKE,        AaveV4EthereumAssets.USDC_UNDERLYING,         SVR_USDC);

    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.BLUECHIP_SPOKE,    AaveV4EthereumAssets.USDC_UNDERLYING,         SVR_USDC);

    updates[i++] = _priceUpdate(CORE, AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE, AaveV4EthereumAssets.USDC_UNDERLYING,    SVR_USDC);

    // ================================================================
    // Prime Hub spokes
    // ================================================================
    updates[i++] = _priceUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,   AaveV4EthereumAssets.WETH_UNDERLYING,         SVR_WETH);
    updates[i++] = _priceUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,   AaveV4EthereumAssets.wstETH_UNDERLYING,       SVR_wstETH);
    updates[i++] = _priceUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,   AaveV4EthereumAssets.WBTC_UNDERLYING,         SVR_WBTC);
    updates[i++] = _priceUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,   AaveV4EthereumAssets.cbBTC_UNDERLYING,        SVR_cbBTC);
    updates[i++] = _priceUpdate(PRIME, AaveV4EthereumSpokes.BLUECHIP_SPOKE,   AaveV4EthereumAssets.USDC_UNDERLYING,         SVR_USDC);

    // ================================================================
    // Plus Hub spokes
    // ================================================================
    updates[i++] = _priceUpdate(PLUS, AaveV4EthereumSpokes.ETHENA_ECOSYSTEM_SPOKE,  AaveV4EthereumAssets.USDC_UNDERLYING,    SVR_USDC);

    require(i == updates.length, 'Invalid number of updates');
    return updates;
  }

  function _priceUpdate(
    IHub hub,
    ISpoke spoke,
    address underlying,
    address newFeed
  ) internal pure returns (IAaveV4ConfigEngine.ReserveConfigUpdate memory) {
    uint256 KC = EngineFlags.KEEP_CURRENT;
    return
      IAaveV4ConfigEngine.ReserveConfigUpdate({
        spokeConfigurator: AaveV4Ethereum.SPOKE_CONFIGURATOR,
        spoke: address(spoke),
        hub: address(hub),
        underlying: underlying,
        priceSource: newFeed,
        collateralRisk: KC,
        paused: KC,
        frozen: KC,
        borrowable: KC,
        receiveSharesEnabled: KC
      });
  }
}
