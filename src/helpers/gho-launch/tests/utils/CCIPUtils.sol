// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IClient} from 'src/interfaces/ccip/IClient.sol';
import {IRouter} from 'src/interfaces/ccip/IRouter.sol';
import {IInternal} from 'src/interfaces/ccip/IInternal.sol';
import {IEVM2EVMOnRamp, IOnRamp_1_6} from 'src/interfaces/ccip/IEVM2EVMOnRamp.sol';
import {INonceManager} from 'src/interfaces/ccip/INonceManager.sol';
import {ILegacyFeeQuoter} from 'src/interfaces/ccip/ILegacyFeeQuoter.sol';

library CCIPUtils {
  bytes32 internal constant LEAF_DOMAIN_SEPARATOR =
    0x0000000000000000000000000000000000000000000000000000000000000000;
  bytes32 internal constant INTERNAL_DOMAIN_SEPARATOR =
    0x0000000000000000000000000000000000000000000000000000000000000001;
  bytes32 internal constant EVM_2_EVM_MESSAGE_HASH = keccak256('EVM2EVMMessageHashV2');
  bytes32 internal constant EVM_2_ANY_MESSAGE_HASH = keccak256('EVM2AnyMessageHashV1');
  bytes4 public constant EVM_EXTRA_ARGS_V1_TAG = 0x97a657c9;
  bytes4 public constant GENERIC_EXTRA_ARGS_V2_TAG = 0x181dcf10;

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
    uint256 tokenAmountsLength,
    address feeToken
  ) internal pure returns (IClient.EVM2AnyMessage memory) {
    return
      IClient.EVM2AnyMessage({
        receiver: abi.encode(receiver),
        data: '',
        tokenAmounts: new IClient.EVMTokenAmount[](tokenAmountsLength),
        feeToken: feeToken,
        extraArgs: argsToBytes(IClient.EVMExtraArgsV1({gasLimit: 0}))
      });
  }

  function generateMessage_1_6(
    address receiver,
    uint256 tokenAmountsLength,
    address feeToken
  ) internal pure returns (IClient.EVM2AnyMessage memory) {
    return
      IClient.EVM2AnyMessage({
        receiver: abi.encode(receiver),
        data: '',
        tokenAmounts: new IClient.EVMTokenAmount[](tokenAmountsLength),
        feeToken: feeToken,
        extraArgs: argsToBytes_1_6(
          IClient.GenericExtraArgsV2({gasLimit: 0, allowOutOfOrderExecution: false})
        )
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
      generateMetadataHash(
        EVM_2_EVM_MESSAGE_HASH,
        params.sourceChainSelector,
        params.destChainSelector,
        address(onRamp)
      )
    );
    return messageEvent;
  }

  function messageToEvent_1_6(
    MessageToEventParams memory params
  ) public view returns (IInternal.EVM2AnyRampMessage memory) {
    IOnRamp_1_6 onRamp = IOnRamp_1_6(params.router.getOnRamp(params.destChainSelector));
    ILegacyFeeQuoter feeQuoter = ILegacyFeeQuoter(onRamp.getDynamicConfig().feeQuoter);

    // The OnRamp emits the FeeQuoter-converted extraArgs (e.g. with `allowOutOfOrderExecution`
    // forced on for lanes that enforce it), not the raw user supplied args. The same flag also
    // drives the emitted nonce: out-of-order lanes emit nonce 0 instead of an ordered nonce.
    (, bool isOutOfOrderExecution, bytes memory convertedExtraArgs) = feeQuoter.processMessageArgs(
      params.destChainSelector,
      params.message.feeToken,
      params.feeTokenAmount,
      params.message.extraArgs,
      params.message.receiver
    );

    uint64 nonce = 0;
    if (!isOutOfOrderExecution) {
      IOnRamp_1_6.StaticConfig memory config = onRamp.getStaticConfig();
      nonce =
        INonceManager(config.nonceManager).getOutboundNonce(
          params.destChainSelector,
          params.originalSender
        ) +
        1;
    }

    IInternal.EVM2AnyRampMessage memory messageEvent = IInternal.EVM2AnyRampMessage({
      header: IInternal.RampMessageHeader({
        messageId: '',
        sourceChainSelector: params.sourceChainSelector,
        destChainSelector: params.destChainSelector,
        sequenceNumber: onRamp.getExpectedNextSequenceNumber(params.destChainSelector),
        nonce: nonce
      }),
      sender: params.originalSender,
      data: params.message.data,
      receiver: params.message.receiver,
      extraArgs: convertedExtraArgs,
      feeToken: params.message.feeToken,
      feeTokenAmount: params.feeTokenAmount,
      feeValueJuels: params.feeTokenAmount,
      tokenAmounts: new IInternal.EVM2AnyTokenTransfer[](params.message.tokenAmounts.length)
    });

    for (uint256 i = 0; i < params.message.tokenAmounts.length; ++i) {
      messageEvent.tokenAmounts[i] = IInternal.EVM2AnyTokenTransfer({
        sourcePoolAddress: onRamp.getPoolBySourceToken(
          params.destChainSelector,
          params.message.tokenAmounts[i].token
        ),
        destTokenAddress: abi.encode(params.destinationToken),
        extraData: abi.encode(getTokenDecimals(params.sourceToken)),
        amount: params.message.tokenAmounts[i].amount,
        // Placeholder; the real dest gas amount is resolved by the FeeQuoter below.
        destExecData: ''
      });
    }

    // The per-token `destExecData` (encoded dest gas amount) is computed by the FeeQuoter from the
    // lane/token config, not a fixed default, so read it back instead of hardcoding.
    bytes[] memory destExecDataPerToken = feeQuoter.processPoolReturnData(
      params.destChainSelector,
      messageEvent.tokenAmounts,
      params.message.tokenAmounts
    );
    for (uint256 i = 0; i < messageEvent.tokenAmounts.length; ++i) {
      messageEvent.tokenAmounts[i].destExecData = destExecDataPerToken[i];
    }

    messageEvent.header.messageId = hash_1_6(
      messageEvent,
      generateMetadataHash(
        EVM_2_ANY_MESSAGE_HASH,
        params.sourceChainSelector,
        params.destChainSelector,
        address(onRamp)
      )
    );
    return messageEvent;
  }

  function generateMetadataHash(
    bytes32 messageHash,
    uint64 sourceChainSelector,
    uint64 destChainSelector,
    address onRamp
  ) internal pure returns (bytes32) {
    return keccak256(abi.encode(messageHash, sourceChainSelector, destChainSelector, onRamp));
  }

  function argsToBytes(
    IClient.EVMExtraArgsV1 memory extraArgs
  ) internal pure returns (bytes memory bts) {
    return abi.encodeWithSelector(EVM_EXTRA_ARGS_V1_TAG, extraArgs);
  }

  function argsToBytes_1_6(
    IClient.GenericExtraArgsV2 memory extraArgs
  ) internal pure returns (bytes memory bts) {
    return abi.encodeWithSelector(GENERIC_EXTRA_ARGS_V2_TAG, extraArgs);
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

  function hash_1_6(
    IInternal.EVM2AnyRampMessage memory original,
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
              original.header.sequenceNumber,
              original.header.nonce,
              original.feeToken,
              original.feeTokenAmount
            )
          ),
          keccak256(original.receiver),
          keccak256(original.data),
          keccak256(abi.encode(original.tokenAmounts)),
          keccak256(original.extraArgs)
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
