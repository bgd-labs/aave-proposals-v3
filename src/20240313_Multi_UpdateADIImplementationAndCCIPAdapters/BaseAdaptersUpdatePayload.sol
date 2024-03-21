// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';

import {BaseCCCImplementationUpdatePayload} from './BaseCCCImplementationUpdatePayload.sol';

/**
 * @title Base payload aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 */
abstract contract BaseAdaptersUpdatePayload is BaseCCCImplementationUpdatePayload {
  struct ConstructorInput {
    address proxyAdmin;
    address ccc;
    address newCCCImplementation;
    address ccipAdapterToRemove;
    address ccipNewAdapter;
  }
  struct DestinationAdaptersInput {
    address adapter;
    uint256 chainId;
  }

  address public immutable CCIP_ADAPTER_TO_REMOVE;
  address public immutable CCIP_NEW_ADAPTER;

  constructor(
    ConstructorInput memory constructorInput
  )
    BaseCCCImplementationUpdatePayload(
      CCCImplementationUpdateInput({
        proxyAdmin: constructorInput.proxyAdmin,
        ccc: constructorInput.ccc,
        newCCCImplementation: constructorInput.newCCCImplementation
      })
    )
  {
    CCIP_ADAPTER_TO_REMOVE = constructorInput.ccipAdapterToRemove;
    CCIP_NEW_ADAPTER = constructorInput.ccipNewAdapter;
  }

  function execute() public override {
    super.execute();

    // remove old Receiver bridge adapter
    ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(
      getReceiverBridgeAdaptersToRemove()
    );

    // remove forwarding adapters
    ICrossChainForwarder(CROSS_CHAIN_CONTROLLER).disableBridgeAdapters(
      getForwarderBridgeAdaptersToRemove()
    );

    uint256[] memory chainsToSend = getChainsToSend();
    uint256[] memory chainsToReceive = getChainsToReceive();

    if (chainsToReceive.length != 0) {
      // add receiver adapters
      ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
        getReceiverBridgeAdaptersToAllow()
      );
    }

    if (chainsToSend.length != 0) {
      // add forwarding adapters
      ICrossChainForwarder(CROSS_CHAIN_CONTROLLER).enableBridgeAdapters(
        getForwarderBridgeAdaptersToEnable()
      );
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

  function getChainsToReceive() public pure virtual returns (uint256[] memory);

  function getChainsToSend() public pure returns (uint256[] memory) {
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
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    // remove old Receiver bridge adapter
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdaptersToRemove = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](1);

    bridgeAdaptersToRemove[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
      chainIds: getChainsToReceive()
    });

    return bridgeAdaptersToRemove;
  }

  function getForwarderBridgeAdaptersToRemove()
    public
    view
    returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory forwarderAdaptersToRemove = new ICrossChainForwarder.BridgeAdapterToDisable[](1);

    forwarderAdaptersToRemove[0] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
      chainIds: getChainsToSend()
    });

    return forwarderAdaptersToRemove;
  }

  function getReceiverBridgeAdaptersToAllow()
    public
    view
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdapterConfig = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](1);

    bridgeAdapterConfig[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_NEW_ADAPTER,
      chainIds: getChainsToReceive()
    });

    return bridgeAdapterConfig;
  }

  function getForwarderBridgeAdaptersToEnable()
    public
    view
    returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory)
  {
    DestinationAdaptersInput[] memory destinationAdapters = getDestinationAdapters();

    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        destinationAdapters.length
      );

    for (uint256 i = 0; i < destinationAdapters.length; i++) {
      bridgeAdaptersToEnable[i] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
        currentChainBridgeAdapter: CCIP_NEW_ADAPTER,
        destinationBridgeAdapter: destinationAdapters[i].adapter,
        destinationChainId: destinationAdapters[i].chainId
      });
    }

    return bridgeAdaptersToEnable;
  }
}
