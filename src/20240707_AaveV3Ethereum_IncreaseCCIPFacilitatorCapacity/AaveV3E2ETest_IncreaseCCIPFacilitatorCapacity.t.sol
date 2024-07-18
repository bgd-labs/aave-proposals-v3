// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {RateLimiter} from 'ccip/v0.8/ccip/libraries/RateLimiter.sol';
import {Internal} from 'ccip/v0.8/ccip/libraries/Internal.sol';
import {Client} from 'ccip/v0.8/ccip/libraries/Client.sol';
import {Router} from 'ccip/v0.8/ccip/Router.sol';
import {PriceRegistry} from 'ccip/v0.8/ccip/PriceRegistry.sol';
import {EVM2EVMOnRamp} from 'ccip/v0.8/ccip/onRamp/EVM2EVMOnRamp.sol';
import {EVM2EVMOffRamp} from 'ccip/v0.8/ccip/offRamp/EVM2EVMOffRamp.sol';
import {IPool} from 'ccip/v0.8/ccip/interfaces/pools/IPool.sol';

import {UpgradeableLockReleaseTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableLockReleaseTokenPool.sol';
import {UpgradeableBurnMintTokenPool} from 'ccip/v0.8/ccip/pools/GHO/UpgradeableBurnMintTokenPool.sol';

import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';

import {AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707} from './AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707.sol';
import {AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707} from './AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707.sol';

/**
 * @dev Test for AaveV3E2E_GHOCrossChainLaunch_20240528
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240707_AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity/AaveV3E2ETest_IncreaseCCIPFacilitatorCapacity.t.sol -vv
 */
contract AaveV3E2ETest_IncreaseCCIPFacilitatorCapacity is ProtocolV3TestBase {
  using Internal for Internal.EVM2EVMMessage;

  AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707 internal arbProposal;
  AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707 internal ethProposal;

  UpgradeableLockReleaseTokenPool internal ETH_TOKEN_POOL =
    UpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL);
  UpgradeableBurnMintTokenPool internal ARB_TOKEN_POOL =
    UpgradeableBurnMintTokenPool(MiscArbitrum.GHO_CCIP_TOKEN_POOL);
  IGhoToken internal ETH_GHO;
  IGhoToken internal ARB_GHO;

  Router internal ETH_ROUTER = Router(0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D);
  Router internal ARB_ROUTER = Router(0x141fa059441E0ca23ce184B6A78bafD2A517DdE8);

  uint256 public constant CURRENT_CCIP_BUCKET_CAPACITY = 1_000_000e18; // 1M
  uint64 public constant ETH_ARB_CHAIN_SELECTOR = 4949039107694359620;
  uint64 public constant ARB_ETH_CHAIN_SELECTOR = 5009297550715157269;

  address internal constant CCIP_ETH_ON_RAMP = 0x925228D7B82d883Dde340A55Fe8e6dA56244A22C;
  address internal constant CCIP_ETH_OFF_RAMP = 0xeFC4a18af59398FF23bfe7325F2401aD44286F4d;
  address internal constant CCIP_ARB_ON_RAMP = 0xCe11020D56e5FDbfE46D9FC3021641FfbBB5AdEE;
  address internal constant CCIP_ARB_OFF_RAMP = 0x542ba1902044069330e8c5b36A84EC503863722f;

  event Released(address indexed sender, address indexed recipient, uint256 amount);
  event Locked(address indexed sender, uint256 amount);
  event Minted(address indexed sender, address indexed recipient, uint256 amount);
  event Burned(address indexed sender, uint256 amount);
  event CCIPSendRequested(Internal.EVM2EVMMessage message);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Initialized(uint8 version);

  uint256 internal ethereumFork;
  uint256 internal arbitrumFork;

  function setUp() public {
    ethereumFork = vm.createFork(vm.rpcUrl('mainnet'), 20330677);
    arbitrumFork = vm.createFork(vm.rpcUrl('arbitrum'), 233363817);

    // Proposal creation
    vm.selectFork(ethereumFork);
    ethProposal = new AaveV3Ethereum_IncreaseCCIPFacilitatorCapacity_20240707();
    ETH_GHO = IGhoToken(MiscEthereum.GHO_TOKEN);

    vm.selectFork(arbitrumFork);
    arbProposal = new AaveV3Arbitrum_IncreaseCCIPFacilitatorCapacity_20240707();
    ARB_GHO = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);
  }

  /// @dev Full E2E Test: transfer from Ethereum to Arbitrum and way back, with limit
  function test_ccipFullE2E() public {
    uint256 currentBridgedAmount = 1_000_000e18;

    vm.selectFork(arbitrumFork);

    assertEq(ARB_GHO.balanceOf(address(ARB_TOKEN_POOL)), 0);
    (uint256 capacity, uint256 level) = ARB_GHO.getFacilitatorBucket(address(ARB_TOKEN_POOL));
    assertEq(capacity, CURRENT_CCIP_BUCKET_CAPACITY);
    assertEq(level, currentBridgedAmount);

    // CCIP Transfer from Ethereum to Arbitrum
    // Ethereum execution (origin)
    vm.selectFork(ethereumFork);
    address user = makeAddr('user');
    uint256 amount = 500_000e18; // 500K ETH_GHO
    deal(user, 1e18); // 1 ETH
    deal(address(ETH_GHO), user, amount);

    assertEq(ETH_GHO.balanceOf(address(ETH_TOKEN_POOL)), currentBridgedAmount);
    assertEq(ETH_TOKEN_POOL.getBridgeLimit(), 1_000_000e18);
    assertEq(ETH_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount);

    vm.startPrank(user);
    SendCcipParams memory params = SendCcipParams({
      expectedSeqNum: 1,
      router: ETH_ROUTER,
      onRamp: CCIP_ETH_ON_RAMP,
      token: address(ETH_GHO),
      amount: amount,
      feeToken: address(0),
      sourceChainSelector: ARB_ETH_CHAIN_SELECTOR,
      destChainSelector: ETH_ARB_CHAIN_SELECTOR,
      sender: user,
      receiver: user
    });

    (
      Client.EVM2AnyMessage memory message,
      Internal.EVM2EVMMessage memory geEvent,
      uint256 expectedFee
    ) = _prepareCcip(params);

    vm.expectRevert(
      abi.encodeWithSelector(
        UpgradeableLockReleaseTokenPool.BridgeLimitExceeded.selector,
        1_000_000e18
      )
    );
    params.router.ccipSend{value: expectedFee}(params.destChainSelector, message);

    GovV3Helpers.executePayload(vm, address(ethProposal));

    vm.selectFork(arbitrumFork);
    GovV3Helpers.executePayload(vm, address(arbProposal));

    vm.selectFork(ethereumFork);

    assertEq(ETH_TOKEN_POOL.getBridgeLimit(), ethProposal.NEW_LIMIT());
    assertEq(ETH_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount);

    params.router.ccipSend{value: expectedFee}(params.destChainSelector, message);

    assertEq(ETH_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount + amount);

    // Arbitrum execution (destination)
    vm.selectFork(arbitrumFork);

    // Mock off ramp
    vm.startPrank(CCIP_ARB_OFF_RAMP);
    bytes[] memory emptyData = new bytes[](1);
    EVM2EVMOffRamp(CCIP_ARB_OFF_RAMP).executeSingleMessage(geEvent, emptyData);

    assertEq(ARB_GHO.balanceOf(address(ARB_TOKEN_POOL)), 0);
    (capacity, level) = ARB_GHO.getFacilitatorBucket(address(ARB_TOKEN_POOL));
    assertEq(capacity, arbProposal.NEW_LIMIT());
    assertEq(level, currentBridgedAmount + amount);

    // CCIP Transfer from Arbitrum to Ethereum
    // Arbitrum execution (origin)
    vm.selectFork(arbitrumFork);
    deal(user, 1e18); // 1 ETH

    vm.startPrank(user);
    // Use address(0) to use native token as fee token
    params = SendCcipParams({
      expectedSeqNum: 1,
      router: ARB_ROUTER,
      onRamp: CCIP_ARB_ON_RAMP,
      token: address(ARB_GHO),
      amount: amount,
      feeToken: address(0),
      sourceChainSelector: ETH_ARB_CHAIN_SELECTOR,
      destChainSelector: ARB_ETH_CHAIN_SELECTOR,
      sender: user,
      receiver: user
    });
    (message, geEvent, expectedFee) = _prepareCcip(params);
    params.router.ccipSend{value: expectedFee}(params.destChainSelector, message);

    assertEq(ARB_GHO.balanceOf(user), 0);
    assertEq(ARB_GHO.balanceOf(address(ARB_TOKEN_POOL)), 0);
    (capacity, level) = ARB_GHO.getFacilitatorBucket(address(ARB_TOKEN_POOL));
    assertEq(capacity, arbProposal.NEW_LIMIT());
    assertEq(level, currentBridgedAmount);

    // Ethereum execution (destination)
    vm.selectFork(ethereumFork);

    assertEq(ETH_GHO.balanceOf(user), 0);
    assertEq(ETH_GHO.balanceOf(address(ETH_TOKEN_POOL)), currentBridgedAmount + amount);
    assertEq(ETH_TOKEN_POOL.getBridgeLimit(), ethProposal.NEW_LIMIT());
    assertEq(ETH_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount + amount);

    // Mock off ramp
    vm.startPrank(CCIP_ETH_OFF_RAMP);
    EVM2EVMOffRamp(CCIP_ETH_OFF_RAMP).executeSingleMessage(geEvent, emptyData);

    assertEq(ETH_GHO.balanceOf(user), amount);
    assertEq(ETH_GHO.balanceOf(address(ETH_TOKEN_POOL)), currentBridgedAmount);
    assertEq(ETH_TOKEN_POOL.getBridgeLimit(), ethProposal.NEW_LIMIT());
    assertEq(ETH_TOKEN_POOL.getCurrentBridgedAmount(), currentBridgedAmount);
  }

  // ---
  // Utils
  // --

  struct SendCcipParams {
    uint64 expectedSeqNum;
    Router router;
    address onRamp;
    address token;
    uint256 amount;
    address feeToken;
    uint64 sourceChainSelector;
    uint64 destChainSelector;
    address sender;
    address receiver;
  }

  function _prepareCcip(
    SendCcipParams memory params
  ) internal returns (Client.EVM2AnyMessage memory, Internal.EVM2EVMMessage memory, uint256) {
    Client.EVM2AnyMessage memory message = _generateSingleTokenMessage(
      params.receiver,
      params.token,
      params.amount,
      params.feeToken
    );
    uint256 expectedFee = params.router.getFee(params.destChainSelector, message);

    bytes32 metadataHash = keccak256(
      abi.encode(
        Internal.EVM_2_EVM_MESSAGE_HASH,
        params.sourceChainSelector,
        params.destChainSelector,
        params.onRamp
      )
    );

    Internal.EVM2EVMMessage memory geEvent = _messageToEvent(
      message,
      params.expectedSeqNum,
      params.expectedSeqNum,
      expectedFee,
      params.sender,
      params.sourceChainSelector,
      metadataHash
    );

    IERC20(params.token).approve(address(params.router), params.amount);

    return (message, geEvent, expectedFee);
  }

  function _generateSingleTokenMessage(
    address receiver,
    address token,
    uint256 amount,
    address feeToken
  ) public pure returns (Client.EVM2AnyMessage memory) {
    Client.EVMTokenAmount[] memory tokenAmounts = new Client.EVMTokenAmount[](1);
    tokenAmounts[0] = Client.EVMTokenAmount({token: token, amount: amount});
    return
      Client.EVM2AnyMessage({
        receiver: abi.encode(receiver),
        data: '',
        tokenAmounts: tokenAmounts,
        feeToken: feeToken,
        extraArgs: Client._argsToBytes(Client.EVMExtraArgsV1({gasLimit: 200_000}))
      });
  }

  function _messageToEvent(
    Client.EVM2AnyMessage memory message,
    uint64 seqNum,
    uint64 nonce,
    uint256 feeTokenAmount,
    address originalSender,
    uint64 sourceChainSelector,
    bytes32 metadataHash
  ) public pure returns (Internal.EVM2EVMMessage memory) {
    // Slicing is only available for calldata. So we have to build a new bytes array.
    bytes memory args = new bytes(message.extraArgs.length - 4);
    for (uint256 i = 4; i < message.extraArgs.length; ++i) {
      args[i - 4] = message.extraArgs[i];
    }
    Client.EVMExtraArgsV1 memory extraArgs = abi.decode(args, (Client.EVMExtraArgsV1));
    Internal.EVM2EVMMessage memory messageEvent = Internal.EVM2EVMMessage({
      sequenceNumber: seqNum,
      feeTokenAmount: feeTokenAmount,
      sender: originalSender,
      nonce: nonce,
      gasLimit: extraArgs.gasLimit,
      strict: false,
      sourceChainSelector: sourceChainSelector,
      receiver: abi.decode(message.receiver, (address)),
      data: message.data,
      tokenAmounts: message.tokenAmounts,
      sourceTokenData: new bytes[](message.tokenAmounts.length),
      feeToken: message.feeToken,
      messageId: ''
    });

    messageEvent.messageId = Internal._hash(messageEvent, metadataHash);
    return messageEvent;
  }

  function _getTokensAndPools(
    address[] memory tokens,
    IPool[] memory pools
  ) internal pure returns (Internal.PoolUpdate[] memory) {
    Internal.PoolUpdate[] memory tokensAndPools = new Internal.PoolUpdate[](tokens.length);
    for (uint256 i = 0; i < tokens.length; ++i) {
      tokensAndPools[i] = Internal.PoolUpdate({token: tokens[i], pool: address(pools[i])});
    }
    return tokensAndPools;
  }

  function _getSingleTokenPriceUpdateStruct(
    address token,
    uint224 price
  ) internal pure returns (Internal.PriceUpdates memory) {
    Internal.TokenPriceUpdate[] memory tokenPriceUpdates = new Internal.TokenPriceUpdate[](1);
    tokenPriceUpdates[0] = Internal.TokenPriceUpdate({sourceToken: token, usdPerToken: price});

    Internal.PriceUpdates memory priceUpdates = Internal.PriceUpdates({
      tokenPriceUpdates: tokenPriceUpdates,
      gasPriceUpdates: new Internal.GasPriceUpdate[](0)
    });

    return priceUpdates;
  }

  function _getFacilitatorLevel(address f) internal view returns (uint256) {
    (, uint256 level) = ARB_GHO.getFacilitatorBucket(f);
    return level;
  }
}
