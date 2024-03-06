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
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305 is IProposalGenericExecutor {
  //receiver adapters to remove
  address public constant CCIP_ADAPTER_TO_REMOVE = 0xDB8953194810b1942544fA528791278D458719D5;
  address public constant LZ_ADAPTER_TO_REMOVE_GNOSIS = 0x1783DA119C35ED03e608f88cB9528Aba8174fFfc;
  address public constant LZ_ADAPTER_TO_REMOVE = 0x2a323be63e08E08536Fc3b5d8C6f24825e68895e;
  address public constant HL_ADAPTER_TO_REMOVE = 0x6Abb61beb5848B476d026C4934E8a6415e2E75a8;
  address public constant ARB_ADAPTER_TO_REMOVE = 0xE2a33403eaD139873820da597531f07f65ED0E3c;
  address public constant OPT_ADAPTER_TO_REMOVE = 0x2ecC4F6CDbe6ea77107dd131Af81ec82Db330d6b;
  address public constant METIS_ADAPTER_TO_REMOVE = 0x619643b346E3389062527cdb60C8720415B39860;
  address public constant GNOSIS_ADAPTER_TO_REMOVE = 0xe95B40b2CF5fA2F56AAEf9E52f5Bd1e70C059858;
  address public constant BASE_ADAPTER_TO_REMOVE = 0xEB442296880a3FC7C00FFe695c40B09d970fb936;
  address public constant POL_ADAPTER_TO_REMOVE = 0xb13712De579E1f9943502FFCf72eab6ec348cF79;
  address public constant SCROLL_ADAPTER_TO_REMOVE = 0xb29F03cbCc646201eC83E9F2C164747beA84b162;
  // forwarder-receiver adapter pairs to add
  address public constant CCIP_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant LZ_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant HL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant ARB_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant OPT_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant METIS_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant GNOSIS_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant BASE_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant POL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant SCROLL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed

  address public constant DESTINATION_CCIP_NEW_ADAPTER_AVALANCHE = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_LZ_NEW_ADAPTER_AVALANCHE = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_HL_NEW_ADAPTER_AVALANCHE = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_CCIP_NEW_ADAPTER_POLYGON = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_LZ_NEW_ADAPTER_POLYGON = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_HL_NEW_ADAPTER_POLYGON = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_CCIP_NEW_ADAPTER_BNB = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_LZ_NEW_ADAPTER_BNB = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_HL_NEW_ADAPTER_BNB = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_LZ_NEW_ADAPTER_GNOSIS = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_HL_NEW_ADAPTER_GNOSIS = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_ARB_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_OPT_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_METIS_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_GNOSIS_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_BASE_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_POL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant DESTINATION_SCROLL_NEW_ADAPTER = address(0); // TODO: change for real address when deployed

  address public constant NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION = address(0); // TODO: change for real address when deployed

  function _getReceiverBridgeAdaptersToRemove()
    internal
    pure
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    uint256[] memory receiverChainIds = new uint256[](2);
    receiverChainIds[0] = ChainIds.AVALANCHE;
    receiverChainIds[1] = ChainIds.POLYGON;

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receiverAdaptersToRemove = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](
        3
      );

    receiverAdaptersToRemove[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
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

  function _getForwarderBridgeAdaptersToRemove()
    internal
    pure
    returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory forwarderAdaptersToRemove = new ICrossChainForwarder.BridgeAdapterToDisable[](11);

    uint256[] memory forwarderCCIPChainIds = new uint256[](3);
    forwarderCCIPChainIds[0] = ChainIds.AVALANCHE;
    forwarderCCIPChainIds[1] = ChainIds.POLYGON;
    forwarderCCIPChainIds[2] = ChainIds.BNB;

    uint256[] memory forwarderHL_LZChainIds = new uint256[](3);
    forwarderHL_LZChainIds[0] = ChainIds.AVALANCHE;
    forwarderHL_LZChainIds[1] = ChainIds.POLYGON;
    forwarderHL_LZChainIds[2] = ChainIds.BNB;

    forwarderAdaptersToRemove[0] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
      chainIds: forwarderCCIPChainIds
    });
    forwarderAdaptersToRemove[1] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: LZ_ADAPTER_TO_REMOVE,
      chainIds: forwarderHL_LZChainIds
    });
    forwarderAdaptersToRemove[2] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: LZ_ADAPTER_TO_REMOVE_GNOSIS,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[2].chainIds[0] = ChainIds.GNOSIS;

    forwarderAdaptersToRemove[3] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: HL_ADAPTER_TO_REMOVE,
      chainIds: forwarderHL_LZChainIds
    });

    forwarderAdaptersToRemove[4] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: ARB_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[4].chainIds[0] = ChainIds.ARBITRUM;

    forwarderAdaptersToRemove[4] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: OPT_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[5].chainIds[0] = ChainIds.OPTIMISM;

    forwarderAdaptersToRemove[6] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: METIS_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[6].chainIds[0] = ChainIds.METIS;

    forwarderAdaptersToRemove[7] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: GNOSIS_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[7].chainIds[0] = ChainIds.GNOSIS;

    forwarderAdaptersToRemove[8] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: BASE_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[8].chainIds[0] = ChainIds.BASE;

    forwarderAdaptersToRemove[9] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: POL_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[9].chainIds[0] = ChainIds.POLYGON;

    forwarderAdaptersToRemove[10] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: SCROLL_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[10].chainIds[0] = ChainIds.SCROLL;

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
        3
      );

    receiverAdaptersToAllow[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: CCIP_NEW_ADAPTER,
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

  function _getForwarderBridgeAdaptersToEnable()
    internal
    pure
    returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory)
  {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory forwarderAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        18
      );
    // avalanche path
    forwarderAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: CCIP_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_CCIP_NEW_ADAPTER_AVALANCHE,
      destinationChainId: ChainIds.AVALANCHE
    });
    forwarderAdaptersToEnable[1] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: LZ_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_LZ_NEW_ADAPTER_AVALANCHE,
      destinationChainId: ChainIds.AVALANCHE
    });
    forwarderAdaptersToEnable[2] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: HL_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_HL_NEW_ADAPTER_AVALANCHE,
      destinationChainId: ChainIds.AVALANCHE
    });

    // polygon path
    forwarderAdaptersToEnable[3] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: CCIP_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_CCIP_NEW_ADAPTER_POLYGON,
      destinationChainId: ChainIds.POLYGON
    });
    forwarderAdaptersToEnable[4] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: LZ_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_LZ_NEW_ADAPTER_POLYGON,
      destinationChainId: ChainIds.POLYGON
    });
    forwarderAdaptersToEnable[5] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: HL_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_HL_NEW_ADAPTER_POLYGON,
      destinationChainId: ChainIds.POLYGON
    });
    forwarderAdaptersToEnable[6] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: POL_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_POL_NEW_ADAPTER,
      destinationChainId: ChainIds.POLYGON
    });

    // binance path
    forwarderAdaptersToEnable[7] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: CCIP_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_CCIP_NEW_ADAPTER_BNB,
      destinationChainId: ChainIds.BNB
    });
    forwarderAdaptersToEnable[8] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: LZ_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_LZ_NEW_ADAPTER_BNB,
      destinationChainId: ChainIds.BNB
    });
    forwarderAdaptersToEnable[9] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: HL_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_HL_NEW_ADAPTER_BNB,
      destinationChainId: ChainIds.BNB
    });

    // gnosis path
    forwarderAdaptersToEnable[10] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: GNOSIS_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_GNOSIS_NEW_ADAPTER,
      destinationChainId: ChainIds.GNOSIS
    });
    forwarderAdaptersToEnable[11] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: LZ_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_LZ_NEW_ADAPTER_GNOSIS,
      destinationChainId: ChainIds.GNOSIS
    });
    forwarderAdaptersToEnable[12] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: HL_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_HL_NEW_ADAPTER_GNOSIS,
      destinationChainId: ChainIds.GNOSIS
    });

    // arbitrum path
    forwarderAdaptersToEnable[13] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: ARB_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_ARB_NEW_ADAPTER,
      destinationChainId: ChainIds.ARBITRUM
    });

    // optimism path
    forwarderAdaptersToEnable[14] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: OPT_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_OPT_NEW_ADAPTER,
      destinationChainId: ChainIds.OPTIMISM
    });

    // metis path
    forwarderAdaptersToEnable[15] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: METIS_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_METIS_NEW_ADAPTER,
      destinationChainId: ChainIds.METIS
    });

    // base path
    forwarderAdaptersToEnable[16] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: BASE_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_BASE_NEW_ADAPTER,
      destinationChainId: ChainIds.BASE
    });

    // scroll path
    forwarderAdaptersToEnable[17] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: SCROLL_NEW_ADAPTER,
      destinationBridgeAdapter: DESTINATION_SCROLL_NEW_ADAPTER,
      destinationChainId: ChainIds.SCROLL
    });

    return forwarderAdaptersToEnable;
  }

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(MiscEthereum.PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER)),
      NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );

    // remove old Receiver bridge adapter
    ICrossChainReceiver(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(
      _getReceiverBridgeAdaptersToRemove()
    );

    // remove forwarding adapters
    ICrossChainForwarder(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).disableBridgeAdapters(
      _getForwarderBridgeAdaptersToRemove()
    );

    // add receiver adapters
    ICrossChainReceiver(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
      _getReceiverBridgeAdaptersToAllow()
    );

    // add forwarding adapters
    ICrossChainForwarder(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).enableBridgeAdapters(
      _getForwarderBridgeAdaptersToEnable()
    );
  }
}
