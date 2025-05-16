// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {ILegacyProxyAdmin, ITransparentUpgradeableProxy} from 'src/interfaces/ILegacyProxyAdmin.sol';

import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {GhoBase} from 'aave-address-book/GhoBase.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {CCIPUtils} from './utils/CCIPUtils.sol';
import {GHOLaunchConstants} from './utils/GHOLaunchConstants.sol';

/**
 * @title GHO Gnosis Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-gnosis-chain/21379
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x62996204d8466d603fe8c953176599db02a23f440a682ff15ba2d0ca63dda386
 */
contract AaveV3Base_GHOGnosisLaunch_20250421 is IProposalGenericExecutor {
  uint64 public constant GNOSIS_CHAIN_SELECTOR = CCIPUtils.GNOSIS_CHAIN_SELECTOR;

  // https://basescan.org/address/0x6Bb7a212910682DCFdbd5BCBb3e28FB4E8da10Ee
  IUpgradeableBurnMintTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(GhoBase.GHO_CCIP_TOKEN_POOL);

  // https://gnosisscan.io/address/0xDe6539018B095353A40753Dc54C91C68c9487D4E
  address public constant REMOTE_TOKEN_POOL_GNOSIS = GHOLaunchConstants.GNO_TOKEN_POOL;
  // https://gnosisscan.io/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73
  address public constant REMOTE_GHO_TOKEN_GNOSIS = GHOLaunchConstants.GNO_GHO_TOKEN;

  // Token Rate Limit Capacity: 1_000_000 GHO
  uint128 public constant CCIP_RATE_LIMIT_CAPACITY = GHOLaunchConstants.CCIP_RATE_LIMIT_CAPACITY;
  // Token Rate Limit Refill Rate: 200 GHO per second
  uint128 public constant CCIP_RATE_LIMIT_REFILL_RATE =
    GHOLaunchConstants.CCIP_RATE_LIMIT_REFILL_RATE;

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
    remotePoolAddresses[0] = abi.encode(REMOTE_TOKEN_POOL_GNOSIS);

    chainsToAdd[0] = IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate({
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
