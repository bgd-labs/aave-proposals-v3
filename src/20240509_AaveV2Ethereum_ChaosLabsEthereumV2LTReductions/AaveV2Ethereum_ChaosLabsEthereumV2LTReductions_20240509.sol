// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
/**
 * @title Chaos Labs Ethereum V2 LT Reductions
 * @author Chaos Labs
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-ethereum-v2-lt-reductions-05-06-2024/17598
 */
contract AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      0,
      65_00,
      107_00
    );

    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      0,
      1,
      110_00
    );
  }
}
