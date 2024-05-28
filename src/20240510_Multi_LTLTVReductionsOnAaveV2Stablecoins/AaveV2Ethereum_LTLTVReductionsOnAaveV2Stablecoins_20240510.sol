// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title LT/LTV Reductions on Aave V2 Stablecoins
 * @author ChaosLabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe3a29b7d6d936a22ee340811f842a29e4be654e08972f53f43dde7748c722195
 * - Discussion: https://governance.aave.com/t/arfc-lt-ltv-reductions-on-aave-v2-stablecoins/17508
 */
contract AaveV2Ethereum_LTLTVReductionsOnAaveV2Stablecoins_20240510 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      75_00,
      87_50,
      104_50
    );
  }
}
