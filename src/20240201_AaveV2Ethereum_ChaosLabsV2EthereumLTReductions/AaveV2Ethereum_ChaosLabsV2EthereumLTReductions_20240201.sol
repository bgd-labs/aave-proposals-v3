// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Chaos Labs V2 Ethereum LT Reductions
 * @author Chaos Labs - Eyal Ovadya
 * - Snapshot: No snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-01-30-2024/16468
 */
contract AaveV2Ethereum_ChaosLabsV2EthereumLTReductions_20240201 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      0,
      14_00,
      108_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ENS_UNDERLYING,
      0,
      5,
      108_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      0,
      72_00,
      107_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      0,
      14_00,
      107_50
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      0,
      14_00,
      109_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      0,
      8_00,
      110_00
    );
  }
}
