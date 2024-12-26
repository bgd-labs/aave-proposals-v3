// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {RateLimiter} from 'ccip/libraries/RateLimiter.sol';

interface IUpgradeableTokenPool_1_5 {
  struct ChainUpdate {
    uint64 remoteChainSelector;
    bool allowed;
    bytes remotePoolAddress;
    bytes remoteTokenAddress;
    RateLimiter.Config outboundRateLimiterConfig;
    RateLimiter.Config inboundRateLimiterConfig;
  }

  function applyChainUpdates(ChainUpdate[] calldata updates) external;
}
