// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {MiscGnosis} from 'aave-address-book/MiscGnosis.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305 is IProposalGenericExecutor {
  address public constant GNOSIS_ADAPTER_TO_REMOVE = 0x889c0cc3283DB588A34E89Ad1E8F25B0fc827b4b;
  address public constant LZ_ADAPTER_TO_REMOVE = 0x7b62461a3570c6AC8a9f8330421576e417B71EE7;
  address public constant HL_ADAPTER_TO_REMOVE = 0x4A4c73d563395ad827511F70097d4Ef82E653805;
  address public constant GNOSIS_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant LZ_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant HL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION = address(0); // TODO: change for real address when deployed

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(MiscGnosis.PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER)),
      NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );

    // remove old Receiver bridge adapter
    ICrossChainReceiver(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(
      _getReceiverBridgeAdaptersToRemove()
    );

    // add receiver adapters
    ICrossChainReceiver(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
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
        3
      );

    receiverAdaptersToRemove[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: GNOSIS_ADAPTER_TO_REMOVE,
      chainIds: receiverChainIds
    });
    receiverAdaptersToRemove[1] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: LZ_ADAPTER_TO_REMOVE,
      chainIds: receiverChainIds
    });
    receiverAdaptersToRemove[2] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: HL_ADAPTER_TO_REMOVE,
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
        3
      );

    receiverAdaptersToAllow[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: GNOSIS_NEW_ADAPTER,
      chainIds: receiverChainIds
    });
    receiverAdaptersToAllow[1] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: LZ_NEW_ADAPTER,
      chainIds: receiverChainIds
    });
    receiverAdaptersToAllow[2] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: HL_NEW_ADAPTER,
      chainIds: receiverChainIds
    });

    return receiverAdaptersToAllow;
  }
}
