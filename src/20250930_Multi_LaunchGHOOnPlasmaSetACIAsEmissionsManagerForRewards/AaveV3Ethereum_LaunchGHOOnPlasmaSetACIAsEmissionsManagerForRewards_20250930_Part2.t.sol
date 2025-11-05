// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IAaveGhoCcipBridge} from 'aave-helpers/src/bridges/ccip/interfaces/IAaveGhoCcipBridge.sol';
import {CCIPChainSelectors} from '../helpers/gho-launch/constants/CCIPChainSelectors.sol';
import {IUpgradeableBurnMintTokenPool, IRateLimiter} from 'src/interfaces/ccip/IUpgradeableBurnMintTokenPool.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2} from './AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2.sol';

/**
 * @dev Test for AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2.t.sol -vv
 */
contract AaveV3Ethereum_LaunchGHOOnEthereumSetACIAsEmissionsManagerForRewards_20250930_Part2_Test is
  ProtocolV3TestBase
{
  /**
   * @dev Emitted when a new GHO transfer is issued
   * @param messageId The ID of the cross-chain message
   * @param destinationChainSelector The selector of the destination chain
   * @param from The address of sender on source chain
   * @param amount The total amount of GHO transferred
   */
  event BridgeMessageInitiated(
    bytes32 indexed messageId,
    uint64 indexed destinationChainSelector,
    address indexed from,
    uint256 amount
  );

  address public constant OWNABLE_FACILITATOR = 0x616AEe98F73C79FE59548Cfe7631c0baDBdA3165;
  string public constant OWNABLE_FACILITATOR_NAME = 'OwnableFacilitator Gho GSMs';
  uint128 public constant OWNABLE_FACILITATOR_CAPACITY = 150_000_000 ether;

  AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23733737);
    proposal = new AaveV3Ethereum_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Part2();
  }

  function test_bridgeLimitRestore() public {
    // Mock the update from Part 1
    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      OWNABLE_FACILITATOR,
      OWNABLE_FACILITATOR_NAME,
      OWNABLE_FACILITATOR_CAPACITY
    );

    IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).setBridgeLimit(
      OWNABLE_FACILITATOR_CAPACITY * 2
    );

    IUpgradeableBurnMintTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.PLASMA,
      IRateLimiter.Config({isEnabled: true, capacity: 55_000_000 ether, rate: 54_999_999 ether}),
      IRateLimiter.Config({
        isEnabled: true,
        capacity: proposal.DEFAULT_RATE_LIMITER_CAPACITY(),
        rate: proposal.DEFAULT_RATE_LIMITER_RATE()
      })
    );
    vm.stopPrank();
    vm.warp(block.timestamp + 1);

    IRateLimiter.TokenBucket memory bucket = IUpgradeableBurnMintTokenPool(
      GhoEthereum.GHO_CCIP_TOKEN_POOL
    ).getCurrentOutboundRateLimiterState(CCIPChainSelectors.PLASMA);

    assertGt(bucket.capacity, proposal.DEFAULT_RATE_LIMITER_CAPACITY());
    assertGt(bucket.rate, proposal.DEFAULT_RATE_LIMITER_RATE());
    assertTrue(bucket.isEnabled);
    assertGt(bucket.tokens, proposal.DEFAULT_RATE_LIMITER_CAPACITY());

    executePayload(vm, address(proposal));

    bucket = IUpgradeableBurnMintTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL)
      .getCurrentOutboundRateLimiterState(CCIPChainSelectors.PLASMA);

    assertEq(bucket.capacity, proposal.DEFAULT_RATE_LIMITER_CAPACITY());
    assertEq(bucket.rate, proposal.DEFAULT_RATE_LIMITER_RATE());
    assertTrue(bucket.isEnabled);
    assertEq(bucket.tokens, proposal.DEFAULT_RATE_LIMITER_CAPACITY());
  }

  function test_bridge() public {
    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).addFacilitator(
      OWNABLE_FACILITATOR,
      OWNABLE_FACILITATOR_NAME,
      OWNABLE_FACILITATOR_CAPACITY
    );

    IGhoToken.Facilitator memory facilitator = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING)
      .getFacilitator(OWNABLE_FACILITATOR);

    IUpgradeableLockReleaseTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).setBridgeLimit(
      OWNABLE_FACILITATOR_CAPACITY * 2
    );

    IUpgradeableBurnMintTokenPool(GhoEthereum.GHO_CCIP_TOKEN_POOL).setChainRateLimiterConfig(
      CCIPChainSelectors.PLASMA,
      IRateLimiter.Config({isEnabled: true, capacity: 55_000_000 ether, rate: 54_999_999 ether}),
      IRateLimiter.Config({
        isEnabled: true,
        capacity: proposal.DEFAULT_RATE_LIMITER_CAPACITY(),
        rate: proposal.DEFAULT_RATE_LIMITER_RATE()
      })
    );
    vm.stopPrank();
    vm.warp(block.timestamp + 1);

    assertEq(facilitator.bucketCapacity, OWNABLE_FACILITATOR_CAPACITY);
    assertEq(facilitator.bucketLevel, 0);

    uint256 fee = IAaveGhoCcipBridge(proposal.CCIP_BRIDGE()).quoteBridge(
      CCIPChainSelectors.PLASMA,
      proposal.PLASMA_BRIDGE_AMOUNT(),
      AaveV3EthereumAssets.LINK_UNDERLYING
    );

    uint256 feeBalance = IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(
      proposal.CCIP_BRIDGE()
    );

    emit BridgeMessageInitiated(
      bytes32(0),
      CCIPChainSelectors.PLASMA,
      GovernanceV3Ethereum.EXECUTOR_LVL_1,
      proposal.PLASMA_BRIDGE_AMOUNT()
    );

    executePayload(vm, address(proposal));

    facilitator = IGhoToken(AaveV3EthereumAssets.GHO_UNDERLYING).getFacilitator(
      OWNABLE_FACILITATOR
    );

    assertEq(facilitator.bucketCapacity, OWNABLE_FACILITATOR_CAPACITY);
    assertEq(facilitator.bucketLevel, proposal.PLASMA_BRIDGE_AMOUNT());
    assertEq(
      IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(proposal.CCIP_BRIDGE()),
      feeBalance - fee
    );
  }
}
