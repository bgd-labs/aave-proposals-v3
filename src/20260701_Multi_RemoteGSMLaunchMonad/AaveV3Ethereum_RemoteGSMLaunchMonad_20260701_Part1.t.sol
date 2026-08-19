// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IUpgradeableLockReleaseTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1} from './AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1.sol';
import {RemoteGSMLaunchMonadSetup} from './setup/RemoteGSMLaunchMonadSetup.sol';

/**
 * @dev Test for AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1.t.sol -vv
 */
contract AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25576000);
    proposal = new AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RemoteGSMLaunchMonad_20260701_Part1',
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
      bridgeLimitBefore + RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT,
      'bridge limit not raised by GHO_BRIDGE_AMOUNT after proposal'
    );
  }

  function test_rateLimiter() public {
    // Capture the pre-existing Eth -> Monad outbound config (unknown ahead of time) so we can
    // assert the proposal widens it to the temporary capacity.
    IRateLimiter.TokenBucket memory bucket = IUpgradeableLockReleaseTokenPool(
      GhoEthereum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(CCIPChainSelectors.MONAD);

    uint128 tokensBefore = bucket.tokens;

    executePayload(vm, address(proposal));

    // State moves to new temporary capacity after proposal, but tokens do not change instantly.
    bucket = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentOutboundRateLimiterState(CCIPChainSelectors.MONAD);

    assertEq(
      bucket.capacity,
      RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY,
      'post-proposal outbound capacity should be TEMP_BRIDGE_CAPACITY'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY - 1,
      'post-proposal outbound rate should be TEMP_BRIDGE_CAPACITY - 1'
    );
    assertTrue(bucket.isEnabled, 'post-proposal outbound rate limiter should be enabled');
    assertEq(
      bucket.tokens,
      tokensBefore,
      'tokens should not refill instantly after proposal (carry the pre-existing balance)'
    );

    vm.warp(block.timestamp + 1);

    // 1 second after execution, we have temporary token capacity as well.
    bucket = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentOutboundRateLimiterState(CCIPChainSelectors.MONAD);

    assertEq(
      bucket.capacity,
      RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY,
      'outbound capacity should remain TEMP_BRIDGE_CAPACITY after 1s'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY - 1,
      'outbound rate should remain TEMP_BRIDGE_CAPACITY - 1 after 1s'
    );
    assertTrue(bucket.isEnabled, 'outbound rate limiter should remain enabled after 1s');
    assertEq(
      bucket.tokens,
      RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY,
      'tokens should refill to TEMP_BRIDGE_CAPACITY after 1s'
    );
  }

  function test_inboundRateLimiter() public {
    // Part 1 writes the inbound side of the Eth->Monad lane to the canonical defaults in the same
    // setChainRateLimiterConfig call that raises the outbound side. It is asserted directly here so a
    // disabled / zero-capacity inbound config cannot slip through if Part 2 (which rewrites it) stalls.
    // The lane is expected to already sit at those defaults, which is what makes the rewrite a
    // no-op for the inbound direction. Assert that pre-execution rather than assuming it: if the
    // lane is ever reconfigured, this fails instead of the proposal silently changing it.
    IRateLimiter.TokenBucket memory bucket = IUpgradeableLockReleaseTokenPool(
      GhoEthereum.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(CCIPChainSelectors.MONAD);

    assertTrue(bucket.isEnabled, 'pre-proposal inbound rate limiter should be enabled');
    assertEq(
      bucket.capacity,
      RemoteGSMLaunchMonadSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'pre-proposal inbound capacity should already be the canonical default'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchMonadSetup.DEFAULT_LIMITER_RATE,
      'pre-proposal inbound rate should already be the canonical default'
    );

    executePayload(vm, address(proposal));

    bucket = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentInboundRateLimiterState(CCIPChainSelectors.MONAD);

    assertTrue(bucket.isEnabled, 'post-proposal inbound rate limiter should be enabled');
    assertEq(
      bucket.capacity,
      RemoteGSMLaunchMonadSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'post-proposal inbound capacity should be the canonical default'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchMonadSetup.DEFAULT_LIMITER_RATE,
      'post-proposal inbound rate should be the canonical default'
    );
  }
}
