// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool as IPool_CCIP} from 'src/interfaces/ccip/tokenPool/IPool.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {GhoCCIPChains} from '../constants/GhoCCIPChains.sol';
import {AaveV3GHOLaneTest} from './AaveV3GHOLaneTest.sol';

abstract contract AaveV3GHORemoteLaneTest_PreExecution is AaveV3GHOLaneTest {
  constructor(
    GhoCCIPChains.ChainInfo memory localChainInfo,
    GhoCCIPChains.ChainInfo memory remoteChainInfo,
    string memory rpcAlias,
    uint256 blockNumber
  ) AaveV3GHOLaneTest(localChainInfo, remoteChainInfo, rpcAlias, blockNumber) {}

  // This test is not necessary but without it the compiler triggers stack too deep... very strange.
  function test_currentPoolConfig() public virtual {
    uint64[] memory supportedChains = LOCAL_TOKEN_POOL.getSupportedChains();

    for (uint256 i = 0; i < supportedChains.length; i++) {
      _assertAgainstSupportedChain(GhoCCIPChains.getChainInfoBySelector(supportedChains[i]));
    }
  }

  function _assertAgainstSupportedChain(
    GhoCCIPChains.ChainInfo memory supportedChain
  ) internal virtual {
    assertEq(
      LOCAL_TOKEN_POOL.getRemoteToken(supportedChain.chainSelector),
      abi.encode(supportedChain.ghoToken),
      'Remote token mismatch for supported chain'
    );

    assertEq(
      LOCAL_TOKEN_POOL.getRemotePools(supportedChain.chainSelector)[0],
      abi.encode(supportedChain.ghoCCIPTokenPool),
      'Remote pool mismatch for supported chain'
    );
  }
}

abstract contract AaveV3GHORemoteLaneTest_PostExecution is AaveV3GHOLaneTest {
  constructor(
    GhoCCIPChains.ChainInfo memory localChainInfo,
    GhoCCIPChains.ChainInfo memory remoteChainInfo,
    string memory rpcAlias,
    uint256 blockNumber
  ) AaveV3GHOLaneTest(localChainInfo, remoteChainInfo, rpcAlias, blockNumber) {}

  function setUp() public virtual override {
    super.setUp();
    _executePayload();
  }

  function _executePayload() internal virtual {
    executePayload(vm, address(proposal));
  }

  function _assertAgainstSupportedChain(
    GhoCCIPChains.ChainInfo memory supportedChain
  ) internal view virtual {
    assertEq(
      LOCAL_TOKEN_POOL.getRemoteToken(supportedChain.chainSelector),
      abi.encode(supportedChain.ghoToken),
      'Remote token mismatch for supported chain'
    );

    assertEq(
      LOCAL_TOKEN_POOL.getRemotePools(supportedChain.chainSelector).length,
      1,
      'Amount of remote pools mismatch for supported chain'
    );

    assertEq(
      LOCAL_TOKEN_POOL.getRemotePools(supportedChain.chainSelector)[0],
      abi.encode(supportedChain.ghoCCIPTokenPool),
      'Remote pool mismatch for supported chain'
    );
  }

  function test_currentPoolConfig() public view virtual {
    GhoCCIPChains.ChainInfo[] memory expectedSupportedChains = _expectedSupportedChains();

    assertEq(
      LOCAL_TOKEN_POOL.getSupportedChains().length,
      expectedSupportedChains.length,
      'Amount of supported chains mismatch'
    );

    for (uint256 i = 0; i < expectedSupportedChains.length; i++) {
      assertEq(
        LOCAL_TOKEN_POOL.getSupportedChains()[i],
        expectedSupportedChains[i].chainSelector,
        'Supported chain mismatch'
      );
      _assertAgainstSupportedChain(expectedSupportedChains[i]);
    }

    // Omit checking rate limit configs against other chains because it's dynamic and not an area of concern for this AIP
    assertEq(
      LOCAL_TOKEN_POOL.getCurrentInboundRateLimiterState(REMOTE_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
    assertEq(
      LOCAL_TOKEN_POOL.getCurrentOutboundRateLimiterState(REMOTE_CHAIN_SELECTOR),
      _getRateLimiterConfig()
    );
  }

  function test_sendMessageToRemoteChainSucceeds(uint256 amount) public virtual {
    uint256 bridgeableAmount = _min(
      LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel,
      _ccipRateLimitCapacity()
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(LOCAL_GHO_TOKEN), alice, amount);
    vm.prank(alice);
    LOCAL_GHO_TOKEN.approve(address(LOCAL_CCIP_ROUTER), amount);

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);
    uint256 bucketLevel = LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel;

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({
          amount: amount,
          sender: alice,
          destChainSelector: REMOTE_CHAIN_SELECTOR,
          destToken: address(REMOTE_GHO_TOKEN)
        })
      );

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Burned(address(_localOutboundLaneToRemote()), amount);
    vm.expectEmit(address(_localOutboundLaneToRemote()));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    LOCAL_CCIP_ROUTER.ccipSend{value: eventArg.feeTokenAmount}(REMOTE_CHAIN_SELECTOR, message);

    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(
      LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel,
      bucketLevel - amount
    );
  }

  function test_sendMessageToEthSucceeds(uint256 amount) public virtual {
    vm.skip(LOCAL_CHAIN_SELECTOR == ETH_CHAIN_SELECTOR);

    IRateLimiter.TokenBucket memory ethRateLimits = LOCAL_TOKEN_POOL
      .getCurrentInboundRateLimiterState(ETH_CHAIN_SELECTOR);
    uint256 bridgeableAmount = _min(
      LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel,
      ethRateLimits.capacity
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(LOCAL_GHO_TOKEN), alice, amount);
    vm.prank(alice);
    LOCAL_GHO_TOKEN.approve(address(LOCAL_CCIP_ROUTER), amount);

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);
    uint256 bucketLevel = LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel;

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({
          amount: amount,
          sender: alice,
          destChainSelector: ETH_CHAIN_SELECTOR,
          destToken: address(ETH_GHO_TOKEN)
        })
      );

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Burned(address(_localOutboundLaneToEth()), amount);
    vm.expectEmit(address(_localOutboundLaneToEth()));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    LOCAL_CCIP_ROUTER.ccipSend{value: eventArg.feeTokenAmount}(ETH_CHAIN_SELECTOR, message);

    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(
      LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel,
      bucketLevel - amount
    );
  }

  function test_offRampViaRemoteChainSucceeds(uint256 amount) public virtual {
    (uint256 bucketCapacity, uint256 bucketLevel) = LOCAL_GHO_TOKEN.getFacilitatorBucket(
      address(LOCAL_TOKEN_POOL)
    );
    uint256 mintAbleAmount = _min(bucketCapacity - bucketLevel, _ccipRateLimitCapacity());
    amount = bound(amount, 1, mintAbleAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Minted(address(_localInboundLaneFromRemote()), alice, amount);

    vm.prank(address(_localInboundLaneFromRemote()));
    LOCAL_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: REMOTE_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(LOCAL_GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(REMOTE_TOKEN_POOL)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(
      LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel,
      bucketLevel + amount
    );
    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance + amount);
  }

  function test_offRampViaEthSucceeds(uint256 amount) public virtual {
    vm.skip(LOCAL_CHAIN_SELECTOR == ETH_CHAIN_SELECTOR);

    (uint256 bucketCapacity, uint256 bucketLevel) = LOCAL_GHO_TOKEN.getFacilitatorBucket(
      address(LOCAL_TOKEN_POOL)
    );
    IRateLimiter.TokenBucket memory rateLimits = LOCAL_TOKEN_POOL.getCurrentInboundRateLimiterState(
      ETH_CHAIN_SELECTOR
    );
    uint256 mintAbleAmount = _min(bucketCapacity - bucketLevel, rateLimits.tokens);
    amount = bound(amount, 1, mintAbleAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Minted(address(_localInboundLaneFromEth()), alice, amount);

    vm.prank(address(_localInboundLaneFromEth()));
    LOCAL_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(LOCAL_GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(ETH_TOKEN_POOL)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    assertEq(
      LOCAL_GHO_TOKEN.getFacilitator(address(LOCAL_TOKEN_POOL)).bucketLevel,
      bucketLevel + amount
    );
    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance + amount);
  }

  function test_cannotUseRemoteChainOffRampForEthMessages() public virtual {
    vm.skip(LOCAL_CHAIN_SELECTOR == ETH_CHAIN_SELECTOR);

    uint256 amount = 100e18;
    skip(_getInboundRefillTime(amount));

    address offRamp = address(_localInboundLaneFromRemote());

    vm.prank(offRamp);
    vm.expectRevert(abi.encodeWithSelector(CallerIsNotARampOnRouter.selector, offRamp));
    LOCAL_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(LOCAL_GHO_TOKEN),
        sourcePoolAddress: abi.encode(address(ETH_TOKEN_POOL)),
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }

  function test_cannotOffRampOtherChainMessages() public virtual {
    uint256 amount = 100e18;
    skip(_getInboundRefillTime(amount));

    bytes memory ethTokenPoolEncoded = abi.encode(address(ETH_TOKEN_POOL));

    vm.prank(address(_localInboundLaneFromRemote()));
    vm.expectRevert(abi.encodeWithSelector(InvalidSourcePoolAddress.selector, ethTokenPoolEncoded));
    LOCAL_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: REMOTE_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(LOCAL_GHO_TOKEN),
        sourcePoolAddress: ethTokenPoolEncoded,
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );

    bytes memory remoteTokenPoolEncoded = abi.encode(address(REMOTE_TOKEN_POOL));

    vm.prank(address(_localInboundLaneFromEth()));
    vm.expectRevert(
      abi.encodeWithSelector(InvalidSourcePoolAddress.selector, remoteTokenPoolEncoded)
    );
    LOCAL_TOKEN_POOL.releaseOrMint(
      IPool_CCIP.ReleaseOrMintInV1({
        originalSender: abi.encode(alice),
        remoteChainSelector: ETH_CHAIN_SELECTOR,
        receiver: alice,
        amount: amount,
        localToken: address(LOCAL_GHO_TOKEN),
        sourcePoolAddress: remoteTokenPoolEncoded,
        sourcePoolData: new bytes(0),
        offchainTokenData: new bytes(0)
      })
    );
  }
}
