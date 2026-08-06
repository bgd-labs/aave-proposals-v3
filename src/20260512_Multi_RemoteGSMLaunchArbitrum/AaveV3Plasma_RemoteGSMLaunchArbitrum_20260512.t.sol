// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {GhoPlasma} from 'aave-address-book/GhoPlasma.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {GhoCCIPChains} from '../helpers/gho-launch/constants/GhoCCIPChains.sol';

import {AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512} from './AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512.sol';
import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

/**
 * @dev Test for AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512.t.sol -vv
 */
contract AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512_Test is ProtocolV3TestBase {
  AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 25809490);
    proposal = new AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_RemoteGSMLaunchArbitrum_20260512',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_facilitatorBucketCapacityIncrease() public {
    IGhoToken gho = IGhoToken(GhoPlasma.GHO_TOKEN);
    IGhoToken.Facilitator memory preFacilitator = gho.getFacilitator(GhoPlasma.GHO_CCIP_TOKEN_POOL);

    executePayload(vm, address(proposal));

    IGhoToken.Facilitator memory postFacilitator = gho.getFacilitator(
      GhoPlasma.GHO_CCIP_TOKEN_POOL
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
      preFacilitator.bucketLevel,
      'facilitator bucket level should be unchanged by the capacity update'
    );
  }

  function test_allLaneRateLimitsNormalized() public {
    executePayload(vm, address(proposal));

    // Every lane to every other supported network (itself excluded) is normalized to defaults.
    GhoCCIPChains.ChainInfo[] memory chains = GhoCCIPChains.getAllChainsExcept(
      CCIPChainSelectors.PLASMA,
      false
    );

    for (uint256 i = 0; i < chains.length; i++) {
      _assertLaneNormalized(chains[i].chainSelector);
    }
  }

  /// @dev Asserts the inbound and outbound rate limiter for `remoteChainSelector` sit at defaults.
  function _assertLaneNormalized(uint64 remoteChainSelector) internal view {
    IRateLimiter.TokenBucket memory inbound = IUpgradeableBurnMintTokenPool(
      GhoPlasma.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(remoteChainSelector);

    assertEq(
      inbound.capacity,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'post-proposal inbound capacity should be default'
    );
    assertEq(
      inbound.rate,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_RATE,
      'post-proposal inbound rate should be default'
    );
    assertTrue(inbound.isEnabled, 'post-proposal inbound rate limiter should be enabled');

    IRateLimiter.TokenBucket memory outbound = IUpgradeableBurnMintTokenPool(
      GhoPlasma.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(remoteChainSelector);

    assertEq(
      outbound.capacity,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'post-proposal outbound capacity should be default'
    );
    assertEq(
      outbound.rate,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_RATE,
      'post-proposal outbound rate should be default'
    );
    assertTrue(outbound.isEnabled, 'post-proposal outbound rate limiter should be enabled');
  }
}
