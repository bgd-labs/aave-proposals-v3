// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {GhoMonad} from 'aave-address-book/GhoMonad.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';

import {RemoteGSMLaunchMonadSetup} from './setup/RemoteGSMLaunchMonadSetup.sol';

/**
 * @title Remote GSM Launch: Monad
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-v3-7-on-monad/24943
 */
contract AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1 is IProposalGenericExecutor {
  using SafeCast for uint256;

  function execute() external {
    // Increase bucket capacity to allow minting the bridged GHO on Monad.
    (uint256 currentFacilitatorBucketCapacity, ) = IGhoToken(GhoMonad.GHO_TOKEN)
      .getFacilitatorBucket(GhoMonad.GHO_CCIP_TOKEN_POOL);

    IGhoToken(GhoMonad.GHO_TOKEN).setFacilitatorBucketCapacity(
      GhoMonad.GHO_CCIP_TOKEN_POOL,
      currentFacilitatorBucketCapacity.toUint128() +
        RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT.toUint128()
    );

    // Temporarily widen the Ethereum -> Monad inbound capacity to receive the one-off 50M seed
    // (counterpart to the Ethereum Part 1 outbound step). The outbound (Monad -> Ethereum)
    // direction is set to the standard config; Part 2 restores the whole lane to it.
    // The outbound direction already sits at DEFAULT_RATE_LIMITER_* on-chain, so rewriting it here
    // leaves it unchanged. `test_outboundRateLimiter` asserts that pre-execution state, and fails
    // if the lane is ever reconfigured out from under this assumption.
    IUpgradeableBurnMintTokenPool(GhoMonad.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.ETHEREUM,
      IRateLimiter.Config({
        isEnabled: true,
        capacity: RemoteGSMLaunchMonadSetup.DEFAULT_RATE_LIMITER_CAPACITY,
        rate: RemoteGSMLaunchMonadSetup.DEFAULT_LIMITER_RATE
      }),
      IRateLimiter.Config({
        isEnabled: true,
        capacity: RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY, // Temporarily increase the maximum bridge limit (inbound capacity; counterpart to Ethereum / Part 1 step)
        rate: RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY - 1 // Set rate to capacity so it fills to limit right away (-1 because they cannot be the same)
      })
    );
  }
}
