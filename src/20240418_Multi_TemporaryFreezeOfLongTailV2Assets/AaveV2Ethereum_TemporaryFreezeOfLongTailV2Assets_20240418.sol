// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Temporary Freeze of Long-Tail V2 Assets
 * @author Chaos Labs
 * - Discussion: https://governance.aave.com/t/arfc-temporary-freeze-of-long-tail-v2-assets/17403
 */
contract AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(AaveV2EthereumAssets.USDP_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(AaveV2EthereumAssets.GUSD_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(AaveV2EthereumAssets.LUSD_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(AaveV2EthereumAssets.FRAX_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(AaveV2EthereumAssets.sUSD_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(AaveV2EthereumAssets.AAVE_UNDERLYING);
  }
}
