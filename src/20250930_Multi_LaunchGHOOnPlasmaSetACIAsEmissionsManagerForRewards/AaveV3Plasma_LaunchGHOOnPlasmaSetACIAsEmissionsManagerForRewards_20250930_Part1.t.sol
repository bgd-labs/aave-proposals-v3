// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {GovernanceV3Plasma} from 'aave-address-book/GovernanceV3Plasma.sol';
import {GhoPlasma} from 'aave-address-book/GhoPlasma.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1} from './AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1.sol';

/**
 * @dev Test for AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1.t.sol -vv
 */
contract AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1_Test is
  ProtocolV3TestBase
{
  AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 12339150);
    proposal = new AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part1',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_bridgeLimitIncrease() public {
    IRateLimiter.TokenBucket memory bucket = IUpgradeableBurnMintTokenPool(
      GhoPlasma.GHO_CCIP_TOKEN_POOL
    ).getCurrentInboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertEq(bucket.capacity, proposal.DEFAULT_RATE_LIMITER_CAPACITY());
    assertEq(bucket.rate, proposal.DEFAULT_RATE_LIMITER_RATE());
    assertTrue(bucket.isEnabled);
    assertEq(bucket.tokens, proposal.DEFAULT_RATE_LIMITER_CAPACITY());

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 1);

    bucket = IUpgradeableBurnMintTokenPool(GhoPlasma.GHO_CCIP_TOKEN_POOL)
      .getCurrentInboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertEq(bucket.capacity, proposal.TEMP_BRIDGE_CAPACITY());
    assertEq(bucket.rate, proposal.TEMP_BRIDGE_CAPACITY() - 1);
    assertTrue(bucket.isEnabled);
    assertEq(bucket.tokens, proposal.TEMP_BRIDGE_CAPACITY());
  }
}
