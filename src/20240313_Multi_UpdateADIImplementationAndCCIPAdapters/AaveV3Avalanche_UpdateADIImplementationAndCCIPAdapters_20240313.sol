// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Update a.DI implementation and CCIP adapters
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313 is
  IProposalGenericExecutor
{
  address public constant CCIP_ADAPTER_TO_REMOVE = 0x3F006299eC88985c18E6e885EeA29A49eC579882;
  address public constant CCIP_NEW_ADAPTER = 0x2b88C83727B0E290B76EB3F6133994fF81B7f355;
  address public constant DESTINATION_CCIP_NEW_ADAPTER = 0xB7a6618df58626C3a122ABAFD6Ee63Af63f3Ef29;
  address public constant NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION =
    0x5Ef80c5eB6CF65Dab8cD1C0ee258a6D2bD38Bd22;

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(MiscAvalanche.PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER)),
      NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );

    // remove old Receiver bridge adapter
    ICrossChainReceiver(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER)
      .disallowReceiverBridgeAdapters(_getReceiverBridgeAdaptersToRemove());

    // remove forwarding adapters
    ICrossChainForwarder(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER).disableBridgeAdapters(
      _getForwarderBridgeAdaptersToRemove()
    );

    // add receiver adapters
    ICrossChainReceiver(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
      _getReceiverBridgeAdaptersToAllow()
    );

    // add forwarding adapters
    ICrossChainForwarder(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER).enableBridgeAdapters(
      _getForwarderBridgeAdaptersToEnable()
    );
  }

  function _getReceiverBridgeAdaptersToRemove()
    internal
    pure
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    uint256[] memory chainIds = new uint256[](1);
    chainIds[0] = ChainIds.MAINNET;

    // remove old Receiver bridge adapter
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdaptersToRemove = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](1);

    bridgeAdaptersToRemove[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
      chainIds: chainIds
    });

    return bridgeAdaptersToRemove;
  }

  function _getForwarderBridgeAdaptersToRemove()
    internal
    pure
    returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    uint256[] memory chainIds = new uint256[](1);
    chainIds[0] = ChainIds.MAINNET;

    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory forwarderAdaptersToRemove = new ICrossChainForwarder.BridgeAdapterToDisable[](1);

    forwarderAdaptersToRemove[0] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
      chainIds: chainIds
    });

    return forwarderAdaptersToRemove;
  }

  function _getReceiverBridgeAdaptersToAllow()
    internal
    pure
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    uint256[] memory chainIds = new uint256[](1);
    chainIds[0] = ChainIds.MAINNET;

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdapterConfig = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](1);

    bridgeAdapterConfig[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_NEW_ADAPTER,
      chainIds: chainIds
    });

    return bridgeAdapterConfig;
  }

  function _getForwarderBridgeAdaptersToEnable()
    internal
    pure
    returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory)
  {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        1
      );

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: CCIP_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_CCIP_NEW_ADAPTER,
      destinationChainId: ChainIds.MAINNET
    });

    return bridgeAdaptersToEnable;
  }
}
