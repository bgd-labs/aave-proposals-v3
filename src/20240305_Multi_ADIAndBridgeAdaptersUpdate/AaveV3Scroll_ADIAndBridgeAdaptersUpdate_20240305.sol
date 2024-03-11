// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305 is IProposalGenericExecutor {
  address public constant ADAPTER_TO_REMOVE = 0x118DFD5418890c0332042ab05173Db4A2C1d283c;
  address public constant NEW_ADAPTER = 0x3C06dce358add17aAf230f2234bCCC4afd50d090;
  address public constant NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION =
    0x5e06b10B3b9c3E1c0996D2544A35B9839Be02922;

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(MiscScroll.PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER)),
      NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );

    // remove old Receiver bridge adapter
    ICrossChainReceiver(GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(
      _getReceiverBridgeAdaptersToRemove()
    );

    // add receiver adapters
    ICrossChainReceiver(GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
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
