// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IEVM2EVMOffRamp} from 'src/interfaces/ccip/IEVM2EVMOffRamp.sol';
import {IUpgradeableLockReleaseTokenPool} from 'src/interfaces/ccip/IUpgradeableLockReleaseTokenPool.sol';
import {IGhoToken} from 'src/interfaces/IGhoToken.sol';

import {AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722} from './AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722.sol';
import {AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722} from './AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722.sol';

/**
 * @dev Test for AaveV3E2E_GHOCrossChainLaunch_20240528
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240722_Multi_IncreaseGHOFacilitatorCapacity/AaveV3E2e_IncreaseGHOFacilitatorCapacity_20240722.t.sol -vv
 */
contract AaveV3E2ETest_IncreaseGHOFacilitatorCapacity is ProtocolV3TestBase {
  /// @notice Leaf domain separator, should be used as the first 32 bytes of a leaf's preimage.
  bytes32 internal constant LEAF_DOMAIN_SEPARATOR =
    0x0000000000000000000000000000000000000000000000000000000000000000;

  bytes32 internal constant EVM_2_EVM_MESSAGE_HASH = keccak256('EVM2EVMMessageHashV2');

  // bytes4(keccak256("CCIP EVMExtraArgsV1"));
  bytes4 internal constant EVM_EXTRA_ARGS_V1_TAG = 0x97a657c9;

  AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722 internal arbProposal;
  AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722 internal ethProposal;

  IUpgradeableLockReleaseTokenPool internal ETH_TOKEN_POOL =
    IUpgradeableLockReleaseTokenPool(MiscEthereum.GHO_CCIP_TOKEN_POOL);
  address internal ARB_TOKEN_POOL = MiscArbitrum.GHO_CCIP_TOKEN_POOL;
  IGhoToken internal ETH_GHO;
  IGhoToken internal ARB_GHO;

  IRouter internal ETH_ROUTER = IRouter(0x80226fc0Ee2b096224EeAc085Bb9a8cba1146f7D);
  IRouter internal ARB_ROUTER = IRouter(0x141fa059441E0ca23ce184B6A78bafD2A517DdE8);

  uint256 public constant CURRENT_CCIP_BUCKET_CAPACITY = 2_500_000e18; // 2.5M
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
  event CCIPSendRequested(IInternal.EVM2EVMMessage message);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Initialized(uint8 version);

  uint256 internal ethereumFork;
  uint256 internal arbitrumFork;

  function setUp() public {
    ethereumFork = vm.createFork(vm.rpcUrl('mainnet'), 20390936);
    arbitrumFork = vm.createFork(vm.rpcUrl('arbitrum'), 236255425);

    // Proposal creation
    vm.selectFork(ethereumFork);
    ethProposal = new AaveV3Ethereum_IncreaseGHOFacilitatorCapacity_20240722();
    ETH_GHO = IGhoToken(MiscEthereum.GHO_TOKEN);

    vm.selectFork(arbitrumFork);
    arbProposal = new AaveV3Arbitrum_IncreaseGHOFacilitatorCapacity_20240722();
    ARB_GHO = IGhoToken(AaveV3ArbitrumAssets.GHO_UNDERLYING);
  }

  /// @dev Full E2E Test: transfer from Ethereum to Arbitrum and way back, with limit
  function test_ccipFullE2E() public {
    vm.selectFork(arbitrumFork);

    assertEq(ARB_GHO.balanceOf(address(ARB_TOKEN_POOL)), 0);
    (uint256 capacity, uint256 level) = ARB_GHO.getFacilitatorBucket(address(ARB_TOKEN_POOL));
    assertEq(capacity, CURRENT_CCIP_BUCKET_CAPACITY);

    uint256 currentBridgedAmount = level;

    // CCIP Transfer from Ethereum to Arbitrum
    // Ethereum execution (origin)
    vm.selectFork(ethereumFork);
    address user = makeAddr('user');
    uint256 amount = 4_000_000e18; // 4M ETH_GHO
    deal(user, 1e18); // 1 ETH
    deal(address(ETH_GHO), user, amount);

    assertEq(ETH_GHO.balanceOf(address(ETH_TOKEN_POOL)), currentBridgedAmount);
    assertEq(ETH_TOKEN_POOL.getBridgeLimit(), CURRENT_CCIP_BUCKET_CAPACITY);
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
      IClient.EVM2AnyMessage memory message,
      IInternal.EVM2EVMMessage memory geEvent,
      uint256 expectedFee
    ) = _prepareCcip(params);

    vm.expectRevert(
      abi.encodeWithSelector(
        IUpgradeableLockReleaseTokenPool.BridgeLimitExceeded.selector,
        2_500_000e18
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
    IEVM2EVMOffRamp(CCIP_ARB_OFF_RAMP).executeSingleMessage(geEvent, emptyData);

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
    IEVM2EVMOffRamp(CCIP_ETH_OFF_RAMP).executeSingleMessage(geEvent, emptyData);

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
    IRouter router;
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
  ) internal returns (IClient.EVM2AnyMessage memory, IInternal.EVM2EVMMessage memory, uint256) {
    IClient.EVM2AnyMessage memory message = _generateSingleTokenMessage(
      params.receiver,
      params.token,
      params.amount,
      params.feeToken
    );
    uint256 expectedFee = params.router.getFee(params.destChainSelector, message);

    bytes32 metadataHash = keccak256(
      abi.encode(
        EVM_2_EVM_MESSAGE_HASH,
        params.sourceChainSelector,
        params.destChainSelector,
        params.onRamp
      )
    );

    IInternal.EVM2EVMMessage memory geEvent = _messageToEvent(
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
  ) public pure returns (IClient.EVM2AnyMessage memory) {
    IClient.EVMTokenAmount[] memory tokenAmounts = new IClient.EVMTokenAmount[](1);
    tokenAmounts[0] = IClient.EVMTokenAmount({token: token, amount: amount});
    return
      IClient.EVM2AnyMessage({
        receiver: abi.encode(receiver),
        data: '',
        tokenAmounts: tokenAmounts,
        feeToken: feeToken,
        extraArgs: _argsToBytes(IClient.EVMExtraArgsV1({gasLimit: 200_000}))
      });
  }

  function _messageToEvent(
    IClient.EVM2AnyMessage memory message,
    uint64 seqNum,
    uint64 nonce,
    uint256 feeTokenAmount,
    address originalSender,
    uint64 sourceChainSelector,
    bytes32 metadataHash
  ) public pure returns (IInternal.EVM2EVMMessage memory) {
    // Slicing is only available for calldata. So we have to build a new bytes array.
    bytes memory args = new bytes(message.extraArgs.length - 4);
    for (uint256 i = 4; i < message.extraArgs.length; ++i) {
      args[i - 4] = message.extraArgs[i];
    }
    IClient.EVMExtraArgsV1 memory extraArgs = abi.decode(args, (IClient.EVMExtraArgsV1));
    IInternal.EVM2EVMMessage memory messageEvent = IInternal.EVM2EVMMessage({
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

    messageEvent.messageId = _hash(messageEvent, metadataHash);
    return messageEvent;
  }

  function _argsToBytes(
    IClient.EVMExtraArgsV1 memory extraArgs
  ) internal pure returns (bytes memory bts) {
    return abi.encodeWithSelector(EVM_EXTRA_ARGS_V1_TAG, extraArgs);
  }

  function _hash(
    IInternal.EVM2EVMMessage memory original,
    bytes32 metadataHash
  ) internal pure returns (bytes32) {
    // Fixed-size message fields are included in nested hash to reduce stack pressure.
    // This hashing scheme is also used by RMN. If changing it, please notify the RMN maintainers.
    return
      keccak256(
        abi.encode(
          LEAF_DOMAIN_SEPARATOR,
          metadataHash,
          keccak256(
            abi.encode(
              original.sender,
              original.receiver,
              original.sequenceNumber,
              original.gasLimit,
              original.strict,
              original.nonce,
              original.feeToken,
              original.feeTokenAmount
            )
          ),
          keccak256(original.data),
          keccak256(abi.encode(original.tokenAmounts)),
          keccak256(abi.encode(original.sourceTokenData))
        )
      );
  }
}
