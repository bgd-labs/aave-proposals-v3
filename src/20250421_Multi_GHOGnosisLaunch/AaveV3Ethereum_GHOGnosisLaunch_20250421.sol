// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GHOLaunchConstants} from './utils/GHOLaunchConstants.sol';

/**
 * @title GHO Gnosis Launch
 * @author kpk
 * @notice This proposal is used to launch GHO on Gnosis Chain
 * @dev This payload enables the GHO CCIP token pool to receive and send messages from Gnosis Chain on Ethereum.
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-gnosis-chain/21379
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x62996204d8466d603fe8c953176599db02a23f440a682ff15ba2d0ca63dda386
 */
contract AaveV3Ethereum_GHOGnosisLaunch_20250421 is IProposalGenericExecutor {
  uint64 public constant GNOSIS_CHAIN_SELECTOR = CCIPUtils.GNOSIS_CHAIN_SELECTOR;

  IUpgradeableLockReleaseTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool_1_5_1(GhoEthereum.GHO_CCIP_TOKEN_POOL);

  address public constant REMOTE_TOKEN_POOL_GNOSIS = GHOLaunchConstants.GNO_TOKEN_POOL;
  address public constant REMOTE_GHO_TOKEN_GNOSIS = GHOLaunchConstants.GNO_GHO_TOKEN;

  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOLaunchConstants.CCIP_RATE_LIMIT_CAPACITY;
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOLaunchConstants.CCIP_RATE_LIMIT_REFILL_RATE;

  function execute() external {
    IRateLimiter.Config memory rateLimiterConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: CCIP_RATE_LIMIT_CAPACITY,
      rate: CCIP_RATE_LIMIT_REFILL_RATE
    });

    IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[]
      memory chainsToAdd = new IUpgradeableLockReleaseTokenPool_1_5_1.ChainUpdate[](1);
    uint64[] memory chainsToRemove = new uint64[](0);

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
      remoteChainSelectorsToRemove: chainsToRemove,
      chainsToAdd: chainsToAdd
    });
  }
}
