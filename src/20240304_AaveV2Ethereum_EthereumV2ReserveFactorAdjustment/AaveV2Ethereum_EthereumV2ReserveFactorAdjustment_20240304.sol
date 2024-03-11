// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Ethereum v2 Reserve Factor Adjustment
 * @author Karpatkey, TokenLogic, ChaosLabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x26a03c08359c340f63b78b0c3e96d37aa0adeda65814643b0886d4719048ea7e
 * - Discussion: https://governance.aave.com/t/arfc-ethereum-v2-reserve-factor-adjustment/16764
 */
contract AaveV2Ethereum_EthereumV2ReserveFactorAdjustment_20240304 is IProposalGenericExecutor {
  ILendingPoolConfigurator public constant POOL_CONFIGURATOR =
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR);

  uint256 public constant ONE_INCH_RF = 99_99;
  uint256 public constant AMPL_RF = 99_99;
  uint256 public constant BUSD_RF = 99_99;
  uint256 public constant BAL_RF = 99_99;
  uint256 public constant BAT_RF = 99_99;
  uint256 public constant CRV_RF = 99_99;
  uint256 public constant CVX_RF = 99_99;
  uint256 public constant DAI_RF = 30_00;
  uint256 public constant DPI_RF = 99_99;
  uint256 public constant ENS_RF = 99_99;
  uint256 public constant ENJ_RF = 99_99;
  uint256 public constant FEI_RF = 99_99;
  uint256 public constant FRAX_RF = 35_00;
  uint256 public constant GUSD_RF = 25_00;
  uint256 public constant KNC_RF = 99_99;
  uint256 public constant LINK_RF = 35_00;
  uint256 public constant LUSD_RF = 30_00;
  uint256 public constant MANA_RF = 99_99;
  uint256 public constant MKR_RF = 99_99;
  uint256 public constant RAI_RF = 99_99;
  uint256 public constant REN_RF = 99_99;
  uint256 public constant SNX_RF = 99_99;
  uint256 public constant sUSD_RF = 35_00;
  uint256 public constant xSUSHI_RF = 99_99;
  uint256 public constant TUSD_RF = 99_99;
  uint256 public constant UNI_RF = 99_99;
  uint256 public constant USDC_RF = 30_00;
  uint256 public constant USDP_RF = 25_00;
  uint256 public constant USDT_RF = 30_00;
  uint256 public constant UST_RF = 99_99;
  uint256 public constant WBTC_RF = 35_00;
  uint256 public constant WETH_RF = 30_00;
  uint256 public constant YFI_RF = 99_99;
  uint256 public constant ZRX_RF = 99_99;

  function execute() external {
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.ONE_INCH_UNDERLYING, ONE_INCH_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.AMPL_UNDERLYING, AMPL_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.BUSD_UNDERLYING, BUSD_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.BAL_UNDERLYING, BAL_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.BAT_UNDERLYING, BAT_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.CRV_UNDERLYING, CRV_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.CVX_UNDERLYING, CVX_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.DAI_UNDERLYING, DAI_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.DPI_UNDERLYING, DPI_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.ENS_UNDERLYING, ENS_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.ENJ_UNDERLYING, ENJ_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.FEI_UNDERLYING, FEI_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.FRAX_UNDERLYING, FRAX_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.GUSD_UNDERLYING, GUSD_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.KNC_UNDERLYING, KNC_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.LINK_UNDERLYING, LINK_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.LUSD_UNDERLYING, LUSD_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.MANA_UNDERLYING, MANA_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.MKR_UNDERLYING, MKR_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.RAI_UNDERLYING, RAI_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.REN_UNDERLYING, REN_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.SNX_UNDERLYING, SNX_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.sUSD_UNDERLYING, sUSD_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.xSUSHI_UNDERLYING, xSUSHI_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.TUSD_UNDERLYING, TUSD_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.UNI_UNDERLYING, UNI_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.USDC_UNDERLYING, USDC_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.USDP_UNDERLYING, USDP_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.USDT_UNDERLYING, USDT_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.UST_UNDERLYING, UST_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.WBTC_UNDERLYING, WBTC_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.WETH_UNDERLYING, WETH_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.YFI_UNDERLYING, YFI_RF);
    POOL_CONFIGURATOR.setReserveFactor(AaveV2EthereumAssets.ZRX_UNDERLYING, ZRX_RF);
  }
}
