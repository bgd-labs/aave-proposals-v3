// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

/**
 * @title Enable SVR on Base and Arbitrum
 * @author BGD Labs @bgdlabs
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xc230fa0a74af2a064ca8c908d0edd61a23ad99dba6c73ec06dbd819fe766269a
 * - Discussion: https://governance.aave.com/t/arfc-aave-chainlink-svr-multi-network-expansion-base-arbitrum/24241
 */
contract AaveV3Ethereum_EnableSVROnBaseAndArbitrum_20260224 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Ethereum.ACL_MANAGER.removeAssetListingAdmin(AaveV3Ethereum.SVR_STEWARD);
    AaveV3EthereumLido.ACL_MANAGER.removeAssetListingAdmin(AaveV3EthereumLido.SVR_STEWARD);
  }
}
