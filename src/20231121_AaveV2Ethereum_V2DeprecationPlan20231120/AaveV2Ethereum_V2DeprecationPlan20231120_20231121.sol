// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title  V2 Deprecation Plan, 2023.11.20
 * @author Gauntlet, Chaos Labs
 * - Snapshot: Direct to AIP
 * - Discussion: https://governance.aave.com/t/arfc-v2-ethereum-deprecation-11-20-2023/15628
 */
contract AaveV2Ethereum_V2DeprecationPlan20231120_20231121 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      0,
      100,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      0,
      3000,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CVX_UNDERLYING,
      0,
      2400,
      10850
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      0,
      500,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENJ_UNDERLYING,
      0,
      4400,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENS_UNDERLYING,
      0,
      3800,
      10800
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      0,
      8000,
      10700
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MANA_UNDERLYING,
      0,
      2900,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      0,
      2800,
      10750
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.REN_UNDERLYING,
      0,
      1800,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.SNX_UNDERLYING,
      0,
      3000,
      10750
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      0,
      5500,
      10900
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      0,
      3200,
      11000
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      0,
      2400,
      11000
    );
  }
}
