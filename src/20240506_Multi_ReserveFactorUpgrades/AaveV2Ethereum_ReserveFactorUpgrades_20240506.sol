// SPDX-License-Identifier: MIT
/*
   _      ΞΞΞΞ      _
  /_;-.__ / _\  _.-;_\
     `-._`'`_/'`.-'
         `\   /`
          |  /
         /-.(
         \_._\
          \ \`;
           > |/
          / //
          |//
          \(\
           ``
     defijesus.eth
*/
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Reserve Factor Upgrades
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab
 * - Discussion: https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040/4
 */
contract AaveV2Ethereum_ReserveFactorUpgrades_20240506 is IProposalGenericExecutor {
  ILendingPoolConfigurator public constant POOL_CONFIGURATOR =
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR);

  uint256 public constant DAI_RF = 50_00;
  uint256 public constant FRAX_RF = 55_00;
  uint256 public constant GUSD_RF = 45_00;
  uint256 public constant LINK_RF = 55_00;
  uint256 public constant LUSD_RF = 50_00;
  uint256 public constant sUSD_RF = 55_00;
  uint256 public constant USDC_RF = 50_00;
  uint256 public constant USDP_RF = 45_00;
  uint256 public constant USDT_RF = 50_00;
  uint256 public constant WBTC_RF = 55_00;
  uint256 public constant WETH_RF = 50_00;

  function execute() external {
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.DAI_UNDERLYING, DAI_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.FRAX_UNDERLYING, FRAX_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.GUSD_UNDERLYING, GUSD_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.LINK_UNDERLYING, LINK_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.LUSD_UNDERLYING, LUSD_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.sUSD_UNDERLYING, sUSD_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.USDC_UNDERLYING, USDC_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.USDP_UNDERLYING, USDP_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.USDT_UNDERLYING, USDT_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.WBTC_UNDERLYING, WBTC_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.WETH_UNDERLYING, WETH_RF);
  }
}
