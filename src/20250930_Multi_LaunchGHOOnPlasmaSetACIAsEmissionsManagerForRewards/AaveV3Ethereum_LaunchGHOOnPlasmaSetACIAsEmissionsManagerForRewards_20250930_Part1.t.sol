// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IUpgradeableLockReleaseTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1} from './AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1.sol';

/**
 * @dev Test for AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1.t.sol -vv
 */
contract AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23792200);
    proposal = new AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_bridgeLimit() public {
    assertEq(
      IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimit(),
      40_000_000 ether
    );

    executePayload(vm, address(proposal));

    assertEq(
      IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).getBridgeLimit(),
      proposal.NEW_BRIDGE_LIMIT()
    );
  }

  function test_rateLimiter() public {
    IRateLimiter.TokenBucket memory bucket = IUpgradeableLockReleaseTokenPool(
      GhoEthereum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(CCIPChainSelectors.PLASMA);

    assertEq(bucket.capacity, proposal.DEFAULT_RATE_LIMITER_CAPACITY());
    assertEq(bucket.rate, proposal.DEFAULT_RATE_LIMITER_RATE());
    assertTrue(bucket.isEnabled);
    assertEq(bucket.tokens, proposal.DEFAULT_RATE_LIMITER_CAPACITY());

    executePayload(vm, address(proposal));

    bucket = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentOutboundRateLimiterState(CCIPChainSelectors.PLASMA);

    assertEq(bucket.capacity, proposal.TEMP_BRIDGE_CAPACITY());
    assertEq(bucket.rate, proposal.TEMP_BRIDGE_CAPACITY() - 1);
    assertTrue(bucket.isEnabled);
    assertEq(bucket.tokens, proposal.DEFAULT_RATE_LIMITER_CAPACITY());

    vm.warp(block.timestamp + 1);

    bucket = IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentOutboundRateLimiterState(CCIPChainSelectors.PLASMA);

    assertEq(bucket.capacity, proposal.TEMP_BRIDGE_CAPACITY());
    assertEq(bucket.rate, proposal.TEMP_BRIDGE_CAPACITY() - 1);
    assertTrue(bucket.isEnabled);
    assertEq(bucket.tokens, proposal.TEMP_BRIDGE_CAPACITY());
  }
}
