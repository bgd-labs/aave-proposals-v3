// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';

/**
 * @title GHO Base Launch
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-base-set-aci-as-emissions-manager-for-rewards/19338
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x03dc21e0423c60082dc23317af6ebaf997610cbc2cbb0f5a385653bd99a524fe
 */
contract AaveV3Ethereum_GHOBaseLaunch_20241223 is IProposalGenericExecutor {
  uint64 public constant BASE_CHAIN_SELECTOR = 15971525489660198786;

  // https://etherscan.io/address/0x06179f7C1be40863405f374E7f5F8806c728660A
  IUpgradeableLockReleaseTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_5_1(GhoEthereum.GHO_CCIP_TOKEN_POOL);

  // https://basescan.org/address/0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34
  address public constant REMOTE_TOKEN_POOL_BASE = 0x98217A06721Ebf727f2C8d9aD7718ec28b7aAe34;
  // https://basescan.org/address/0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee
  address public constant REMOTE_GHO_TOKEN_BASE = 0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee;

  // Token Rate Limit Capacity: 300_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = 300_000e18;
  // Token Rate Limit Refill Rate: 60 GHO per second (=> 216_000 GHO per hour)
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE = 60e18;

  function execute() external {
    IRateLimiter.Config memory rateLimiterConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
    });

    IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[]
      memory chainsToAdd = new IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[](1);

    bytes[] memory remotePoolAddresses = new bytes[](1);
    remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_BASE);

    chainsToAdd[0] = IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate({
      remoteChainSelector: BASE_CHAIN_SELECTOR,
      remotePoolAddresses: remotePoolAddresses,
      remoteTokenAddress: abi.encode(REMOTE_GHO_TOKEN_BASE),
      outboundRateLimiterConfig: rateLimiterConfig,
      inboundRateLimiterConfig: rateLimiterConfig
    });

    TOKEN_POOL.applyChainUpdates({
      remoteChainSelectorsToRemove: new uint64[](0),
      chainsToAdd: chainsToAdd
    });
  }
}
