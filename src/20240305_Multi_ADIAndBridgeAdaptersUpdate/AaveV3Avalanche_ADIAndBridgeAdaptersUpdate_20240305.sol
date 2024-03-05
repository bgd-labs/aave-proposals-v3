// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305 is IProposalGenericExecutor {
  address public constant CCIP_ADAPTER_TO_REMOVE = 0x3F006299eC88985c18E6e885EeA29A49eC579882;
  address public constant LZ_ADAPTER_TO_REMOVE = 0xf41193E25408F652AF878c47E4401A01B5E4B682;
  address public constant HL_ADAPTER_TO_REMOVE = 0xa198Fac58E02A5C5F8F7e877895d50cFa9ad1E04;
  address public constant CCIP_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant LZ_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant HL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_CCIP_NEW_ADAPTER = address(0); // TODO: change for real address when deployed in ethereum
  address public constant DESTINATION_LZ_NEW_ADAPTER = address(0); // TODO: change for real address when deployed in ethereum
  address public constant DESTINATION_HL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed in ethereum
  address public constant NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION = address(0); // TODO: change for real address when deployed

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(MiscAvalanche.PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER)),
      NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );

    // Set new Receiver bridge adapter
    uint256[] memory chainIds = new uint256[](1);
    chainIds[0] = ChainIds.MAINNET;

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdapterConfig = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](3);

    bridgeAdapterConfig[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_NEW_ADAPTER,
      chainIds: chainIds
    });
    bridgeAdapterConfig[1] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: LZ_NEW_ADAPTER,
      chainIds: chainIds
    });
    bridgeAdapterConfig[2] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: HL_NEW_ADAPTER,
      chainIds: chainIds
    });

    ICrossChainReceiver(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
      bridgeAdapterConfig
    );

    // remove old Receiver bridge adapter
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdaptersToRemove = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](3);

    bridgeAdaptersToRemove[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
      chainIds: chainIds
    });
    bridgeAdaptersToRemove[1] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: LZ_ADAPTER_TO_REMOVE,
      chainIds: chainIds
    });
    bridgeAdaptersToRemove[2] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: HL_ADAPTER_TO_REMOVE,
      chainIds: chainIds
    });
    ICrossChainReceiver(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER)
      .disallowReceiverBridgeAdapters(bridgeAdaptersToRemove);

    // add new forwarding adapter paths
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        3
      );

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: CCIP_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_CCIP_NEW_ADAPTER,
      destinationChainId: ChainIds.ETHEREUM
    });
    bridgeAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: LZ_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_LZ_NEW_ADAPTER,
      destinationChainId: ChainIds.ETHEREUM
    });
    bridgeAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: HL_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_HL_NEW_ADAPTER,
      destinationChainId: ChainIds.ETHEREUM
    });

    ICrossChainForwarder(GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER).enableBridgeAdapters(
      bridgeAdaptersToEnable
    );
  }
}
