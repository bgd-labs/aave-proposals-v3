// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoMonad} from 'aave-address-book/GhoMonad.sol';
import {AaveV3Monad} from 'aave-address-book/AaveV3Monad.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1} from './AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1.sol';
import {RemoteGSMLaunchMonadSetup} from './setup/RemoteGSMLaunchMonadSetup.sol';

/**
 * @dev Test for AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1.t.sol -vv
 */
contract AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1_Test is ProtocolV3TestBase {
  AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('monad'), 89055500);
    proposal = new AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1();
  }

  /**
   * @dev executes the generic test suite. e2e is skipped: at this fork block no Monad reserve
   * satisfies ProtocolV3TestBase._getGoodCollateral's gates, so the default supply/borrow path
   * reverts. This payload does not modify pool reserves, so e2e adds no coverage here.
   */
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Monad_RemoteGSMLaunchMonad_20260701_Part1',
      AaveV3Monad.POOL,
      address(proposal),
      false,
      false
    );
  }

  function test_inboundRateLimiterIncrease() public {
    // Capture the pre-existing Eth -> Monad inbound config (unknown ahead of time).
    IRateLimiter.TokenBucket memory bucket = IUpgradeableBurnMintTokenPool(
      GhoMonad.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertTrue(bucket.isEnabled, 'pre-proposal inbound rate limiter should be enabled');

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 1);

    bucket = IUpgradeableBurnMintTokenPool(GhoMonad.GHO_CCIP_TOKEN_POOL)
      .getCurrentInboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertEq(
      bucket.capacity,
      RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY,
      'post-proposal inbound capacity should be TEMP_BRIDGE_CAPACITY'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY - 1,
      'post-proposal inbound rate should be TEMP_BRIDGE_CAPACITY - 1'
    );
    assertTrue(bucket.isEnabled, 'post-proposal inbound rate limiter should be enabled');
    assertEq(
      bucket.tokens,
      RemoteGSMLaunchMonadSetup.TEMP_BRIDGE_CAPACITY,
      'inbound tokens should refill to TEMP_BRIDGE_CAPACITY after 1s'
    );
  }

  function test_facilitatorBucketCapacityIncrease() public {
    // CCIP mints GHO on the destination chain via the token pool facilitator. For the
    // bridged amount to land on Monad, that facilitator's bucket capacity must be
    // raised by the bridged amount before the bridge runs.
    IGhoToken gho = IGhoToken(GhoMonad.GHO_TOKEN);

    IGhoToken.Facilitator memory preFacilitator = gho.getFacilitator(GhoMonad.GHO_CCIP_TOKEN_POOL);
    uint128 preBucketLevel = preFacilitator.bucketLevel;

    executePayload(vm, address(proposal));

    IGhoToken.Facilitator memory postFacilitator = gho.getFacilitator(GhoMonad.GHO_CCIP_TOKEN_POOL);

    assertEq(
      postFacilitator.bucketCapacity,
      RemoteGSMLaunchMonadSetup.EXPECTED_BUCKET_CAPACITY,
      'post-proposal facilitator capacity should be 200M'
    );
    assertEq(
      postFacilitator.bucketCapacity,
      preFacilitator.bucketCapacity + RemoteGSMLaunchMonadSetup.GHO_BRIDGE_AMOUNT,
      'post-proposal facilitator capacity should have incremented by GHO_BRIDGE_AMOUNT'
    );
    assertEq(
      postFacilitator.bucketLevel,
      preBucketLevel,
      'facilitator bucket level should be unchanged by the capacity update'
    );
  }

  function test_outboundRateLimiter() public {
    // Part 1 writes the outbound side of the Monad->Eth lane to the canonical defaults in the same
    // setChainRateLimiterConfig call that raises the inbound side. It is asserted directly here so a
    // disabled / zero-capacity outbound config cannot slip through if Part 2 (which rewrites it) stalls.
    // The lane is expected to already sit at those defaults, which is what makes the rewrite a
    // no-op for the outbound direction. Assert that pre-execution rather than assuming it: if the
    // lane is ever reconfigured, this fails instead of the proposal silently changing it.
    IRateLimiter.TokenBucket memory bucket = IUpgradeableBurnMintTokenPool(
      GhoMonad.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertTrue(bucket.isEnabled, 'pre-proposal outbound rate limiter should be enabled');
    assertEq(
      bucket.capacity,
      RemoteGSMLaunchMonadSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'pre-proposal outbound capacity should already be the canonical default'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchMonadSetup.DEFAULT_LIMITER_RATE,
      'pre-proposal outbound rate should already be the canonical default'
    );

    executePayload(vm, address(proposal));

    bucket = IUpgradeableBurnMintTokenPool(GhoMonad.GHO_CCIP_TOKEN_POOL)
      .getCurrentOutboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertTrue(bucket.isEnabled, 'post-proposal outbound rate limiter should be enabled');
    assertEq(
      bucket.capacity,
      RemoteGSMLaunchMonadSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'post-proposal outbound capacity should be the canonical default'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchMonadSetup.DEFAULT_LIMITER_RATE,
      'post-proposal outbound rate should be the canonical default'
    );
  }
}
