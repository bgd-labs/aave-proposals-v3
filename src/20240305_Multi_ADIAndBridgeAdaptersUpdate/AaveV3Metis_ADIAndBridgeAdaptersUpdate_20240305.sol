// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscMetis} from 'aave-address-book/MiscMetis.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305 is IProposalGenericExecutor {
  address public constant ADAPTER_TO_REMOVE = 0x746c675dAB49Bcd5BB9Dc85161f2d7Eb435009bf;
  address public constant NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION = address(0); // TODO: change for real address when deployed

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(MiscMetis.PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(GovernanceV3Metis.CROSS_CHAIN_CONTROLLER)),
      NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );

    // remove old Receiver bridge adapter
    ICrossChainReceiver(GovernanceV3Metis.CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(
      _getReceiverBridgeAdaptersToRemove()
    );

    // add receiver adapters
    ICrossChainReceiver(GovernanceV3Metis.CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
      _getReceiverBridgeAdaptersToAllow()
    );
  }

  function _getReceiverBridgeAdaptersToRemove()
    internal
    pure
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    uint256[] memory receiverChainIds = new uint256[](1);
    receiverChainIds[0] = ChainIds.MAINNET;

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receiverAdaptersToRemove = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](
        1
      );

    receiverAdaptersToRemove[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: ADAPTER_TO_REMOVE,
      chainIds: receiverChainIds
    });

    return receiverAdaptersToRemove;
  }

  function _getReceiverBridgeAdaptersToAllow()
    internal
    pure
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    uint256[] memory receiverChainIds = new uint256[](1);
    receiverChainIds[0] = ChainIds.MAINNET;

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receiverAdaptersToAllow = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](
        1
      );

    receiverAdaptersToAllow[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: NEW_ADAPTER,
      chainIds: receiverChainIds
    });

    return receiverAdaptersToAllow;
  }
}