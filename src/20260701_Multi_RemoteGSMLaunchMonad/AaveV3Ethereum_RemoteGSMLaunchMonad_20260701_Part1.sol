// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';

import {IUpgradeableLockReleaseTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {RemoteGSMLaunchMonadSetup} from './setup/RemoteGSMLaunchMonadSetup.sol';

/**
 * @title Remote GSM Launch: Monad
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-v3-7-on-monad/24943
 */
contract AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1 is IProposalGenericExecutor {
  function execute() external {
    // Increment bridge limit to accommodate the amount to bridge.
    uint256 currentBridgeLimit = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getBridgeLimit();
    IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).setBridgeLimit(
      currentBridgeLimit + RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT
    );

    // Temporarily increase the Ethereum -> Monad outbound capacity for the one-off seed bridge.
    // The inbound (Monad -> Ethereum) direction is set to the standard config; it is not
    // widened here and is left at the value Part 2 restores the lane to.
    // The inbound direction already sits at DEFAULT_RATE_LIMITER_* on-chain, so rewriting it here
    // leaves it unchanged. `test_inboundRateLimiter` asserts that pre-execution state, and fails
    // if the lane is ever reconfigured out from under this assumption.
    IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.MONAD,
      IRateLimiter.Config({
        isEnabled: true,
        capacity: RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY,
        rate: RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY - 1 // Set rate to capacity so it fills to limit right away (-1 because they cannot be the same)
      }),
      IRateLimiter.Config({
        isEnabled: true,
        capacity: RemoteGSMLaunchMonadSetup.DEFAULT_RATE_LIMITER_CAPACITY,
        rate: RemoteGSMLaunchMonadSetup.DEFAULT_LIMITER_RATE
      })
    );
  }
}
