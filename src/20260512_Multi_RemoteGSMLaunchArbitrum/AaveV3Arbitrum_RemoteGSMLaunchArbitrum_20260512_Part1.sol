// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';

import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

/**
 * @title Remote GSM Launch: Arbitrum
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793
 * - Discussion: https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986
 */
contract AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1 is IProposalGenericExecutor {
  using SafeCast for uint256;

  function execute() external {
    // Increase bucket capacity to allow minting the bridged GHO on Arbitrum.
    (uint256 currentFacilitatorBucketCapacity, ) = IGhoToken(GhoArbitrum.GHO_TOKEN)
      .getFacilitatorBucket(GhoArbitrum.GHO_CCIP_TOKEN_POOL);

    IGhoToken(GhoArbitrum.GHO_TOKEN).setFacilitatorBucketCapacity(
      GhoArbitrum.GHO_CCIP_TOKEN_POOL,
      currentFacilitatorBucketCapacity.toUint128() +
        RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT.toUint128()
    );

    IUpgradeableBurnMintTokenPool(GhoArbitrum.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.ETHEREUM,
      IRateLimiter.Config({
        isEnabled: true,
        capacity: RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
        rate: RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_RATE
      }),
      IRateLimiter.Config({
        isEnabled: true,
        capacity: RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY, // Temporarily increase the maximum bridge limit (inbound capacity; counterpart to Ethereum / Part 1 step)
        rate: RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY - 1 // Set rate to capacity so it fills to limit right away (-1 because they cannot be the same)
      })
    );
  }
}
