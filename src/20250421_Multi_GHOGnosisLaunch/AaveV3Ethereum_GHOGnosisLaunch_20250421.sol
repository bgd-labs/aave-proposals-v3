// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';

/**
 * @title GHO Gnosis Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-gnosis-chain/21379
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x62996204d8466d603fe8c953176599db02a23f440a682ff15ba2d0ca63dda386
 */
contract AaveV3Ethereum_GHOGnosisLaunch_20250421 is IProposalGenericExecutor {
  uint64 public constant GNOSIS_CHAIN_SELECTOR = 465200170687744372;

  // https://etherscan.io/address/0x06179f7C1be40863405f374E7f5F8806c728660A
  IUpgradeableLockReleaseTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_5_1(GhoEthereum.GHO_CCIP_TOKEN_POOL);

  // https://basescan.org/address/0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34
  address public constant REMOTE_TOKEN_POOL_GNOSIS = 0x0;
  // https://basescan.org/address/0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee
  address public constant REMOTE_GHO_TOKEN_GNOSIS = 0x0;

  // Token Rate Limit Capacity: 1_000_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = 1_000_000e18;
  // Token Rate Limit Refill Rate: 200 GHO per second
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE = 200e18;

  function execute() external {
    IRateLimiter.Config memory rateLimiterConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
    });

    IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[]
      memory chainsToAdd = new IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[](1);

    bytes[] memory remotePoolAddresses = new bytes[](1);
    remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_GNOSIS);

    chainsToAdd[0] = IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate({
      remoteChainSelector: GNOSIS_CHAIN_SELECTOR,
      remotePoolAddresses: remotePoolAddresses,
      remoteTokenAddress: abi.encode(REMOTE_GHO_TOKEN_GNOSIS),
      outboundRateLimiterConfig: rateLimiterConfig,
      inboundRateLimiterConfig: rateLimiterConfig
    });

    TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chainsToAdd
    });
  }
}
