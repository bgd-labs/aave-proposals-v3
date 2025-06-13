// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {GHOAvalancheLaunch} from './utils/GHOAvalancheLaunch.sol';

/**
 * @title GHO Avalanche Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-avalanche-set-aci-as-emissions-manager-for-rewards
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2aed7eb8b03cb3f961cbf790bf2e2e1e449f841a4ad8bdbcdd223bb6ac69e719
 */
contract AaveV3Ethereum_GHOAvalancheLaunch_20250519 is IProposalGenericExecutor {
  uint64 public constant AVAX_CHAIN_SELECTOR = GHOAvalancheLaunch.AVAX_CHAIN_SELECTOR;

  IUpgradeableBurnMintTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(GhoEthereum.GHO_CCIP_TOKEN_POOL);

  address public constant REMOTE_TOKEN_POOL_AVAX = GHOAvalancheLaunch.GHO_CCIP_TOKEN_POOL;
  address public constant REMOTE_GHO_TOKEN_AVAX = GHOAvalancheLaunch.GHO_TOKEN;

  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOAvalancheLaunch.CCIP_RATE_LIMIT_CAPACITY;
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOAvalancheLaunch.CCIP_RATE_LIMIT_REFILL_RATE;

  function execute() external {
    IRateLimiter.Config memory rateLimiterConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
    });

    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chainsToAdd = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](1);
    uint64[] memory chainsToRemove = new uint64[](0);

    bytes[] memory remotePoolAddresses = new bytes[](1);
    remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_AVAX);

    chainsToAdd[0] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
      remoteChainSelector: AVAX_CHAIN_SELECTOR,
      remotePoolAddresses: remotePoolAddresses,
      remoteTokenAddress: abi.encode(REMOTE_GHO_TOKEN_AVAX),
      outboundRateLimiterConfig: rateLimiterConfig,
      inboundRateLimiterConfig: rateLimiterConfig
    });

    TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: chainsToRemove,
      chainsToAdd: chainsToAdd
    });
  }
}
