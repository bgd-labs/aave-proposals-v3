// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IUpgradeableLockReleaseTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1} from './AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1.sol';
import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

/**
 * @dev Test for AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1.t.sol -vv
 */
contract AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1_Test is ProtocolV3TestBase {
  // Existing on-chain rate-limiter values for the Eth->Arb GHO lane at the pinned
  // mainnet block. The proposal intentionally raises these to the new defaults
  // (DEFAULT_RATE_LIMITER_CAPACITY / DEFAULT_RATE_LIMITER_RATE in the constants
  // file); these constants make the before/after change explicit instead of
  // pretending the new values were already on-chain.
  uint128 internal constant EXISTING_RATE_LIMITER_CAPACITY = 1_500_000 ether;
  uint128 internal constant EXISTING_RATE_LIMITER_RATE = 300 ether;

  AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25424170);
    proposal = new AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_bridgeLimit() public {
    uint256 bridgeLimitBefore = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getBridgeLimit();

    executePayload(vm, address(proposal));

    assertEq(
      IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimit(),
      bridgeLimitBefore + RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT,
      'bridge limit not raised by BRIDGE_AMOUNT after proposal'
    );
  }

  function test_rateLimiter() public {
    // Start with default values.
    IRateLimiter.TokenBucket memory bucket = IUpgradeableLockReleaseTokenPool(
      GhoEthereum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(CCIPChainSelectors.ARBITRUM);

    assertEq(
      bucket.capacity,
      EXISTING_RATE_LIMITER_CAPACITY,
      'pre-proposal outbound capacity should match existing on-chain value'
    );
    assertEq(
      bucket.rate,
      EXISTING_RATE_LIMITER_RATE,
      'pre-proposal outbound rate should match existing on-chain value'
    );
    assertTrue(bucket.isEnabled, 'pre-proposal outbound rate limiter should be enabled');
    assertEq(
      bucket.tokens,
      EXISTING_RATE_LIMITER_CAPACITY,
      'pre-proposal outbound tokens should equal existing capacity'
    );

    executePayload(vm, address(proposal));

    // State moves to new temporary capacity after proposal, but tokens do not change instantly.
    bucket = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentOutboundRateLimiterState(CCIPChainSelectors.ARBITRUM);

    assertEq(
      bucket.capacity,
      RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY,
      'post-proposal outbound capacity should be TEMP_BRIDGE_CAPACITY'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY - 1,
      'post-proposal outbound rate should be TEMP_BRIDGE_CAPACITY - 1'
    );
    assertTrue(bucket.isEnabled, 'post-proposal outbound rate limiter should be enabled');
    assertEq(
      bucket.tokens,
      EXISTING_RATE_LIMITER_CAPACITY,
      'tokens should not refill instantly after proposal (carry the pre-existing balance)'
    );

    vm.warp(block.timestamp + 1);

    // 1 second after execution, we have temporary token capacity as well.
    bucket = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentOutboundRateLimiterState(CCIPChainSelectors.ARBITRUM);

    assertEq(
      bucket.capacity,
      RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY,
      'outbound capacity should remain TEMP_BRIDGE_CAPACITY after 1s'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY - 1,
      'outbound rate should remain TEMP_BRIDGE_CAPACITY - 1 after 1s'
    );
    assertTrue(bucket.isEnabled, 'outbound rate limiter should remain enabled after 1s');
    assertEq(
      bucket.tokens,
      RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY,
      'tokens should refill to TEMP_BRIDGE_CAPACITY after 1s'
    );
  }

  function test_inboundRateLimiter() public {
    // Part 1 writes the inbound side of the Eth->Arb lane to the canonical defaults in the same
    // setChainRateLimiterConfig call that raises the outbound side. It is asserted directly here so a
    // disabled / zero-capacity inbound config cannot slip through if Part 2 (which rewrites it) stalls.
    executePayload(vm, address(proposal));

    IRateLimiter.TokenBucket memory bucket = IUpgradeableLockReleaseTokenPool(
      GhoEthereum.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(CCIPChainSelectors.ARBITRUM);

    assertTrue(bucket.isEnabled, 'post-proposal inbound rate limiter should be enabled');
    assertEq(
      bucket.capacity,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'post-proposal inbound capacity should be the canonical default'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_RATE,
      'post-proposal inbound rate should be the canonical default'
    );
  }
}
