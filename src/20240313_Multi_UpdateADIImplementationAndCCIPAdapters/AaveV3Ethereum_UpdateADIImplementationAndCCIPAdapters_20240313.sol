// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';

/**
 * @title Update a.DI implementation and CCIP adapters
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313 is
  IProposalGenericExecutor
{
  //receiver adapters to remove
  address public constant CCIP_ADAPTER_TO_REMOVE = 0xDB8953194810b1942544fA528791278D458719D5;
  // forwarder-receiver adapter pairs to add
  address public constant CCIP_NEW_ADAPTER = 0xB7a6618df58626C3a122ABAFD6Ee63Af63f3Ef29;

  address public constant DESTINATION_CCIP_NEW_ADAPTER_AVALANCHE =
    0x2b88C83727B0E290B76EB3F6133994fF81B7f355;
  address public constant DESTINATION_CCIP_NEW_ADAPTER_POLYGON =
    0xe79757D55a1600eF28D816a893E78E9FCDE2019E;
  address public constant DESTINATION_CCIP_NEW_ADAPTER_BNB =
    0xAE93BEa44dcbE52B625169588574d31e36fb3A67;

  address public constant NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION =
    0x28559c2F4B038b1E836fA419DCcDe7454d8Fe215;

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(MiscEthereum.PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER)),
      NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );
    // add receiver adapters
    ICrossChainReceiver(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
      _getReceiverBridgeAdaptersToAllow()
    );

    // add forwarding adapters
    ICrossChainForwarder(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).enableBridgeAdapters(
      _getForwarderBridgeAdaptersToEnable()
    );

    // remove old Receiver bridge adapter
    ICrossChainReceiver(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(
      _getReceiverBridgeAdaptersToRemove()
    );

    // remove forwarding adapters
    ICrossChainForwarder(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).disableBridgeAdapters(
      _getForwarderBridgeAdaptersToRemove()
    );
  }

  function _getReceiverBridgeAdaptersToRemove()
    internal
    pure
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receiverAdaptersToRemove = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](
        1
      );

    uint256[] memory receiverChainIds = new uint256[](1);
    receiverChainIds[0] = ChainIds.POLYGON;
    receiverChainIds[1] = ChainIds.AVALANCHE;

    receiverAdaptersToRemove[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
      chainIds: receiverChainIds
    });

    return receiverAdaptersToRemove;
  }

  function _getForwarderBridgeAdaptersToRemove()
    internal
    pure
    returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory forwarderAdaptersToRemove = new ICrossChainForwarder.BridgeAdapterToDisable[](1);

    uint256[] memory forwarderCCIPChainIds = new uint256[](3);
    forwarderCCIPChainIds[0] = ChainIds.AVALANCHE;
    forwarderCCIPChainIds[1] = ChainIds.POLYGON;
    forwarderCCIPChainIds[2] = ChainIds.BNB;

    forwarderAdaptersToRemove[0] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
      chainIds: forwarderCCIPChainIds
    });

    return forwarderAdaptersToRemove;
  }

  function _getReceiverBridgeAdaptersToAllow()
    internal
    pure
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    uint256[] memory receiverChainIds = new uint256[](2);
    receiverChainIds[0] = ChainIds.AVALANCHE;
    receiverChainIds[1] = ChainIds.POLYGON;

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receiverAdaptersToAllow = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](
        1
      );

    receiverAdaptersToAllow[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_NEW_ADAPTER,
      chainIds: receiverChainIds
    });

    return receiverAdaptersToAllow;
  }

  function _getForwarderBridgeAdaptersToEnable()
    internal
    pure
    returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory)
  {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory forwarderAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        3
      );
    // avalanche path
    forwarderAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: CCIP_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_CCIP_NEW_ADAPTER_AVALANCHE,
      destinationChainId: ChainIds.AVALANCHE
    });

    // polygon path
    forwarderAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: CCIP_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_CCIP_NEW_ADAPTER_POLYGON,
      destinationChainId: ChainIds.POLYGON
    });

    // binance path
    forwarderAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: CCIP_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_CCIP_NEW_ADAPTER_BNB,
      destinationChainId: ChainIds.BNB
    });

    return forwarderAdaptersToEnable;
  }
}
