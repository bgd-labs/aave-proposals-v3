// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IUpgradeableLockReleaseTokenPool_1_4, IUpgradeableLockReleaseTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableLockReleaseTokenPool.sol';
import {IUpgradeableBurnMintTokenPool_1_4, IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IEVM2EVMOnRamp} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {IEVM2EVMOffRamp_1_5} from 'src/interfaces/ccip/IEVM2EVMOffRamp.sol';
import {ITokenAdminRegistry} from 'src/interfaces/ccip/ITokenAdminRegistry.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {UpgradeableLockReleaseTokenPool} from 'aave-ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {UpgradeableBurnMintTokenPool} from 'aave-ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';
import {UpgradeableGhoToken} from 'gho-core/gho/UpgradeableGhoToken.sol';
import {GhoCcipSteward} from 'gho-core/misc/GhoCcipSteward.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {CCIPUtils} from './utils/CCIPUtils.sol';
import {AaveV3Arbitrum_GHOBaseLaunch_20241223} from './AaveV3Arbitrum_GHOBaseLaunch_20241223.sol';
import {AaveV3Base_GHOBaseLaunch_20241223} from './AaveV3Base_GHOBaseLaunch_20241223.sol';
import {AaveV3Ethereum_GHOBaseLaunch_20241223} from './AaveV3Ethereum_GHOBaseLaunch_20241223.sol';

import {AaveV3Arbitrum_GHOCCIP151Upgrade_20241209} from '../20241209_Multi_GHOCCIP151Upgrade/AaveV3Arbitrum_GHOCCIP151Upgrade_20241209.sol';
import {AaveV3Ethereum_GHOCCIP151Upgrade_20241209} from '../20241209_Multi_GHOCCIP151Upgrade/AaveV3Ethereum_GHOCCIP151Upgrade_20241209.sol';

/**
 * @dev Test for AaveV3Base_GHOBaseLaunch_20241223
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20241223_Multi_GHOBaseLaunch/AaveV3E2E_GHOBaseLaunch_20241223.t.sol -vv
 */
contract AaveV3Base_GHOBaseLaunch_20241223_Base is ProtocolV3TestBase {
  struct Common {
    IRouter router;
    IGhoToken token;
    IEVM2EVMOnRamp arbOnRamp;
    IEVM2EVMOnRamp baseOnRamp;
    IEVM2EVMOnRamp ethOnRamp;
    IEVM2EVMOffRamp_1_5 arbOffRamp;
    IEVM2EVMOffRamp_1_5 baseOffRamp;
    IEVM2EVMOffRamp_1_5 ethOffRamp;
    ITokenAdminRegistry tokenAdminRegistry;
    uint64 chainSelector;
    uint256 forkId;
  }

  struct CCIPSendParams {
    Common src;
    Common dst;
    uint256 amount;
    address sender;
  }

  struct ARB {
    AaveV3Arbitrum_GHOBaseLaunch_20241223 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 tokenPool;
    Common c;
  }
  struct BASE {
    AaveV3Base_GHOBaseLaunch_20241223 proposal;
    IUpgradeableBurnMintTokenPool_1_5_1 tokenPool;
    Common c;
  }
  struct ETH {
    AaveV3Ethereum_GHOBaseLaunch_20241223 proposal;
    IUpgradeableLockReleaseTokenPool_1_5_1 tokenPool;
    Common c;
  }

  ARB internal arb;
  BASE internal base;
  ETH internal eth;

  address internal alice = makeAddr('alice');
  address internal bob = makeAddr('bob');
  address internal carol = makeAddr('carol');

  address internal constant RMN_PROXY_BASE = 0xC842c69d54F83170C42C4d556B4F6B2ca53Dd3E8;
  address internal constant ROUTER_BASE = 0x881e3A65B4d4a04dD529061dd0071cf975F58bCD;

  event CCIPSendRequested(IInternal.EVM2EVMMessage message);
  event Locked(address indexed sender, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);

  function setUp() public virtual {
    arb.c.forkId = vm.createFork(vm.rpcUrl('arbitrum'), 287752362);
    base.c.forkId = vm.createFork(vm.rpcUrl('base'), 24072751);
    eth.c.forkId = vm.createFork(vm.rpcUrl('mainnet'), 21463360);

    arb.c.tokenAdminRegistry = ITokenAdminRegistry(0x39AE1032cF4B334a1Ed41cdD0833bdD7c7E7751E);
    arb.c.token = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);
    eth.c.tokenAdminRegistry = ITokenAdminRegistry(0xb22764f98dD05c789929716D677382Df22C05Cb6);
    eth.c.token = IGhoToken(MiscEthereum.GHO_TOKEN);
    (address newTokenPoolEth, address newTokenPoolArb) = _upgradeEthArbTo1_5_1();

    arb.c.chainSelector = 4949039107694359620;
    base.c.chainSelector = 15971525489660198786;
    eth.c.chainSelector = 5009297550715157269;

    vm.selectFork(base.c.forkId);
    address ghoTokenImplBase = _deployGhoTokenImpl();
    address ghoTokenBase = _computeCreateAddress(GovernanceV3Base.EXECUTOR_LVL_1);
    address newTokenPoolBase = _deployNewBurnMintTokenPool(
      ghoTokenBase,
      RMN_PROXY_BASE,
      ROUTER_BASE,
      GovernanceV3Base.EXECUTOR_LVL_1, // owner
      MiscBase.PROXY_ADMIN
    );
    address ghoCcipStewardBase = _deployNewGhoCcipSteward(
      newTokenPoolBase,
      ghoTokenBase,
      GovernanceV3Base.EXECUTOR_LVL_1, // riskCouncil, using executor for convenience
      false // bridgeLimitEnabled, *not present* in remote (burnMint) pools
    );

    vm.selectFork(arb.c.forkId);
    arb.proposal = new AaveV3Arbitrum_GHOBaseLaunch_20241223(
      newTokenPoolArb,
      newTokenPoolBase,
      ghoTokenBase
    );
    arb.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(newTokenPoolArb);
    arb.c.router = IRouter(arb.tokenPool.getRouter());
    arb.c.baseOnRamp = IEVM2EVMOnRamp(arb.c.router.getOnRamp(base.c.chainSelector));
    arb.c.ethOnRamp = IEVM2EVMOnRamp(arb.c.router.getOnRamp(eth.c.chainSelector));
    arb.c.baseOffRamp = IEVM2EVMOffRamp_1_5(0xb62178f8198905D0Fa6d640Bdb188E4E8143Ac4b);
    arb.c.ethOffRamp = IEVM2EVMOffRamp_1_5(0x91e46cc5590A4B9182e47f40006140A7077Dec31);

    vm.selectFork(base.c.forkId);
    base.proposal = new AaveV3Base_GHOBaseLaunch_20241223(
      newTokenPoolBase,
      ghoTokenImplBase,
      ghoCcipStewardBase,
      newTokenPoolEth,
      newTokenPoolArb
    );
    base.tokenPool = IUpgradeableBurnMintTokenPool_1_5_1(newTokenPoolBase);
    base.c.tokenAdminRegistry = ITokenAdminRegistry(0x6f6C373d09C07425BaAE72317863d7F6bb731e37);
    base.c.token = IGhoToken(ghoTokenBase);
    base.c.router = IRouter(base.tokenPool.getRouter());
    base.c.arbOnRamp = IEVM2EVMOnRamp(base.c.router.getOnRamp(arb.c.chainSelector));
    base.c.ethOnRamp = IEVM2EVMOnRamp(base.c.router.getOnRamp(eth.c.chainSelector));
    base.c.arbOffRamp = IEVM2EVMOffRamp_1_5(0x7D38c6363d5E4DFD500a691Bc34878b383F58d93);
    base.c.ethOffRamp = IEVM2EVMOffRamp_1_5(0xCA04169671A81E4fB8768cfaD46c347ae65371F1);

    vm.selectFork(eth.c.forkId);
    eth.proposal = new AaveV3Ethereum_GHOBaseLaunch_20241223(
      newTokenPoolEth,
      newTokenPoolBase,
      ghoTokenBase
    );
    eth.tokenPool = IUpgradeableLockReleaseTokenPool_1_5_1(newTokenPoolEth);
    eth.c.router = IRouter(eth.tokenPool.getRouter());
    eth.c.arbOnRamp = IEVM2EVMOnRamp(eth.c.router.getOnRamp(arb.c.chainSelector));
    eth.c.baseOnRamp = IEVM2EVMOnRamp(eth.c.router.getOnRamp(base.c.chainSelector));
    eth.c.arbOffRamp = IEVM2EVMOffRamp_1_5(0xdf615eF8D4C64d0ED8Fd7824BBEd2f6a10245aC9);
    eth.c.baseOffRamp = IEVM2EVMOffRamp_1_5(0x6B4B6359Dd5B47Cdb030E5921456D2a0625a9EbD);

    _performCLLPreReq(base.c, GovernanceV3Base.EXECUTOR_LVL_1);

    _validateConstants({executed: false});
  }

  function _upgradeEthArbTo1_5_1() internal returns (address, address) {
    // deploy new token pools and ghoCcipStewards
    vm.selectFork(eth.c.forkId);
    IUpgradeableLockReleaseTokenPool_1_4 existingPoolEth = IUpgradeableLockReleaseTokenPool_1_4(
      MiscEthereum.GHO_CCIP_TOKEN_POOL
    );
    address newTokenPoolEth = _deployNewLockReleaseTokenPool(
      MiscEthereum.GHO_TOKEN,
      existingPoolEth.getArmProxy(),
      existingPoolEth.getRouter(),
      existingPoolEth.getBridgeLimit(),
      GovernanceV3Ethereum.EXECUTOR_LVL_1, // owner
      MiscEthereum.PROXY_ADMIN
    );
    address newGhoCcipStewardEth = _deployNewGhoCcipSteward(
      newTokenPoolEth,
      MiscEthereum.GHO_TOKEN,
      GovernanceV3Ethereum.EXECUTOR_LVL_1, // riskAdmin, set as executor for convenience
      true // bridgeLimitEnabled
    );

    vm.selectFork(arb.c.forkId);
    IUpgradeableBurnMintTokenPool_1_4 existingPoolArb = IUpgradeableBurnMintTokenPool_1_4(
      MiscArbitrum.GHO_CCIP_TOKEN_POOL
    );
    address newTokenPoolArb = _deployNewBurnMintTokenPool(
      AaveV3ArbitrumAssets.GHO_UNDERLYING,
      existingPoolArb.getArmProxy(),
      existingPoolArb.getRouter(),
      GovernanceV3Arbitrum.EXECUTOR_LVL_1, // owner
      MiscArbitrum.PROXY_ADMIN
    );
    address newGhoCcipStewardArb = _deployNewGhoCcipSteward(
      newTokenPoolArb,
      AaveV3ArbitrumAssets.GHO_UNDERLYING,
      GovernanceV3Arbitrum.EXECUTOR_LVL_1, // riskAdmin, set as executor for convenience
      false // bridgeLimitEnabled
    );

    // execute CLL pre-requisites for the proposal
    _performCLLPreReq(eth.c, GovernanceV3Ethereum.EXECUTOR_LVL_1);
    _performCLLPreReq(arb.c, GovernanceV3Arbitrum.EXECUTOR_LVL_1);

    // execute proposal
    {
      vm.selectFork(eth.c.forkId);
      executePayload(
        vm,
        address(
          new AaveV3Ethereum_GHOCCIP151Upgrade_20241209(
            newTokenPoolEth,
            newTokenPoolArb,
            newGhoCcipStewardEth
          )
        )
      );

      vm.selectFork(arb.c.forkId);
      executePayload(
        vm,
        address(
          new AaveV3Arbitrum_GHOCCIP151Upgrade_20241209(
            newTokenPoolArb,
            newTokenPoolEth,
            newGhoCcipStewardArb
          )
        )
      );
    }

    return (newTokenPoolEth, newTokenPoolArb);
  }

  function _deployGhoTokenImpl() internal returns (address) {
    return address(new UpgradeableGhoToken());
  }

  function _computeCreateAddress(address deployer) internal view returns (address) {
    return vm.computeCreateAddress(deployer, vm.getNonce(deployer));
  }

  function _deployNewBurnMintTokenPool(
    address ghoToken,
    address rmnProxy,
    address router,
    address owner,
    address proxyAdmin
  ) private returns (address) {
    address newTokenPoolImpl = address(
      new UpgradeableBurnMintTokenPool(
        ghoToken,
        18, // optimistic token deployment for base, hence hardcoding 18 decimals for ghoToken
        rmnProxy,
        false // allowListEnabled
      )
    );

    return
      address(
        new TransparentUpgradeableProxy(
          newTokenPoolImpl,
          address(proxyAdmin),
          abi.encodeCall(
            IUpgradeableBurnMintTokenPool_1_5_1.initialize,
            (
              owner,
              new address[](0), // allowList
              router
            )
          )
        )
      );
  }

  function _deployNewLockReleaseTokenPool(
    address ghoToken,
    address rmnProxy,
    address router,
    uint256 bridgeLimit,
    address owner,
    address proxyAdmin
  ) private returns (address) {
    address newTokenPoolImpl = address(
      new UpgradeableLockReleaseTokenPool(
        ghoToken,
        18, // optimistic token deployment for base, hence hardcoding 18 decimals for ghoToken
        rmnProxy,
        false, // allowListEnabled
        true // acceptLiquidity
      )
    );

    return
      address(
        new TransparentUpgradeableProxy(
          newTokenPoolImpl,
          address(proxyAdmin),
          abi.encodeCall(
            IUpgradeableLockReleaseTokenPool_1_5_1.initialize,
            (
              owner,
              new address[](0), // allowList
              router,
              bridgeLimit
            )
          )
        )
      );
  }

  function _performCLLPreReq(Common memory c, address newAdmin) internal {
    vm.selectFork(c.forkId);

    vm.prank(c.tokenAdminRegistry.owner());
    if (c.forkId == base.c.forkId) {
      c.tokenAdminRegistry.proposeAdministrator(address(c.token), newAdmin);
    } else {
      c.tokenAdminRegistry.transferAdminRole(address(c.token), newAdmin);
    }
  }

  function _deployNewGhoCcipSteward(
    address newTokenPool,
    address ghoToken,
    address riskCouncil,
    bool bridgeLimitEnabled
  ) internal returns (address) {
    return address(new GhoCcipSteward(ghoToken, newTokenPool, riskCouncil, bridgeLimitEnabled));
  }

  function _getTokenMessage(
    CCIPSendParams memory params
  ) internal returns (IClient.EVM2AnyMessage memory, IInternal.EVM2EVMMessage memory) {
    IClient.EVM2AnyMessage memory message = CCIPUtils.generateMessage(params.sender, 1);
    message.tokenAmounts[0] = IClient.EVMTokenAmount({
      token: address(params.src.token),
      amount: params.amount
    });

    uint256 feeAmount = params.src.router.getFee(params.dst.chainSelector, message);
    deal(params.sender, feeAmount);

    IInternal.EVM2EVMMessage memory eventArg = CCIPUtils.messageToEvent(
      CCIPUtils.MessageToEventParams({
        message: message,
        router: params.src.router,
        sourceChainSelector: params.src.chainSelector,
        destChainSelector: params.dst.chainSelector,
        feeTokenAmount: feeAmount,
        originalSender: params.sender,
        sourceToken: address(params.src.token),
        destinationToken: address(params.dst.token)
      })
    );

    return (message, eventArg);
  }

  // todo: expand
  function _validateConstants(bool executed) internal {
    if (executed) {
      vm.selectFork(base.c.forkId);
      assertEq(base.proposal.REMOTE_TOKEN_POOL_ETH(), address(eth.tokenPool));
      assertEq(base.proposal.REMOTE_TOKEN_POOL_ARB(), address(arb.tokenPool));
      assertTrue(
        base.tokenPool.isRemotePool(eth.c.chainSelector, abi.encode(address(eth.tokenPool)))
      );
      assertTrue(
        base.tokenPool.isRemotePool(arb.c.chainSelector, abi.encode(address(arb.tokenPool)))
      );
    }
  }
}

contract AaveV3Base_GHOBaseLaunch_20241223_PostExecution is AaveV3Base_GHOBaseLaunch_20241223_Base {
  function setUp() public override {
    super.setUp();

    vm.selectFork(arb.c.forkId);
    executePayload(vm, address(arb.proposal));

    vm.selectFork(eth.c.forkId);
    executePayload(vm, address(eth.proposal));

    vm.selectFork(base.c.forkId);
    executePayload(vm, address(base.proposal));

    _validateConstants({executed: true});
  }

  function test_E2E_Eth_Base(uint256 amount) public {
    {
      vm.selectFork(eth.c.forkId);
      uint256 bridgeableAmount = eth.tokenPool.getBridgeLimit() -
        eth.tokenPool.getCurrentBridgedAmount();
      amount = bound(amount, 1, bridgeableAmount);

      vm.prank(alice);
      eth.c.token.approve(address(eth.c.router), amount);
      deal(address(eth.c.token), alice, amount);

      uint256 tokenPoolBalance = eth.c.token.balanceOf(address(eth.tokenPool));
      uint256 aliceBalance = eth.c.token.balanceOf(alice);
      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: eth.c, dst: base.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(eth.tokenPool));
      emit Locked(address(eth.c.baseOnRamp), amount);
      vm.expectEmit(address(eth.c.baseOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      eth.c.router.ccipSend{value: eventArg.feeTokenAmount}(base.c.chainSelector, message);

      assertEq(eth.c.token.balanceOf(address(eth.tokenPool)), tokenPoolBalance + amount);
      assertEq(eth.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount + amount);

      // base execute message
      vm.selectFork(base.c.forkId);

      assertEq(base.c.token.balanceOf(alice), 0);
      assertEq(base.c.token.totalSupply(), 0); // first bridge
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(base.tokenPool));
      emit Minted(address(base.c.ethOffRamp), alice, amount);

      vm.prank(address(base.c.ethOffRamp));
      base.c.ethOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(base.c.token.balanceOf(alice), amount);
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, amount);
    }

    // send amount back to eth
    {
      // send base from base
      vm.selectFork(base.c.forkId);
      vm.prank(alice);
      base.c.token.approve(address(base.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: base.c, dst: eth.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(base.tokenPool));
      emit Burned(address(base.c.ethOnRamp), amount);
      vm.expectEmit(address(base.c.ethOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      base.c.router.ccipSend{value: eventArg.feeTokenAmount}(eth.c.chainSelector, message);

      assertEq(base.c.token.balanceOf(alice), 0);
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, 0);

      // eth execute message
      vm.selectFork(eth.c.forkId);

      uint256 bridgedAmount = eth.tokenPool.getCurrentBridgedAmount();

      vm.expectEmit(address(eth.tokenPool));
      emit Released(address(eth.c.baseOffRamp), alice, amount);
      vm.prank(address(eth.c.baseOffRamp));
      eth.c.baseOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(eth.c.token.balanceOf(alice), amount);
      assertEq(eth.tokenPool.getCurrentBridgedAmount(), bridgedAmount - amount);
    }
  }

  function test_E2E_Arb_Base(uint256 amount) public {
    {
      vm.selectFork(arb.c.forkId);
      uint256 bridgeableAmount = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;
      amount = bound(amount, 1, bridgeableAmount);

      vm.prank(alice);
      arb.c.token.approve(address(arb.c.router), amount);
      deal(address(arb.c.token), alice, amount);

      uint256 aliceBalance = arb.c.token.balanceOf(alice);
      uint256 facilitatorLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: arb.c, dst: base.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(arb.tokenPool));
      emit Burned(address(arb.c.baseOnRamp), amount);
      vm.expectEmit(address(arb.c.baseOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      arb.c.router.ccipSend{value: eventArg.feeTokenAmount}(base.c.chainSelector, message);

      assertEq(arb.c.token.balanceOf(alice), aliceBalance - amount);
      assertEq(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        facilitatorLevel - amount
      );

      // base execute message
      vm.selectFork(base.c.forkId);

      assertEq(base.c.token.balanceOf(alice), 0);
      assertEq(base.c.token.totalSupply(), 0); // first bridge
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, 0); // first bridge

      vm.expectEmit(address(base.tokenPool));
      emit Minted(address(base.c.arbOffRamp), alice, amount);

      vm.prank(address(base.c.arbOffRamp));
      base.c.arbOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(base.c.token.balanceOf(alice), amount);
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, amount);
    }

    // send amount back to arb
    {
      // send base from base
      vm.selectFork(base.c.forkId);
      vm.prank(alice);
      base.c.token.approve(address(base.c.router), amount);

      (
        IClient.EVM2AnyMessage memory message,
        IInternal.EVM2EVMMessage memory eventArg
      ) = _getTokenMessage(
          CCIPSendParams({src: base.c, dst: arb.c, sender: alice, amount: amount})
        );

      vm.expectEmit(address(base.tokenPool));
      emit Burned(address(base.c.arbOnRamp), amount);
      vm.expectEmit(address(base.c.arbOnRamp));
      emit CCIPSendRequested(eventArg);

      vm.prank(alice);
      base.c.router.ccipSend{value: eventArg.feeTokenAmount}(arb.c.chainSelector, message);

      assertEq(base.c.token.balanceOf(alice), 0);
      assertEq(base.c.token.getFacilitator(address(base.tokenPool)).bucketLevel, 0);

      // arb execute message
      vm.selectFork(arb.c.forkId);

      uint256 facilitatorLevel = arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel;

      vm.expectEmit(address(arb.tokenPool));
      emit Minted(address(arb.c.baseOffRamp), alice, amount);
      vm.prank(address(arb.c.baseOffRamp));
      arb.c.baseOffRamp.executeSingleMessage({
        message: eventArg,
        offchainTokenData: new bytes[](message.tokenAmounts.length),
        tokenGasOverrides: new uint32[](0)
      });

      assertEq(arb.c.token.balanceOf(alice), amount);
      assertEq(
        arb.c.token.getFacilitator(address(arb.tokenPool)).bucketLevel,
        facilitatorLevel + amount
      );
    }
  }
}
