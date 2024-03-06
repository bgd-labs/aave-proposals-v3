// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305 is IProposalGenericExecutor {
  address public constant CCIP_ADAPTER_TO_REMOVE = 0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf;
  address public constant LZ_ADAPTER_TO_REMOVE = 0xFF1137243698CaA18EE364Cc966CF0e02A4e6327;
  address public constant HL_ADAPTER_TO_REMOVE = 0x118DFD5418890c0332042ab05173Db4A2C1d283c;
  address public constant CCIP_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant LZ_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant HL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_CCIP_NEW_ADAPTER = address(0); // TODO: change for real address when deployed in ethereum
  address public constant DESTINATION_LZ_NEW_ADAPTER = address(0); // TODO: change for real address when deployed in ethereum
  address public constant DESTINATION_HL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed in ethereum
  address public constant NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION = address(0); // TODO: change for real address when deployed

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(MiscBNB.PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(GovernanceV3BNB.CROSS_CHAIN_CONTROLLER)),
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

    ICrossChainReceiver(GovernanceV3BNB.CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
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
    ICrossChainReceiver(GovernanceV3BNB.CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(
      bridgeAdaptersToRemove
    );
  }
}
