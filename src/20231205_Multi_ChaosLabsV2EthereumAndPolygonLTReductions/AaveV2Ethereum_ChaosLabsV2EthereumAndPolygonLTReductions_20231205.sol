// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Chaos Labs V2 Ethereum and Polygon LT Reductions
 * @author Chaos Labs
 * - Snapshot: “Direct-to-AIP”
 * - Discussion: https://governance.aave.com/t/arfc-v2-ethereum-and-polygon-lt-reductions-12-04-2023/15747
 */
contract AaveV2Ethereum_ChaosLabsV2EthereumAndPolygonLTReductions_20231205 is
  IProposalGenericExecutor
{
  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      0,
      25_00,
      108_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CVX_UNDERLYING,
      0,
      5,
      108_50
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      0,
      5,
      110_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENJ_UNDERLYING,
      0,
      5,
      110_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENS_UNDERLYING,
      0,
      30_00,
      108_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      0,
      75_00,
      107_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MANA_UNDERLYING,
      0,
      5,
      110_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      0,
      26_00,
      107_50
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.REN_UNDERLYING,
      0,
      5,
      110_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.SNX_UNDERLYING,
      0,
      5,
      107_50
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      0,
      40_00,
      109_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      0,
      5,
      110_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      0,
      18_00,
      110_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ONE_INCH_UNDERLYING,
      0,
      5,
      108_50
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      0,
      5,
      108_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.BAT_UNDERLYING,
      0,
      5,
      110_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.KNC_UNDERLYING,
      0,
      5,
      110_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.FEI_UNDERLYING,
      0,
      5,
      110_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      0,
      5,
      110_00
    );
  }
}
