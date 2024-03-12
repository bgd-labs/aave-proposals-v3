// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305_Test is BaseTest {
  AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305 internal payload;

  constructor()
    BaseTest(
      GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      MiscPolygon.PROXY_ADMIN,
      'polygon',
      54566890
    )
  {}

  function setUp() public override {
    super.setUp();
    payload = new AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305();
    payloadAddress = address(payload);
  }

  function _getAdapterNames() internal view override returns (AdapterName[] memory) {
    AdapterName[] memory adapterNames = new AdapterName[](4);
    adapterNames[0] = AdapterName({adapter: payload.CCIP_NEW_ADAPTER(), name: 'CCIP adapter'});
    adapterNames[1] = AdapterName({adapter: payload.LZ_NEW_ADAPTER(), name: 'LayerZero adapter'});
    adapterNames[2] = AdapterName({adapter: payload.HL_NEW_ADAPTER(), name: 'Hyperlane adapter'});
    adapterNames[3] = AdapterName({
      adapter: payload.POL_NEW_ADAPTER(),
      name: 'Polygon native adapter'
    });

    return adapterNames;
  }

  function _checkCorrectPathConfiguration() internal override {
    assertEq(ethereumPayload.CCIP_NEW_ADAPTER(), payload.DESTINATION_CCIP_NEW_ADAPTER());
    assertEq(ethereumPayload.LZ_NEW_ADAPTER(), payload.DESTINATION_LZ_NEW_ADAPTER());
    assertEq(ethereumPayload.HL_NEW_ADAPTER(), payload.DESTINATION_HL_NEW_ADAPTER());
    assertEq(ethereumPayload.POL_NEW_ADAPTER(), payload.DESTINATION_POL_NEW_ADAPTER());
  }

  function _getTrustedRemotes() internal view override returns (TrustedRemote[] memory) {
    TrustedRemote[] memory trustedRemotes = new TrustedRemote[](4);
    trustedRemotes[0] = TrustedRemote({
      adapter: payload.CCIP_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.MAINNET
    });
    trustedRemotes[1] = TrustedRemote({
      adapter: payload.LZ_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.MAINNET
    });
    trustedRemotes[2] = TrustedRemote({
      adapter: payload.HL_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.MAINNET
    });
    trustedRemotes[3] = TrustedRemote({
      adapter: payload.POL_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.MAINNET
    });

    return trustedRemotes;
  }

  function _getForwarderAdaptersByChain(
    bool beforeExecution
  ) internal view override returns (ForwarderAdapters[] memory) {
    ForwarderAdapters[] memory forwarderAdapters = new ForwarderAdapters[](1);

    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory adapters = new ICrossChainForwarder.ChainIdBridgeConfig[](4);
    adapters[0].currentChainBridgeAdapter = payload.CCIP_ADAPTER_TO_REMOVE();
    adapters[1].currentChainBridgeAdapter = payload.LZ_ADAPTER_TO_REMOVE();
    adapters[2].currentChainBridgeAdapter = payload.HL_ADAPTER_TO_REMOVE();
    adapters[3].currentChainBridgeAdapter = payload.POL_ADAPTER_TO_REMOVE();

    if (!beforeExecution) {
      adapters[0].currentChainBridgeAdapter = payload.CCIP_NEW_ADAPTER();
      adapters[1].currentChainBridgeAdapter = payload.LZ_NEW_ADAPTER();
      adapters[2].currentChainBridgeAdapter = payload.HL_NEW_ADAPTER();
      adapters[3].currentChainBridgeAdapter = payload.POL_NEW_ADAPTER();
      adapters[0].destinationBridgeAdapter = payload.DESTINATION_CCIP_NEW_ADAPTER();
      adapters[1].destinationBridgeAdapter = payload.DESTINATION_LZ_NEW_ADAPTER();
      adapters[2].destinationBridgeAdapter = payload.DESTINATION_HL_NEW_ADAPTER();
      adapters[3].destinationBridgeAdapter = payload.DESTINATION_POL_NEW_ADAPTER();
    }
    forwarderAdapters[0].adapters = adapters;
    forwarderAdapters[0].chainId = ChainIds.MAINNET;

    return forwarderAdapters;
  }

  function _getReceiverAdaptersByChain(
    bool beforeExecution
  ) internal view override returns (AdaptersByChain[] memory) {
    address[] memory adapters = new address[](4);
    AdaptersByChain[] memory receiverAdaptersByChain = new AdaptersByChain[](1);

    adapters[0] = payload.CCIP_ADAPTER_TO_REMOVE();
    adapters[1] = payload.LZ_ADAPTER_TO_REMOVE();
    adapters[2] = payload.HL_ADAPTER_TO_REMOVE();
    adapters[3] = payload.POL_ADAPTER_TO_REMOVE();

    if (!beforeExecution) {
      adapters[0] = payload.CCIP_NEW_ADAPTER();
      adapters[1] = payload.LZ_NEW_ADAPTER();
      adapters[2] = payload.HL_NEW_ADAPTER();
      adapters[3] = payload.POL_NEW_ADAPTER();
    }
    receiverAdaptersByChain[0].adapters = adapters;
    receiverAdaptersByChain[0].chainId = ChainIds.MAINNET;

    return receiverAdaptersByChain;
  }

  function _getAdapterByChain(
    bool beforeExecution
  ) internal view override returns (AdapterAllowed[] memory) {
    AdapterAllowed[] memory adaptersAllowed = new AdapterAllowed[](8);
    adaptersAllowed[0] = AdapterAllowed({
      adapter: payload.CCIP_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.MAINNET,
      allowed: true
    });
    adaptersAllowed[1] = AdapterAllowed({
      adapter: payload.LZ_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.MAINNET,
      allowed: true
    });
    adaptersAllowed[2] = AdapterAllowed({
      adapter: payload.HL_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.MAINNET,
      allowed: true
    });
    adaptersAllowed[3] = AdapterAllowed({
      adapter: payload.POL_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.MAINNET,
      allowed: true
    });
    adaptersAllowed[4] = AdapterAllowed({
      adapter: payload.CCIP_NEW_ADAPTER(),
      chainId: ChainIds.MAINNET,
      allowed: false
    });
    adaptersAllowed[5] = AdapterAllowed({
      adapter: payload.LZ_NEW_ADAPTER(),
      chainId: ChainIds.MAINNET,
      allowed: false
    });
    adaptersAllowed[6] = AdapterAllowed({
      adapter: payload.HL_NEW_ADAPTER(),
      chainId: ChainIds.MAINNET,
      allowed: false
    });
    adaptersAllowed[7] = AdapterAllowed({
      adapter: payload.POL_NEW_ADAPTER(),
      chainId: ChainIds.MAINNET,
      allowed: false
    });
    if (!beforeExecution) {
      adaptersAllowed[0].allowed = false;
      adaptersAllowed[1].allowed = false;
      adaptersAllowed[2].allowed = false;
      adaptersAllowed[3].allowed = false;
      adaptersAllowed[4].allowed = true;
      adaptersAllowed[5].allowed = true;
      adaptersAllowed[6].allowed = true;
      adaptersAllowed[7].allowed = true;
    }

    return adaptersAllowed;
  }
}
