// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {UmbrellaEthereum, UmbrellaEthereumAssets} from 'aave-address-book/UmbrellaEthereum.sol';

/**
 * @title Umbrella Pause
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-pause-stkwaweth-umbrella-staked-token-on-ethereum-v3/24595
 */
contract AaveV3Ethereum_UmbrellaPause_20260420 is IProposalGenericExecutor {
  function execute() external override {
    UmbrellaEthereum.UMBRELLA.pauseStk(UmbrellaEthereumAssets.STK_WA_WETH_V1);
  }
}
