// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GhoArbitrum} from 'aave-address-book/GhoArbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1} from './AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1.sol';
import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

/**
 * @dev Test for AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1.t.sol -vv
 */
contract AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1_Test is ProtocolV3TestBase {
  // Existing on-chain rate-limiter values for the Eth->Arb GHO lane.
  // The proposal intentionally raises these to the new defaults
  // (DEFAULT_RATE_LIMITER_CAPACITY / DEFAULT_RATE_LIMITER_RATE in the constants file).
  uint128 internal constant EXISTING_RATE_LIMITER_CAPACITY = 1_500_000 ether;
  uint128 internal constant EXISTING_RATE_LIMITER_RATE = 300 ether;

  AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 478622035);
    proposal = new AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_RemoteGSMLaunchArbitrum_20260512_Part1',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_bridgeLimitIncrease() public {
    IRateLimiter.TokenBucket memory bucket = IUpgradeableBurnMintTokenPool(
      GhoArbitrum.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertEq(
      bucket.capacity,
      EXISTING_RATE_LIMITER_CAPACITY,
      'pre-proposal inbound capacity should match existing on-chain value'
    );
    assertEq(
      bucket.rate,
      EXISTING_RATE_LIMITER_RATE,
      'pre-proposal inbound rate should match existing on-chain value'
    );
    assertTrue(bucket.isEnabled, 'pre-proposal inbound rate limiter should be enabled');

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 1);

    bucket = IUpgradeableBurnMintTokenPool(GhoArbitrum.GHO_CCIP_TOKEN_POOL)
      .getCurrentInboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertEq(
      bucket.capacity,
      RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY,
      'post-proposal inbound capacity should be TEMP_BRIDGE_CAPACITY'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY - 1,
      'post-proposal inbound rate should be TEMP_BRIDGE_CAPACITY - 1'
    );
    assertTrue(bucket.isEnabled, 'post-proposal inbound rate limiter should be enabled');
    assertEq(
      bucket.tokens,
      RemoteGSMLaunchArbitrumSetup.TEMP_BRIDGE_CAPACITY,
      'inbound tokens should refill to TEMP_BRIDGE_CAPACITY after 1s'
    );
  }

  function test_facilitatorBucketCapacityIncrease() public {
    // CCIP mints GHO on the destination chain via the token pool facilitator. For the
    // bridged amount to land on Arbitrum, that facilitator's bucket capacity must be
    // raised to at least TEMP_BRIDGE_CAPACITY before the bridge runs.
    IGhoToken gho = IGhoToken(GhoArbitrum.GHO_TOKEN);

    IGhoToken.Facilitator memory preFacilitator = gho.getFacilitator(
      GhoArbitrum.GHO_CCIP_TOKEN_POOL
    );
    uint128 preBucketLevel = preFacilitator.bucketLevel;

    executePayload(vm, address(proposal));

    IGhoToken.Facilitator memory postFacilitator = gho.getFacilitator(
      GhoArbitrum.GHO_CCIP_TOKEN_POOL
    );

    assertEq(
      postFacilitator.bucketCapacity,
      150_000_000 ether,
      'post-proposal facilitator capacity should be 150M'
    );
    assertEq(
      postFacilitator.bucketCapacity,
      preFacilitator.bucketCapacity + RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT,
      'post-proposal facilitator capacity should have incremented by GHO_BRIDGE_AMOUNT'
    );
    assertEq(
      postFacilitator.bucketLevel,
      preBucketLevel,
      'facilitator bucket level should be unchanged by the capacity update'
    );
  }

  function test_outboundRateLimiter() public {
    // Part 1 writes the outbound side of the Arb->Eth lane to the canonical defaults in the same
    // setChainRateLimiterConfig call that raises the inbound side. It is asserted directly here so a
    // disabled / zero-capacity outbound config cannot slip through if Part 2 (which rewrites it) stalls.
    executePayload(vm, address(proposal));

    IRateLimiter.TokenBucket memory bucket = IUpgradeableBurnMintTokenPool(
      GhoArbitrum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertTrue(bucket.isEnabled, 'post-proposal outbound rate limiter should be enabled');
    assertEq(
      bucket.capacity,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'post-proposal outbound capacity should be the canonical default'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_RATE,
      'post-proposal outbound rate should be the canonical default'
    );
  }
}
