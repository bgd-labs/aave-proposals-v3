// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Chaos Labs V2 Ethereum and Polygon LT Reductions
 * @author Chaos Labs
 * - Snapshot: “Direct-to-AIP”
 * - Discussion: https://governance.aave.com/t/arfc-v2-ethereum-and-polygon-lt-reductions-12-04-2023/15747
 */
contract AaveV2Ethereum_ChaosLabsV2EthereumAndPolygonLTReductions_20231205 is
  AaveV2PayloadEthereum
{
  function _postExecute() internal override {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      0,
      2500,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CVX_UNDERLYING,
      0,
      100,
      10850
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      0,
      100,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENJ_UNDERLYING,
      0,
      100,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENS_UNDERLYING,
      0,
      3000,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      0,
      7500,
      10700
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MANA_UNDERLYING,
      0,
      100,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      0,
      2600,
      10750
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.REN_UNDERLYING,
      0,
      100,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.SNX_UNDERLYING,
      0,
      100,
      10750
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      0,
      4000,
      10900
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      0,
      100,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      0,
      1800,
      11000
    );
  }
}
