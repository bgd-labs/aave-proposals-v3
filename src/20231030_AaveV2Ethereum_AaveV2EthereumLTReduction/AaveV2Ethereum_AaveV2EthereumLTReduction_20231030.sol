// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEngine, EngineFlags, AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Aave V2 Ethereum LT Reduction
 * @author Chaos Labs
 * - Snapshot: Direct to AIP
 * - Discussion: https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-10-27-2023/15249
 */
contract AaveV2Ethereum_AaveV2EthereumLTReduction_20231030 is AaveV2PayloadEthereum {
  function _postExecute() internal override {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ONE_INCH_UNDERLYING,
      0,
      100,
      10850
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      0,
      2100,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      0,
      3800,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CVX_UNDERLYING,
      0,
      3000,
      10850
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      0,
      1400,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENS_UNDERLYING,
      0,
      4700,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MANA_UNDERLYING,
      0,
      3700,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      0,
      3000,
      10750
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.REN_UNDERLYING,
      0,
      2500,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.SNX_UNDERLYING,
      0,
      4100,
      10750
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      0,
      6400,
      10900
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      0,
      100,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      0,
      4300,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      0,
      3400,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      0,
      8100,
      10700
    );
  }
}
