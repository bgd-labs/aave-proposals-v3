// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GhoCCIPChains} from '../constants/GhoCCIPChains.sol';
import {AaveV3GHORemoteLaneTest_PreExecution, BaseAaveV3GHORemoteLaneTest_PostExecution} from './AaveV3GHORemoteLaneTest.sol';
import {IPool as IPool_CCIP} from 'src/interfaces/ccip/tokenPool/IPool.sol';
import {IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRateLimiter} from 'src/interfaces/ccip/IRateLimiter.sol';
import {IOnRamp_1_6} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {GhoCCIPChains} from '../constants/GhoCCIPChains.sol';

abstract contract AaveV3GHOEthereumRemoteLaneTest_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor(
    GhoCCIPChains.ChainInfo memory remoteChainInfo,
    uint256 blockNumber
  )
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.ETHEREUM(),
      remoteChainInfo,
      'mainnet',
      blockNumber
    )
  {}

  function _expectedLocalTokenPoolTypeAndVersion()
    internal
    view
    virtual
    override
    returns (string memory)
  {
    return 'LockReleaseTokenPool 1.5.1';
  }

  function _assertOnAndOffRamps() internal view virtual override {
    _assertOnRamp(
      _localOutboundLaneToRemote(),
      LOCAL_CHAIN_SELECTOR,
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOffRamp(
      _localInboundLaneFromRemote(),
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
  }

  function _assertAgainstSupportedChain(
    GhoCCIPChains.ChainInfo memory supportedChain
  ) internal virtual override {
    if (supportedChain.chainSelector == GhoCCIPChains.ARBITRUM().chainSelector) {
      assertEq(
        LOCAL_TOKEN_POOL.getRemoteToken(supportedChain.chainSelector),
        abi.encode(supportedChain.ghoToken),
        'Remote token mismatch for supported chain'
      );

      assertEq(
        LOCAL_TOKEN_POOL.getRemotePools(supportedChain.chainSelector)[1],
        abi.encode(supportedChain.ghoCCIPTokenPool),
        'Remote pool mismatch for supported chain'
      );
    } else {
      super._assertAgainstSupportedChain(supportedChain);
    }
  }
}

abstract contract BaseAaveV3GHOEthereumRemoteLaneTest_PostExecution is
  BaseAaveV3GHORemoteLaneTest_PostExecution
{
  event Locked(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);

  constructor(
    GhoCCIPChains.ChainInfo memory remoteChainInfo,
    uint256 blockNumber
  )
    BaseAaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.ETHEREUM(),
      remoteChainInfo,
      'mainnet',
      blockNumber
    )
  {}

  function _getLocalOutboundLaneToRemoteAddress() internal view virtual override returns (address) {
    return address(_localOutboundLaneToRemote());
  }

  function _getLocalInboundLaneFromRemoteAddress()
    internal
    view
    virtual
    override
    returns (address)
  {
    return address(_localInboundLaneFromRemote());
  }

  function _expectedLocalTokenPoolTypeAndVersion()
    internal
    view
    virtual
    override
    returns (string memory)
  {
    return 'LockReleaseTokenPool 1.5.1';
  }

  function _assertAgainstSupportedChain(
    GhoCCIPChains.ChainInfo memory supportedChain
  ) internal view virtual override {
    if (supportedChain.chainSelector == GhoCCIPChains.ARBITRUM().chainSelector) {
      assertEq(
        LOCAL_TOKEN_POOL.getRemoteToken(supportedChain.chainSelector),
        abi.encode(supportedChain.ghoToken),
        'Remote token mismatch for supported chain'
      );

      assertEq(
        LOCAL_TOKEN_POOL.getRemotePools(supportedChain.chainSelector).length,
        2,
        'Amount of remote pools mismatch for supported chain'
      );

      assertEq(
        LOCAL_TOKEN_POOL.getRemotePools(supportedChain.chainSelector)[1],
        abi.encode(supportedChain.ghoCCIPTokenPool),
        'Remote pool mismatch for supported chain'
      );
    } else {
      super._assertAgainstSupportedChain(supportedChain);
    }
  }

  function _assertOnAndOffRamps() internal view virtual override {
    _assertOnRamp(
      _localOutboundLaneToRemote(),
      LOCAL_CHAIN_SELECTOR,
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOffRamp(
      _localInboundLaneFromRemote(),
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
  }

  function test_cannotOffRampOtherChainMessages() public virtual override {
    uint256 amount = 100e18;
    skip(_getInboundRefillTime(amount));

    bytes memory ethTokenPoolEncoded = abi.encode(address(ETH_TOKEN_POOL));

    vm.prank(_getLocalInboundLaneFromRemoteAddress());
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
  }

  function test_offRampViaRemoteChainSucceeds(uint256 amount) public virtual override {
    uint256 bridgeableAmount = _min(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      _ccipRateLimitCapacity()
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getInboundRefillTime(amount));

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);
    uint256 poolBalance = LOCAL_GHO_TOKEN.balanceOf(address(LOCAL_TOKEN_POOL));
    uint256 currentBridgedAmount = IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL))
      .getCurrentBridgedAmount();

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Released(_getLocalInboundLaneFromRemoteAddress(), alice, amount);

    vm.prank(_getLocalInboundLaneFromRemoteAddress());
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

    assertEq(LOCAL_GHO_TOKEN.balanceOf(address(LOCAL_TOKEN_POOL)), poolBalance - amount);
    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance + amount);
    assertEq(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      currentBridgedAmount - amount
    );
    assertEq(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      LOCAL_GHO_TOKEN.balanceOf(address(LOCAL_TOKEN_POOL))
    );
  }
}

abstract contract AaveV3GHOEthereumRemoteLaneTest_PostExecution is
  BaseAaveV3GHOEthereumRemoteLaneTest_PostExecution
{
  constructor(
    GhoCCIPChains.ChainInfo memory remoteChainInfo,
    uint256 blockNumber
  ) BaseAaveV3GHOEthereumRemoteLaneTest_PostExecution(remoteChainInfo, blockNumber) {}

  function test_sendMessageToRemoteChainSucceeds(uint256 amount) public virtual override {
    uint256 bridgeableAmount = _min(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getBridgeLimit() -
        IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      _ccipRateLimitCapacity()
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(LOCAL_GHO_TOKEN), alice, amount);
    vm.prank(alice);
    LOCAL_GHO_TOKEN.approve(address(LOCAL_CCIP_ROUTER), amount);

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);
    uint256 currentBridgedAmount = IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL))
      .getCurrentBridgedAmount();

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
    emit Locked(address(_localOutboundLaneToRemote()), amount);
    vm.expectEmit(address(_localOutboundLaneToRemote()));
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    LOCAL_CCIP_ROUTER.ccipSend{value: eventArg.feeTokenAmount}(REMOTE_CHAIN_SELECTOR, message);

    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      currentBridgedAmount + amount
    );
  }

  function test_sendMessageToSupportedChainSucceeds(
    uint256 amount,
    uint8 chainIndex
  ) public virtual {
    GhoCCIPChains.ChainInfo[] memory supportedChains = _expectedSupportedChains(true);

    require(supportedChains.length > 0);

    chainIndex = uint8(bound(chainIndex, 0, supportedChains.length - 1));

    IRateLimiter.TokenBucket memory rateLimits = IUpgradeableLockReleaseTokenPool_1_5_1(
      address(LOCAL_TOKEN_POOL)
    ).getCurrentInboundRateLimiterState(supportedChains[chainIndex].chainSelector);
    uint256 bridgeableAmount = _min(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getBridgeLimit() -
        IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      rateLimits.capacity
    );

    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(LOCAL_GHO_TOKEN), alice, amount);
    vm.prank(alice);
    LOCAL_GHO_TOKEN.approve(address(LOCAL_CCIP_ROUTER), amount);

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);
    uint256 currentBridgedAmount = IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL))
      .getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory eventArg
    ) = _getTokenMessage(
        CCIPSendParams({
          amount: amount,
          sender: alice,
          destChainSelector: supportedChains[chainIndex].chainSelector,
          destToken: supportedChains[chainIndex].ghoToken
        })
      );

    address onRamp = LOCAL_CCIP_ROUTER.getOnRamp(supportedChains[chainIndex].chainSelector);

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Locked(onRamp, amount);
    vm.expectEmit(onRamp);
    emit CCIPSendRequested(eventArg);

    vm.prank(alice);
    LOCAL_CCIP_ROUTER.ccipSend{value: eventArg.feeTokenAmount}(
      supportedChains[chainIndex].chainSelector,
      message
    );

    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      currentBridgedAmount + amount
    );
  }
}

abstract contract AaveV3GHOEthereumRemoteLane_1_6_Test_PostExecution is
  BaseAaveV3GHOEthereumRemoteLaneTest_PostExecution
{
  event CCIPMessageSent(
    uint64 indexed destChainSelector,
    uint64 indexed sequenceNumber,
    IInternal.EVM2AnyRampMessage message
  );

  constructor(
    GhoCCIPChains.ChainInfo memory remoteChainInfo,
    uint256 blockNumber
  ) BaseAaveV3GHOEthereumRemoteLaneTest_PostExecution(remoteChainInfo, blockNumber) {}

  function _getLocalOutboundLaneToRemoteAddress() internal view override returns (address) {
    return address(_localOutboundLaneToRemote_1_6());
  }

  function _getLocalInboundLaneFromRemoteAddress() internal view override returns (address) {
    return address(_localInboundLaneFromRemote_1_6());
  }

  function test_sendMessageToRemoteChainSucceeds(uint256 amount) public virtual override {
    uint256 bridgeableAmount = _min(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getBridgeLimit() -
        IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      _ccipRateLimitCapacity()
    );
    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(LOCAL_GHO_TOKEN), alice, amount);
    vm.prank(alice);
    LOCAL_GHO_TOKEN.approve(address(LOCAL_CCIP_ROUTER), amount);

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);
    uint256 currentBridgedAmount = IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL))
      .getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2AnyRampMessage memory eventArg
    ) = _getTokenMessage_1_6(
        CCIPSendParams({
          amount: amount,
          sender: alice,
          destChainSelector: REMOTE_CHAIN_SELECTOR,
          destToken: address(REMOTE_GHO_TOKEN)
        })
      );

    IOnRamp_1_6 onRamp = IOnRamp_1_6(LOCAL_CCIP_ROUTER.getOnRamp(REMOTE_CHAIN_SELECTOR));
    uint64 sequenceNumber = onRamp.getExpectedNextSequenceNumber(REMOTE_CHAIN_SELECTOR);

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Locked(address(_localOutboundLaneToRemote()), amount);
    vm.expectEmit(address(_localOutboundLaneToRemote()));
    emit CCIPMessageSent(REMOTE_CHAIN_SELECTOR, sequenceNumber, eventArg);

    vm.prank(alice);
    LOCAL_CCIP_ROUTER.ccipSend(REMOTE_CHAIN_SELECTOR, message);

    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      currentBridgedAmount + amount
    );
  }

  function test_sendMessage_1_6_ToSupportedChainSucceeds(
    uint256 amount,
    uint8 chainIndex
  ) public virtual {
    GhoCCIPChains.ChainInfo[] memory supportedChains = GhoCCIPChains.getAll_1_6_ChainsExcept(
      LOCAL_CHAIN_SELECTOR
    );

    require(supportedChains.length > 0);

    chainIndex = uint8(bound(chainIndex, 0, supportedChains.length - 1));

    IRateLimiter.TokenBucket memory rateLimits = IUpgradeableLockReleaseTokenPool_1_5_1(
      address(LOCAL_TOKEN_POOL)
    ).getCurrentInboundRateLimiterState(supportedChains[chainIndex].chainSelector);
    uint256 bridgeableAmount = _min(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getBridgeLimit() -
        IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      rateLimits.capacity
    );

    amount = bound(amount, 1, bridgeableAmount);
    skip(_getOutboundRefillTime(amount)); // wait for the rate limiter to refill

    deal(address(LOCAL_GHO_TOKEN), alice, amount);
    vm.prank(alice);
    LOCAL_GHO_TOKEN.approve(address(LOCAL_CCIP_ROUTER), amount);

    uint256 aliceBalance = LOCAL_GHO_TOKEN.balanceOf(alice);
    uint256 currentBridgedAmount = IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL))
      .getCurrentBridgedAmount();

    (
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2AnyRampMessage memory eventArg
    ) = _getTokenMessage_1_6(
        CCIPSendParams({
          amount: amount,
          sender: alice,
          destChainSelector: supportedChains[chainIndex].chainSelector,
          destToken: supportedChains[chainIndex].ghoToken
        })
      );

    IOnRamp_1_6 onRamp = IOnRamp_1_6(
      LOCAL_CCIP_ROUTER.getOnRamp(supportedChains[chainIndex].chainSelector)
    );
    uint64 sequenceNumber = onRamp.getExpectedNextSequenceNumber(
      supportedChains[chainIndex].chainSelector
    );

    vm.expectEmit(address(LOCAL_TOKEN_POOL));
    emit Locked(address(onRamp), amount);
    vm.expectEmit(address(onRamp));
    emit CCIPMessageSent(REMOTE_CHAIN_SELECTOR, sequenceNumber, eventArg);

    vm.prank(alice);
    LOCAL_CCIP_ROUTER.ccipSend(supportedChains[chainIndex].chainSelector, message);

    assertEq(LOCAL_GHO_TOKEN.balanceOf(alice), aliceBalance - amount);
    assertEq(
      IUpgradeableLockReleaseTokenPool_1_5_1(address(LOCAL_TOKEN_POOL)).getCurrentBridgedAmount(),
      currentBridgedAmount + amount
    );
  }
}
