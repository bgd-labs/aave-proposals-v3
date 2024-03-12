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
  address public constant SAME_CHAIN_ADAPTER_TO_REMOVE = 0x118DFD5418890c0332042ab05173Db4A2C1d283c;
  // forwarder-receiver adapter pairs to add
  address public constant CCIP_NEW_ADAPTER = 0xB7a6618df58626C3a122ABAFD6Ee63Af63f3Ef29;
  address public constant LZ_NEW_ADAPTER = 0x8410d9BD353b420ebA8C48ff1B0518426C280FCC;
  address public constant HL_NEW_ADAPTER = 0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1;
  address public constant ARB_NEW_ADAPTER = 0x88d6D01e08d3e64513b15fD46528dBbA7d755883;
  address public constant OPT_NEW_ADAPTER = 0x0e24524778fdc67f53eEf144b8cbf50261E930B3;
  address public constant METIS_NEW_ADAPTER = 0x6B3Dc800E7c813Db3fe8D0F30fDCaE636935dC14;
  address public constant GNOSIS_NEW_ADAPTER = 0x7238d75fD75bb936E83b75854c653F104Ce9c9d8;
  address public constant BASE_NEW_ADAPTER = 0xa5948b0ac79f72966dFFC5C13E44f6dfDD3D58A0;
  address public constant POL_NEW_ADAPTER = 0x1562F1b2487F892BBA8Ef325aF054Fd157510a71;
  address public constant SCROLL_NEW_ADAPTER = 0xA4dC3F123e1c601A19B3DC8382BB9311F678cafA;
  address public constant SAME_CHAIN_NEW_ADAPTER = 0x6cfbd2aA4691fc18B9C209bDd43DC3943C228FCf;

  address public constant DESTINATION_CCIP_NEW_ADAPTER_AVALANCHE =
    0x2b88C83727B0E290B76EB3F6133994fF81B7f355;
  address public constant DESTINATION_LZ_NEW_ADAPTER_AVALANCHE =
    0x10f02995a399C0dC0FaF29914220E9C1bCdE8640;
  address public constant DESTINATION_HL_NEW_ADAPTER_AVALANCHE =
    0x617332a777780F546261247F621051d0b98975Eb;
  address public constant DESTINATION_CCIP_NEW_ADAPTER_POLYGON =
    0xe79757D55a1600eF28D816a893E78E9FCDE2019E;
  address public constant DESTINATION_LZ_NEW_ADAPTER_POLYGON =
    0x7FAE7765abB4c8f778d57337bB720d0BC53057e3;
  address public constant DESTINATION_HL_NEW_ADAPTER_POLYGON =
    0x3e72665008dC237bdd91C04C10782Ed1987a4019;
  address public constant DESTINATION_CCIP_NEW_ADAPTER_BNB =
    0xAE93BEa44dcbE52B625169588574d31e36fb3A67;
  address public constant DESTINATION_LZ_NEW_ADAPTER_BNB =
    0xa5cc218513305221201f196760E9e64e9D49d98A;
  address public constant DESTINATION_HL_NEW_ADAPTER_BNB =
    0x3F006299eC88985c18E6e885EeA29A49eC579882;
  address public constant DESTINATION_LZ_NEW_ADAPTER_GNOSIS =
    0x9b6f5ef589A3DD08670Dd146C11C4Fb33E04494F;
  address public constant DESTINATION_HL_NEW_ADAPTER_GNOSIS =
    0xA806DA549FcB2B4912a7dFFE4c1aA7A1ed0Bd5C9;
  address public constant DESTINATION_ARB_NEW_ADAPTER = 0xc8a2ADC4261c6b669CdFf69E717E77C9cFeB420d;
  address public constant DESTINATION_OPT_NEW_ADAPTER = 0xAE93BEa44dcbE52B625169588574d31e36fb3A67;
  address public constant DESTINATION_METIS_NEW_ADAPTER =
    0xf41193E25408F652AF878c47E4401A01B5E4B682;
  address public constant DESTINATION_GNOSIS_NEW_ADAPTER =
    0x3C06dce358add17aAf230f2234bCCC4afd50d090;
  address public constant DESTINATION_BASE_NEW_ADAPTER = 0x7120b1f8e5b73c0C0DC99C6e52Fe4937E7EA11e0;
  address public constant DESTINATION_POL_NEW_ADAPTER = 0x853649f897383f89d8441346Cf26a9ed02720B02;
  address public constant DESTINATION_SCROLL_NEW_ADAPTER =
    0x3C06dce358add17aAf230f2234bCCC4afd50d090;

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
    uint256[] memory receiverChainIds = new uint256[](2);
    receiverChainIds[0] = ChainIds.AVALANCHE;
    receiverChainIds[1] = ChainIds.POLYGON;

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receiverAdaptersToRemove = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](
        4
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
    receiverAdaptersToRemove[3] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: POL_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    receiverAdaptersToRemove[3].chainIds[0] = ChainIds.POLYGON;

    return receiverAdaptersToRemove;
  }

  function _getForwarderBridgeAdaptersToRemove()
    internal
    pure
    returns (ICrossChainForwarder.BridgeAdapterToDisable[] memory)
  {
    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory forwarderAdaptersToRemove = new ICrossChainForwarder.BridgeAdapterToDisable[](12);

    uint256[] memory forwarderCCIP_LZChainIds = new uint256[](3);
    forwarderCCIP_LZChainIds[0] = ChainIds.AVALANCHE;
    forwarderCCIP_LZChainIds[1] = ChainIds.POLYGON;
    forwarderCCIP_LZChainIds[2] = ChainIds.BNB;

    uint256[] memory forwarderHLChainIds = new uint256[](4);
    forwarderHLChainIds[0] = ChainIds.AVALANCHE;
    forwarderHLChainIds[1] = ChainIds.POLYGON;
    forwarderHLChainIds[2] = ChainIds.BNB;
    forwarderHLChainIds[3] = ChainIds.GNOSIS;

    forwarderAdaptersToRemove[0] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: CCIP_ADAPTER_TO_REMOVE,
      chainIds: forwarderCCIP_LZChainIds
    });
    forwarderAdaptersToRemove[1] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: LZ_ADAPTER_TO_REMOVE,
      chainIds: forwarderCCIP_LZChainIds
    });
    forwarderAdaptersToRemove[2] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: LZ_ADAPTER_TO_REMOVE_GNOSIS,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[2].chainIds[0] = ChainIds.GNOSIS;

    forwarderAdaptersToRemove[3] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: HL_ADAPTER_TO_REMOVE,
      chainIds: forwarderHLChainIds
    });

    forwarderAdaptersToRemove[4] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: ARB_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[4].chainIds[0] = ChainIds.ARBITRUM;

    forwarderAdaptersToRemove[5] = ICrossChainForwarder.BridgeAdapterToDisable({
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

    forwarderAdaptersToRemove[11] = ICrossChainForwarder.BridgeAdapterToDisable({
      bridgeAdapter: SAME_CHAIN_ADAPTER_TO_REMOVE,
      chainIds: new uint256[](1)
    });
    forwarderAdaptersToRemove[11].chainIds[0] = ChainIds.MAINNET;

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
        4
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
    receiverAdaptersToAllow[3] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: POL_NEW_ADAPTER,
      chainIds: new uint256[](1)
    });
    receiverAdaptersToAllow[3].chainIds[0] = ChainIds.POLYGON;

    return receiverAdaptersToAllow;
  }

  function _getForwarderBridgeAdaptersToEnable()
    internal
    pure
    returns (ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[] memory)
  {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory forwarderAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        19
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

    // same chain path
    forwarderAdaptersToEnable[18] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: SAME_CHAIN_NEW_ADAPTER,
      destinationBridgeAdapter: SAME_CHAIN_NEW_ADAPTER,
      destinationChainId: ChainIds.MAINNET
    });

    return forwarderAdaptersToEnable;
  }
}
