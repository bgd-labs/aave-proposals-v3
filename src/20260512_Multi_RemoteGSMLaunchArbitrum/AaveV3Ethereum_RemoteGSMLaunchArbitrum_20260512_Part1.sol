// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';

import {IUpgradeableLockReleaseTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

/**
 * @title Remote GSM Launch: Arbitrum
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0xf24321514fb593af9e5082d26a1358819ec0f648db8fdb5c2b083f53ef785793
 * - Discussion: https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986
 */
contract AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1 is IProposalGenericExecutor {
  function execute() external {
    // Increment bridge limit to accommodate the amount to bridge.
    uint256 currentBridgeLimit = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getBridgeLimit();
    IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).setBridgeLimit(
      currentBridgeLimit + RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT
    );

    // Temporarily increase the maximum bridge limit (outbound capacity)
    IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.ARBITRUM,
      IRateLimiter.Config({
        isEnabled: true,
        capacity: uint128(RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY),
        rate: uint128(RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY) - 1 // Set rate to new capacity so it refills immediately
      }),
      IRateLimiter.Config({
        isEnabled: true,
        capacity: RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
        rate: RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_RATE
      })
    );
  }
}
