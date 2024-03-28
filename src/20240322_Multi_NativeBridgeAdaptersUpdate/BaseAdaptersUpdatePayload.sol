// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Base payload aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 */
abstract contract BaseAdaptersUpdatePayload is IProposalGenericExecutor {
  struct ConstructorInput {
    address ccc;
    address adapterToRemove;
    address newAdapter;
  }
  struct DestinationAdaptersInput {
    address adapter;
    uint256 chainId;
  }

  address public immutable CROSS_CHAIN_CONTROLLER;
  address public immutable ADAPTER_TO_REMOVE;
  address public immutable NEW_ADAPTER;

  constructor(ConstructorInput memory constructorInput) {
    CROSS_CHAIN_CONTROLLER = constructorInput.ccc;
    ADAPTER_TO_REMOVE = constructorInput.adapterToRemove;
    NEW_ADAPTER = constructorInput.newAdapter;
  }

  function execute() public override {
    // remove old Receiver bridge adapter
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receiversToRemove = getReceiverBridgeAdaptersToRemove();
    if (receiversToRemove.length != 0) {
      ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(receiversToRemove);
    }

    // remove forwarding adapters
    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory forwardersToRemove = getForwarderBridgeAdaptersToRemove();
    if (forwardersToRemove.length != 0) {
      ICrossChainForwarder(CROSS_CHAIN_CONTROLLER).disableBridgeAdapters(forwardersToRemove);
    }

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receiversToAllow = getReceiverBridgeAdaptersToAllow();
    if (receiversToAllow.length != 0) {
      // add receiver adapters
      ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(receiversToAllow);
    }
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory forwardersToEnable = getForwarderBridgeAdaptersToEnable();
    if (forwardersToEnable.length != 0) {
      // add forwarding adapters
      ICrossChainForwarder(CROSS_CHAIN_CONTROLLER).enableBridgeAdapters(forwardersToEnable);
    }
  }

  function getDestinationAdapters()
    public
    pure
    virtual
    returns (DestinationAdaptersInput[] memory)
  {
    DestinationAdaptersInput[] memory destinationAdapters;
    return destinationAdapters;
  }

  function getChainsToReceive() public pure virtual returns (uint256[] memory) {
    return new uint256[](0);
  }

  function getChainsToSend() public pure virtual returns (uint256[] memory) {
    DestinationAdaptersInput[] memory destinationAdapters = getDestinationAdapters();
    uint256[] memory chainsToSend = new uint256[](destinationAdapters.length);
    for (uint256 i = 0; i < destinationAdapters.length; i++) {
      chainsToSend[i] = destinationAdapters[i].chainId;
    }
    return chainsToSend;
  }

  function getReceiverBridgeAdaptersToRemove()
    public
    view
    virtual
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    // remove old Receiver bridge adapter
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdaptersToRemove = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](1);

    bridgeAdaptersToRemove[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: ADAPTER_TO_REMOVE,
      chainIds: getChainsToReceive()
    });

    return bridgeAdaptersToRemove;
  }

  function getForwarderBridgeAdaptersToRemove()
    public
    view
    virtual
    returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory forwarderAdaptersToRemove = new ICrossChainForwarder.BridgeAdapterToDisable[](1);

    forwarderAdaptersToRemove[0] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: ADAPTER_TO_REMOVE,
      chainIds: getChainsToSend()
    });

    return forwarderAdaptersToRemove;
  }

  function getReceiverBridgeAdaptersToAllow()
    public
    view
    virtual
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdapterConfig = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](1);

    bridgeAdapterConfig[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: NEW_ADAPTER,
      chainIds: getChainsToReceive()
    });

    return bridgeAdapterConfig;
  }

  function getForwarderBridgeAdaptersToEnable()
    public
    view
    virtual
    returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory)
  {
    DestinationAdaptersInput[] memory destinationAdapters = getDestinationAdapters();

    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        destinationAdapters.length
      );

    for (uint256 i = 0; i < destinationAdapters.length; i++) {
      bridgeAdaptersToEnable[i] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
        currentChainBridgeAdapter: NEW_ADAPTER,
        destinationBridgeAdapter: destinationAdapters[i].adapter,
        destinationChainId: destinationAdapters[i].chainId
      });
    }

    return bridgeAdaptersToEnable;
  }
}
