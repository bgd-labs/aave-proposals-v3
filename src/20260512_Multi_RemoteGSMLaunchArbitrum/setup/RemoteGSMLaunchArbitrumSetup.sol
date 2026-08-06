// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoCCIPChains} from 'src/helpers/gho-launch/constants/GhoCCIPChains.sol';
import {IUpgradeableLockReleaseTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';

/**
 * @notice Common setup library containing constants and helper functions used in the proposal.
 * @dev See forum post for reference: https://governance.aave.com/t/arfc-launch-remotegsm-on-arbitrum/24986
 */
library RemoteGSMLaunchArbitrumSetup {
  // Amount to mint in Mainnet and bridge to Arbitrum
  uint256 public constant GHO_BRIDGE_AMOUNT = 50_000_000 ether;

  // 50M GHO bridge amount + 10% leeway in case of other bridges
  uint128 public constant TEMP_BRIDGE_CAPACITY = 55_000_000 ether;

  // Maximum capacity per transaction to be applied to every lane
  uint128 public constant DEFAULT_RATE_LIMITER_CAPACITY = 5_000_000 ether;

  // Refill rate per second to be applied to every lane
  uint128 public constant DEFAULT_RATE_LIMITER_RATE = 1_000 ether;

  // Facilitator capacity matches bridge amount (as uint128)
  uint128 public constant DIRECT_FACILITATOR_CAPACITY = uint128(GHO_BRIDGE_AMOUNT);

  // GSM USDC
  // Maximum amount that can be withdrawn by GSM (can be changed by steward later)
  uint128 public constant GSM_USDC_RESERVE_LIMIT = 25_000_000 ether;

  // This allows about 23.3M GHO to be issued, considering a rate of ~1.165 for stataUSDC on Arbitrum
  uint128 public constant GSM_USDC_INITIAL_EXPOSURE_CAP = 20_000_000e6; // 20M, 6 decimals

  /**
   * @notice Normalizes the inbound and outbound CCIP rate-limit config of a GHO token pool
   * to the canonical defaults for every supported network other than the pool's own chain.
   * @dev Iterates over every chain returned by `GhoCCIPChains.getAllChainsExcept` (1.6.0 chains
   * included) and applies the same default config — `DEFAULT_RATE_LIMITER_CAPACITY` /
   * `DEFAULT_RATE_LIMITER_RATE`, enabled — on both the inbound and outbound lane to each of them.
   * @param tokenPool The GHO CCIP token pool whose lanes will be normalized. Typed as
   * `IUpgradeableLockReleaseTokenPool`, but `setChainRateLimiterConfig` shares the same selector
   * across the lock-release and burn-mint pools, so a burn-mint pool address may also be passed.
   * @param currentChainSelector The CCIP selector of the pool's own chain, excluded from the loop.
   */
  function normalizeIORateLimitsForAllNetworks(
    address tokenPool,
    uint64 currentChainSelector
  ) internal {
    GhoCCIPChains.ChainInfo[] memory chains = GhoCCIPChains.getAllChainsExcept(
      currentChainSelector,
      false
    );

    IRateLimiter.Config memory defaultConfig = IRateLimiter.Config({
      isEnabled: true,
      capacity: DEFAULT_RATE_LIMITER_CAPACITY,
      rate: DEFAULT_RATE_LIMITER_RATE
    });

    for (uint256 i = 0; i < chains.length; i++) {
      IUpgradeableLockReleaseTokenPool(tokenPool).setChainRateLimiterConfig(
        chains[i].chainSelector,
        defaultConfig,
        defaultConfig
      );
    }
  }
}
