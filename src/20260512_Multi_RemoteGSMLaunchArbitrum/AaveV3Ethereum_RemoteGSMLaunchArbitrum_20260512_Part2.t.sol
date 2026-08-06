// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IAaveGhoCcipBridge} from 'aave-helpers/src/bridges/ccip/interfaces/IAaveGhoCcipBridge.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {GhoCCIPChains} from '../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1} from './AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1.sol';
import {AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2} from './AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2.sol';

import {RemoteGSMLaunchArbitrumSetup} from './setup/RemoteGSMLaunchArbitrumSetup.sol';

/**
 * @dev Test for AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260512_Multi_RemoteGSMLaunchArbitrum/AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2.t.sol -vv
 */
contract AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1 internal part1;
  AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25424170);
    part1 = new AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part1();
    proposal = new AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2();

    // Run Part 1 so the GHO_CCIP_TOKEN_POOL bridge limit and outbound rate limiter are
    // raised before any Part 2 test runs. Without this, Part 2's `IAaveGhoCcipBridge.send`
    // would revert (rate-limit exceeded). Mirrors the real on-chain sequencing.
    executePayload(vm, address(part1));
    vm.warp(block.timestamp + 1); // let the outbound rate limiter refill to capacity
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RemoteGSMLaunchArbitrum_20260512_Part2',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_ccipBridgeDestinationChainSetUp() public {
    IAaveGhoCcipBridge bridge = IAaveGhoCcipBridge(proposal.CCIP_BRIDGE());

    IAaveGhoCcipBridge.RemoteChainConfig memory config = bridge.getDestinationRemoteConfig(
      CCIPChainSelectors.ARBITRUM
    );

    assertEq(config.destination, new bytes(0));
    assertEq(config.extraArgsOverride, new bytes(0));
    assertEq(config.gasLimit, 0);

    executePayload(vm, address(proposal));

    config = bridge.getDestinationRemoteConfig(CCIPChainSelectors.ARBITRUM);

    assertEq(config.destination, abi.encode(proposal.ARBITRUM_BRIDGE_DESTINATION()));
    assertEq(config.extraArgsOverride, new bytes(0));
    assertEq(config.gasLimit, proposal.ARBITRUM_BRIDGE_GAS_LIMIT());
  }

  function test_bridgeLimitRestore() public {
    // setUp already executed Part 1, which raised the outbound rate limiter for the
    // Arbitrum lane to (capacity = TEMP_BRIDGE_CAPACITY, rate = TEMP_BRIDGE_CAPACITY - 1)
    // and warped 1 second so the bucket has refilled to capacity.

    IRateLimiter.TokenBucket memory bucket = IUpgradeableBurnMintTokenPool(
      GhoEthereum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(CCIPChainSelectors.ARBITRUM);

    assertGt(
      bucket.capacity,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'pre-proposal outbound capacity should be raised'
    );
    assertGt(
      bucket.rate,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_RATE,
      'pre-proposal outbound rate should be raised'
    );
    assertTrue(bucket.isEnabled, 'pre-proposal outbound rate limiter should be enabled');
    assertGt(
      bucket.tokens,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'pre-proposal outbound tokens should exceed default'
    );

    executePayload(vm, address(proposal));

    // The state finishes at default values after executing the proposal.
    bucket = IUpgradeableBurnMintTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentOutboundRateLimiterState(CCIPChainSelectors.ARBITRUM);

    assertEq(
      bucket.capacity,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'post-proposal outbound capacity should be restored to default'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_RATE,
      'post-proposal outbound rate should be restored to default'
    );
    assertTrue(bucket.isEnabled, 'post-proposal outbound rate limiter should be enabled');
    assertEq(
      bucket.tokens,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'post-proposal outbound tokens should equal default capacity'
    );

    // The proposal restores both outbound and inbound configs; assert inbound too.
    bucket = IUpgradeableBurnMintTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentInboundRateLimiterState(CCIPChainSelectors.ARBITRUM);

    assertEq(
      bucket.capacity,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_CAPACITY,
      'post-proposal inbound capacity should be restored to default'
    );
    assertEq(
      bucket.rate,
      RemoteGSMLaunchArbitrumSetup.DEFAULT_RATE_LIMITER_RATE,
      'post-proposal inbound rate should be restored to default'
    );
    assertTrue(bucket.isEnabled, 'post-proposal inbound rate limiter should be enabled');
  }

  function test_bridge() public {
    // setUp already executed Part 1, raising the bridge limit and outbound rate limiter
    // on the GHO_CCIP_TOKEN_POOL so Part 2's bridge step has the headroom it needs.
    IGhoToken.Facilitator memory facilitator = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING)
      .getFacilitator(proposal.DIRECT_FACILITATOR());

    assertEq(facilitator.bucketCapacity, 0, 'facilitator should not be registered before proposal');
    assertEq(facilitator.bucketLevel, 0, 'facilitator bucket level should be 0 before proposal');

    // messageId is unknown ahead of time, so leave the first indexed topic unchecked.
    // NOTE: `from` is expected to equal EXECUTOR_LVL_1 — verify once CCIP_BRIDGE is deployed
    // and the actual emitter address is known. Mirrors Plasma's test pattern.
    vm.expectEmit(false, true, true, true, proposal.CCIP_BRIDGE());
    emit IAaveGhoCcipBridge.BridgeMessageInitiated(
      bytes32(0),
      CCIPChainSelectors.ARBITRUM,
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT
    );

    executePayload(vm, address(proposal));

    facilitator = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).getFacilitator(
      proposal.DIRECT_FACILITATOR()
    );

    assertEq(facilitator.label, proposal.DIRECT_FACILITATOR_NAME());

    assertEq(
      facilitator.bucketCapacity,
      RemoteGSMLaunchArbitrumSetup.DIRECT_FACILITATOR_CAPACITY,
      'facilitator capacity not set to DIRECT_FACILITATOR_CAPACITY'
    );
    assertEq(
      facilitator.bucketLevel,
      RemoteGSMLaunchArbitrumSetup.GHO_BRIDGE_AMOUNT,
      'facilitator bucket level should match bridged amount'
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(proposal)),
      0,
      'left over GHO on payload'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(proposal),
        proposal.CCIP_BRIDGE()
      ),
      0,
      'left over allowance on payload'
    );
  }

  function test_otherLaneRateLimitsRestored() public {
    executePayload(vm, address(proposal));

    // Every lane to every other supported network (Ethereum excluded, the Arbitrum lane
    // raised by Part 1 included) ends up restored to the canonical defaults.
    GhoCCIPChains.ChainInfo[] memory chains = GhoCCIPChains.getAllChainsExcept(
      CCIPChainSelectors.ETHEREUM,
      false
    );

    for (uint256 i = 0; i < chains.length; i++) {
      _assertLaneNormalized(chains[i].chainSelector);
    }
  }

  /// @dev Asserts the inbound and outbound rate limiter for `remoteChainSelector` sit at defaults.
  function _assertLaneNormalized(uint64 remoteChainSelector) internal view {
    IRateLimiter.TokenBucket memory inbound = IUpgradeableBurnMintTokenPool(
      GhoEthereum.GHO_CCIP_TOKEN_POOL
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
      GhoEthereum.GHO_CCIP_TOKEN_POOL
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
