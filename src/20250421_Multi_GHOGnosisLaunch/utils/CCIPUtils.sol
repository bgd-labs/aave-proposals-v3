// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IEVM2EVMOnRamp} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';

library CCIPUtils {
  uint64 internal constant ARB_CHAIN_SELECTOR = 4949039107694359620;
  uint64 internal constant BASE_CHAIN_SELECTOR = 15971525489660198786;
  uint64 internal constant ETH_CHAIN_SELECTOR = 5009297550715157269;

  bytes32 internal constant LEAF_DOMAIN_SEPARATOR =
    0x0000000000000000000000000000000000000000000000000000000000000000;
  bytes32 internal constant INTERNAL_DOMAIN_SEPARATOR =
    0x0000000000000000000000000000000000000000000000000000000000000001;
  bytes32 internal constant EVM_2_EVM_MESSAGE_HASH = keccak256('EVM2EVMMessageHashV2');
  bytes4 public constant EVM_EXTRA_ARGS_V1_TAG = 0x97a657c9;

  struct SourceTokenData {
    bytes sourcePoolAddress;
    bytes destTokenAddress;
    bytes extraData;
    uint32 destGasAmount;
  }

  struct MessageToEventParams {
    IClient.EVM2AnyMessage message;
    IRouter router;
    uint64 sourceChainSelector;
    uint64 destChainSelector;
    uint256 feeTokenAmount;
    address originalSender;
    address sourceToken;
    address destinationToken;
  }

  function generateMessage(
    address receiver,
    uint256 tokenAmountsLength
  ) internal pure returns (IClient.EVM2AnyMessage memory) {
    return
      IClient.EVM2AnyMessage({
        receiver: abi.encode(receiver),
        data: '',
        tokenAmounts: new IClient.EVMTokenAmount[](tokenAmountsLength),
        feeToken: address(0),
        extraArgs: argsToBytes(IClient.EVMExtraArgsV1({gasLimit: 0}))
      });
  }

  function messageToEvent(
    MessageToEventParams memory params
  ) public view returns (IInternal.EVM2EVMMessage memory) {
    IEVM2EVMOnRamp onRamp = IEVM2EVMOnRamp(params.router.getOnRamp(params.destChainSelector));

    bytes memory args = new bytes(params.message.extraArgs.length - 4);
    for (uint256 i = 4; i < params.message.extraArgs.length; ++i) {
      args[i - 4] = params.message.extraArgs[i];
    }

    IInternal.EVM2EVMMessage memory messageEvent = IInternal.EVM2EVMMessage({
      sequenceNumber: onRamp.getExpectedNextSequenceNumber(),
      feeTokenAmount: params.feeTokenAmount,
      sender: params.originalSender,
      nonce: onRamp.getSenderNonce(params.originalSender) + 1,
      gasLimit: abi.decode(args, (IClient.EVMExtraArgsV1)).gasLimit,
      strict: false,
      sourceChainSelector: params.sourceChainSelector,
      receiver: abi.decode(params.message.receiver, (address)),
      data: params.message.data,
      tokenAmounts: params.message.tokenAmounts,
      sourceTokenData: new bytes[](params.message.tokenAmounts.length),
      feeToken: params.router.getWrappedNative(),
      messageId: ''
    });

    for (uint256 i; i < params.message.tokenAmounts.length; ++i) {
      messageEvent.sourceTokenData[i] = abi.encode(
        SourceTokenData({
          sourcePoolAddress: abi.encode(
            onRamp.getPoolBySourceToken(
              params.destChainSelector,
              params.message.tokenAmounts[i].token
            )
          ),
          destTokenAddress: abi.encode(params.destinationToken),
          extraData: abi.encode(getTokenDecimals(params.sourceToken)),
          destGasAmount: getDestGasAmount(onRamp, params.message.tokenAmounts[i].token)
        })
      );
    }

    messageEvent.messageId = hash(
      messageEvent,
      generateMetadataHash(params.sourceChainSelector, params.destChainSelector, address(onRamp))
    );
    return messageEvent;
  }

  function generateMetadataHash(
    uint64 sourceChainSelector,
    uint64 destChainSelector,
    address onRamp
  ) internal pure returns (bytes32) {
    return
      keccak256(abi.encode(EVM_2_EVM_MESSAGE_HASH, sourceChainSelector, destChainSelector, onRamp));
  }

  function argsToBytes(
    IClient.EVMExtraArgsV1 memory extraArgs
  ) internal pure returns (bytes memory bts) {
    return abi.encodeWithSelector(EVM_EXTRA_ARGS_V1_TAG, extraArgs);
  }

  /// @dev Used to hash messages for single-lane ramps.
  /// OnRamp hash(EVM2EVMMessage) = OffRamp hash(EVM2EVMMessage)
  /// The EVM2EVMMessage's messageId is expected to be the output of this hash function
  /// @param original Message to hash
  /// @param metadataHash Immutable metadata hash representing a lane with a fixed OnRamp
  /// @return hashedMessage hashed message as a keccak256
  function hash(
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

  function getDestGasAmount(IEVM2EVMOnRamp onRamp, address token) internal view returns (uint32) {
    IEVM2EVMOnRamp.TokenTransferFeeConfig memory config = onRamp.getTokenTransferFeeConfig(token);
    return
      config.isEnabled
        ? config.destGasOverhead
        : onRamp.getDynamicConfig().defaultTokenDestGasOverhead;
  }

  function getTokenDecimals(address token) internal view returns (uint8) {
    (bool success, bytes memory data) = token.staticcall(abi.encodeWithSignature('decimals()'));
    require(success, 'CCIPUtils: failed to get token decimals');
    return abi.decode(data, (uint8));
  }
}
