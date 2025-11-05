// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2} from './AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2.sol';

/**
 * @dev Test for AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250930_Multi_LaunchGHOOnEthereumSetACIAsEmissionsManagerForRewards/AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2.t.sol -vv
 */
contract AaveV3Ethereum_LaunchGHOOnEthereumSetACIAsEmissionsManagerForRewards_20250930_Part2_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23678543);
    proposal = new AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_bridgeLimitIncrease() public {
    IRateLimiter.TokenBucket memory bucket = IUpgradeableBurnMintTokenPool(proposal.TOKEN_POOL())
      .getCurrentInboundRateLimiterState(CCIPChainSelectors.ETHEREUM);

    assertEq(bucket.capacity, proposal.DEFAULT_RATE_LIMITER_CAPACITY());
    assertEq(bucket.rate, proposal.DEFAULT_RATE_LIMITER_RATE());
    assertTrue(bucket.isEnabled);
    assertEq(bucket.tokens, proposal.DEFAULT_RATE_LIMITER_CAPACITY());

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 1);

    bucket = IUpgradeableBurnMintTokenPool(proposal.TOKEN_POOL()).getCurrentInboundRateLimiterState(
      CCIPChainSelectors.ETHEREUM
    );

    assertEq(bucket.capacity, proposal.NEW_CAPACITY());
    assertEq(bucket.rate, proposal.NEW_CAPACITY() - 1);
    assertTrue(bucket.isEnabled);
    assertEq(bucket.tokens, proposal.NEW_CAPACITY());
  }
}
