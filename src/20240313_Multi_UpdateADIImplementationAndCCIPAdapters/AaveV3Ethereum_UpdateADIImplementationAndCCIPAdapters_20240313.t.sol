// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import './BaseTest.sol';
import {AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313.sol';

/**
 * @dev Test for AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313_Test is BaseTest {
  AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313 internal payload;
  AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313 internal avalanchePayload;
  AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313 internal bnbPayload;
  AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313 internal polygonPayload;

  constructor()
    BaseTest(
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      MiscEthereum.PROXY_ADMIN,
      'mainnet',
      19418547
    )
  {}

  function setUp() public override {
    super.setUp();
    payload = new AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313();
    avalanchePayload = new AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313();
    bnbPayload = new AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313();
    polygonPayload = new AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313();
    payloadAddress = address(payload);
  }

  function _getAdapterNames() internal view override returns (AdapterName[] memory) {
    AdapterName[] memory adapterNames = new AdapterName[](1);
    adapterNames[0] = AdapterName({adapter: payload.CCIP_NEW_ADAPTER(), name: 'CCIP adapter'});

    return adapterNames;
  }

  function _checkCorrectPathConfiguration() internal override {
    assertEq(payload.DESTINATION_CCIP_NEW_ADAPTER_AVALANCHE(), avalanchePayload.CCIP_NEW_ADAPTER());
    assertEq(payload.DESTINATION_CCIP_NEW_ADAPTER_BNB(), bnbPayload.CCIP_NEW_ADAPTER());
    assertEq(payload.DESTINATION_CCIP_NEW_ADAPTER_POLYGON(), polygonPayload.CCIP_NEW_ADAPTER());
  }

  function _getTrustedRemotes() internal view override returns (TrustedRemote[] memory) {
    TrustedRemote[] memory trustedRemotes = new TrustedRemote[](2);
    trustedRemotes[0] = TrustedRemote({
      adapter: payload.CCIP_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.POLYGON
    });
    trustedRemotes[1] = TrustedRemote({
      adapter: payload.CCIP_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.AVALANCHE
    });

    return trustedRemotes;
  }

  function _getReceiverAdaptersByChain(
    bool afterExecution
  ) internal view override returns (AdaptersByChain[] memory) {
    address[] memory polygonAdapters = new address[](1);
    address[] memory avalancheAdapters = new address[](1);
    AdaptersByChain[] memory receiverAdaptersByChain = new AdaptersByChain[](2);

    polygonAdapters[0] = payload.CCIP_ADAPTER_TO_REMOVE();
    avalancheAdapters[0] = payload.CCIP_ADAPTER_TO_REMOVE();

    if (afterExecution) {
      polygonAdapters[0] = payload.CCIP_NEW_ADAPTER();
      avalancheAdapters[0] = payload.CCIP_NEW_ADAPTER();
    }
    receiverAdaptersByChain[0].adapters = polygonAdapters;
    receiverAdaptersByChain[0].chainId = ChainIds.POLYGON;
    receiverAdaptersByChain[0].adapters = avalancheAdapters;
    receiverAdaptersByChain[0].chainId = ChainIds.AVALANCHE;

    return receiverAdaptersByChain;
  }

  function _getForwarderAdaptersByChain(
    bool afterExecution
  ) internal view override returns (ForwarderAdapters[] memory) {
    ForwarderAdapters[] memory forwarderAdapters = new ForwarderAdapters[](3);

    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory polygonAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory avalancheAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory binanceAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);

    // polygon
    polygonAdapters[0].currentChainBridgeAdapter = payload.CCIP_ADAPTER_TO_REMOVE();
    // avalanche
    avalancheAdapters[0].currentChainBridgeAdapter = payload.CCIP_ADAPTER_TO_REMOVE();
    // binance
    binanceAdapters[0].currentChainBridgeAdapter = payload.CCIP_ADAPTER_TO_REMOVE();

    if (afterExecution) {
      // polygon
      polygonAdapters[0].currentChainBridgeAdapter = payload.CCIP_NEW_ADAPTER();
      polygonAdapters[0].destinationBridgeAdapter = payload.DESTINATION_CCIP_NEW_ADAPTER_POLYGON();
      // avalanche
      avalancheAdapters[0].currentChainBridgeAdapter = payload.CCIP_NEW_ADAPTER();
      avalancheAdapters[0].destinationBridgeAdapter = payload
        .DESTINATION_CCIP_NEW_ADAPTER_AVALANCHE();
      // binance
      binanceAdapters[0].currentChainBridgeAdapter = payload.CCIP_NEW_ADAPTER();
      binanceAdapters[0].destinationBridgeAdapter = payload.DESTINATION_CCIP_NEW_ADAPTER_BNB();
    }
    forwarderAdapters[0].adapters = polygonAdapters;
    forwarderAdapters[0].chainId = ChainIds.POLYGON;
    forwarderAdapters[1].adapters = avalancheAdapters;
    forwarderAdapters[1].chainId = ChainIds.AVALANCHE;
    forwarderAdapters[2].adapters = binanceAdapters;
    forwarderAdapters[2].chainId = ChainIds.BNB;

    return forwarderAdapters;
  }

  function _getAdapterByChain(
    bool afterExecution
  ) internal view override returns (AdapterAllowed[] memory) {
    AdapterAllowed[] memory adaptersAllowed = new AdapterAllowed[](4);
    adaptersAllowed[0] = AdapterAllowed({
      adapter: payload.CCIP_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.POLYGON,
      allowed: true
    });
    adaptersAllowed[1] = AdapterAllowed({
      adapter: payload.CCIP_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.AVALANCHE,
      allowed: true
    });
    adaptersAllowed[2] = AdapterAllowed({
      adapter: payload.CCIP_NEW_ADAPTER(),
      chainId: ChainIds.POLYGON,
      allowed: false
    });
    adaptersAllowed[3] = AdapterAllowed({
      adapter: payload.CCIP_NEW_ADAPTER(),
      chainId: ChainIds.AVALANCHE,
      allowed: false
    });
    if (afterExecution) {
      adaptersAllowed[0].allowed = false;
      adaptersAllowed[1].allowed = false;
      adaptersAllowed[2].allowed = true;
      adaptersAllowed[3].allowed = true;
    }

    return adaptersAllowed;
  }
}
