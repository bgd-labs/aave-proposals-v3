// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {ILegacyProxyAdmin, ITransparentUpgradeableProxy} from 'src/interfaces/ILegacyProxyAdmin.sol';

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';

/**
 * @title GHO Gnosis Listing
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-gnosis-chain/21379
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x62996204d8466d603fe8c953176599db02a23f440a682ff15ba2d0ca63dda386
 */
contract AaveV3Arbitrum_GHOGnosisLaunch_20250421 is IProposalGenericExecutor {
  uint64 internal constant ARB_CHAIN_SELECTOR = 4949039107694359620;
  uint64 internal constant BASE_CHAIN_SELECTOR = 15971525489660198786;
  uint64 internal constant ETH_CHAIN_SELECTOR = 5009297550715157269;
  uint64 public constant GNOSIS_CHAIN_SELECTOR = 465200170687744372;

  // https://arbiscan.io/address/0xB94Ab28c6869466a46a42abA834ca2B3cECCA5eB
  IUpgradeableBurnMintTokenPool_1_5_1 public constant TOKEN_POOL =
    IUpgradeableBurnMintTokenPool_1_5_1(GhoArbitrum.GHO_CCIP_TOKEN_POOL);

  // https://gnosisscan.io/address/0xDe6539018B095353A40753Dc54C91C68c9487D4E
  address public constant REMOTE_TOKEN_POOL_GNOSIS = 0xDe6539018B095353A40753Dc54C91C68c9487D4E;
  // https://gnosisscan.io/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73
  address public constant REMOTE_GHO_TOKEN_GNOSIS = 0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73;

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
