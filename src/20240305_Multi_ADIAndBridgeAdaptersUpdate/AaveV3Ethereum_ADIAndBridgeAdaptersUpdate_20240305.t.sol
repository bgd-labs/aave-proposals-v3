// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import './BaseTest.sol';
import {AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305.sol';

/**
 * @dev Test for AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305_Test is BaseTest {
  AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305 internal payload;
  AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305 internal arbitrumPayload;
  AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305 internal avalanchePayload;
  AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305 internal basePayload;
  AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305 internal bnbPayload;
  AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305 internal gnosisPayload;
  AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305 internal metisPayload;
  AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305 internal optimismPayload;
  AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305 internal polygonPayload;
  AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305 internal scrollPayload;

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
    payload = new AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305();
    arbitrumPayload = new AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305();
    avalanchePayload = new AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305();
    basePayload = new AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305();
    bnbPayload = new AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305();
    gnosisPayload = new AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305();
    metisPayload = new AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305();
    optimismPayload = new AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305();
    polygonPayload = new AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305();
    scrollPayload = new AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305();
    payloadAddress = address(payload);
  }

  function _getAdapterNames() internal view override returns (AdapterName[] memory) {
    AdapterName[] memory adapterNames = new AdapterName[](11);
    adapterNames[0] = AdapterName({adapter: payload.CCIP_NEW_ADAPTER(), name: 'CCIP adapter'});
    adapterNames[1] = AdapterName({adapter: payload.LZ_NEW_ADAPTER(), name: 'LayerZero adapter'});
    adapterNames[2] = AdapterName({adapter: payload.HL_NEW_ADAPTER(), name: 'Hyperlane adapter'});
    adapterNames[3] = AdapterName({
      adapter: payload.POL_NEW_ADAPTER(),
      name: 'Polygon native adapter'
    });
    adapterNames[4] = AdapterName({
      adapter: payload.ARB_NEW_ADAPTER(),
      name: 'Arbitrum native adapter'
    });
    adapterNames[5] = AdapterName({
      adapter: payload.OPT_NEW_ADAPTER(),
      name: 'Optimism native adapter'
    });
    adapterNames[6] = AdapterName({
      adapter: payload.METIS_NEW_ADAPTER(),
      name: 'Metis native adapter'
    });
    adapterNames[7] = AdapterName({
      adapter: payload.GNOSIS_NEW_ADAPTER(),
      name: 'Gnosis native adapter'
    });
    adapterNames[8] = AdapterName({
      adapter: payload.BASE_NEW_ADAPTER(),
      name: 'Base native adapter'
    });
    adapterNames[9] = AdapterName({
      adapter: payload.SCROLL_NEW_ADAPTER(),
      name: 'Scroll native adapter'
    });
    adapterNames[10] = AdapterName({
      adapter: payload.SAME_CHAIN_NEW_ADAPTER(),
      name: 'SameChain adapter'
    });

    return adapterNames;
  }

  function _checkCorrectPathConfiguration() internal override {
    assertEq(payload.DESTINATION_ARB_NEW_ADAPTER(), arbitrumPayload.NEW_ADAPTER());
    assertEq(payload.DESTINATION_CCIP_NEW_ADAPTER_AVALANCHE(), avalanchePayload.CCIP_NEW_ADAPTER());
    assertEq(payload.DESTINATION_LZ_NEW_ADAPTER_AVALANCHE(), avalanchePayload.LZ_NEW_ADAPTER());
    assertEq(payload.DESTINATION_HL_NEW_ADAPTER_AVALANCHE(), avalanchePayload.HL_NEW_ADAPTER());
    assertEq(payload.DESTINATION_BASE_NEW_ADAPTER(), basePayload.NEW_ADAPTER());
    assertEq(payload.DESTINATION_CCIP_NEW_ADAPTER_BNB(), bnbPayload.CCIP_NEW_ADAPTER());
    assertEq(payload.DESTINATION_LZ_NEW_ADAPTER_BNB(), bnbPayload.LZ_NEW_ADAPTER());
    assertEq(payload.DESTINATION_HL_NEW_ADAPTER_BNB(), bnbPayload.HL_NEW_ADAPTER());
    assertEq(payload.DESTINATION_GNOSIS_NEW_ADAPTER(), gnosisPayload.GNOSIS_NEW_ADAPTER());
    assertEq(payload.DESTINATION_LZ_NEW_ADAPTER_GNOSIS(), gnosisPayload.LZ_NEW_ADAPTER());
    assertEq(payload.DESTINATION_HL_NEW_ADAPTER_GNOSIS(), gnosisPayload.HL_NEW_ADAPTER());
    assertEq(payload.DESTINATION_METIS_NEW_ADAPTER(), metisPayload.NEW_ADAPTER());
    assertEq(payload.DESTINATION_OPT_NEW_ADAPTER(), optimismPayload.NEW_ADAPTER());
    assertEq(payload.DESTINATION_CCIP_NEW_ADAPTER_POLYGON(), polygonPayload.CCIP_NEW_ADAPTER());
    assertEq(payload.DESTINATION_LZ_NEW_ADAPTER_POLYGON(), polygonPayload.LZ_NEW_ADAPTER());
    assertEq(payload.DESTINATION_HL_NEW_ADAPTER_POLYGON(), polygonPayload.HL_NEW_ADAPTER());
    assertEq(payload.DESTINATION_POL_NEW_ADAPTER(), polygonPayload.POL_NEW_ADAPTER());
    assertEq(payload.DESTINATION_SCROLL_NEW_ADAPTER(), scrollPayload.NEW_ADAPTER());
  }

  function _getTrustedRemotes() internal view override returns (TrustedRemote[] memory) {
    TrustedRemote[] memory trustedRemotes = new TrustedRemote[](7);
    trustedRemotes[0] = TrustedRemote({
      adapter: payload.CCIP_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.POLYGON
    });
    trustedRemotes[1] = TrustedRemote({
      adapter: payload.LZ_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.POLYGON
    });
    trustedRemotes[2] = TrustedRemote({
      adapter: payload.HL_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.POLYGON
    });
    trustedRemotes[3] = TrustedRemote({
      adapter: payload.POL_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.POLYGON
    });
    trustedRemotes[4] = TrustedRemote({
      adapter: payload.CCIP_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.AVALANCHE
    });
    trustedRemotes[5] = TrustedRemote({
      adapter: payload.LZ_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.AVALANCHE
    });
    trustedRemotes[6] = TrustedRemote({
      adapter: payload.HL_NEW_ADAPTER(),
      expectedRemote: GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.AVALANCHE
    });

    return trustedRemotes;
  }

  function _getReceiverAdaptersByChain(
    bool beforeExecution
  ) internal view override returns (AdaptersByChain[] memory) {
    address[] memory polygonAdapters = new address[](4);
    address[] memory avalancheAdapters = new address[](3);
    AdaptersByChain[] memory receiverAdaptersByChain = new AdaptersByChain[](2);

    polygonAdapters[0] = payload.CCIP_ADAPTER_TO_REMOVE();
    polygonAdapters[1] = payload.LZ_ADAPTER_TO_REMOVE();
    polygonAdapters[2] = payload.HL_ADAPTER_TO_REMOVE();
    polygonAdapters[3] = payload.POL_ADAPTER_TO_REMOVE();
    avalancheAdapters[0] = payload.CCIP_ADAPTER_TO_REMOVE();
    avalancheAdapters[1] = payload.LZ_ADAPTER_TO_REMOVE();
    avalancheAdapters[2] = payload.HL_ADAPTER_TO_REMOVE();

    if (!beforeExecution) {
      polygonAdapters[0] = payload.CCIP_NEW_ADAPTER();
      polygonAdapters[1] = payload.LZ_NEW_ADAPTER();
      polygonAdapters[2] = payload.HL_NEW_ADAPTER();
      polygonAdapters[3] = payload.POL_NEW_ADAPTER();
      avalancheAdapters[0] = payload.CCIP_NEW_ADAPTER();
      avalancheAdapters[1] = payload.LZ_NEW_ADAPTER();
      avalancheAdapters[2] = payload.HL_NEW_ADAPTER();
    }
    receiverAdaptersByChain[0].adapters = polygonAdapters;
    receiverAdaptersByChain[0].chainId = ChainIds.POLYGON;
    receiverAdaptersByChain[0].adapters = avalancheAdapters;
    receiverAdaptersByChain[0].chainId = ChainIds.AVALANCHE;

    return receiverAdaptersByChain;
  }

  function _getForwarderAdaptersByChain(
    bool beforeExecution
  ) internal view override returns (ForwarderAdapters[] memory) {
    ForwarderAdapters[] memory forwarderAdapters = new ForwarderAdapters[](10);

    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory polygonAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](4);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory avalancheAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](3);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory binanceAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](3);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory gnosisAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](3);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory arbitrumAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory optimismAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory metisAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory baseAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory scrollAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory ethereumAdapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);

    // polygon
    polygonAdapters[0].currentChainBridgeAdapter = payload.CCIP_ADAPTER_TO_REMOVE();
    polygonAdapters[1].currentChainBridgeAdapter = payload.LZ_ADAPTER_TO_REMOVE();
    polygonAdapters[2].currentChainBridgeAdapter = payload.HL_ADAPTER_TO_REMOVE();
    polygonAdapters[3].currentChainBridgeAdapter = payload.POL_ADAPTER_TO_REMOVE();
    // avalanche
    avalancheAdapters[0].currentChainBridgeAdapter = payload.CCIP_ADAPTER_TO_REMOVE();
    avalancheAdapters[1].currentChainBridgeAdapter = payload.LZ_ADAPTER_TO_REMOVE();
    avalancheAdapters[2].currentChainBridgeAdapter = payload.HL_ADAPTER_TO_REMOVE();
    // binance
    binanceAdapters[0].currentChainBridgeAdapter = payload.CCIP_ADAPTER_TO_REMOVE();
    binanceAdapters[1].currentChainBridgeAdapter = payload.LZ_ADAPTER_TO_REMOVE();
    binanceAdapters[2].currentChainBridgeAdapter = payload.HL_ADAPTER_TO_REMOVE();
    // gnosis
    gnosisAdapters[0].currentChainBridgeAdapter = payload.GNOSIS_ADAPTER_TO_REMOVE();
    gnosisAdapters[1].currentChainBridgeAdapter = payload.LZ_ADAPTER_TO_REMOVE_GNOSIS();
    gnosisAdapters[2].currentChainBridgeAdapter = payload.HL_ADAPTER_TO_REMOVE();
    // arbitrum
    arbitrumAdapters[0].currentChainBridgeAdapter = payload.ARB_ADAPTER_TO_REMOVE();
    // optimism
    optimismAdapters[0].currentChainBridgeAdapter = payload.OPT_ADAPTER_TO_REMOVE();
    // metis
    metisAdapters[0].currentChainBridgeAdapter = payload.METIS_ADAPTER_TO_REMOVE();
    // scroll
    scrollAdapters[0].currentChainBridgeAdapter = payload.SCROLL_ADAPTER_TO_REMOVE();
    // base
    baseAdapters[0].currentChainBridgeAdapter = payload.BASE_ADAPTER_TO_REMOVE();
    // ethereum
    ethereumAdapters[0].currentChainBridgeAdapter = payload.SAME_CHAIN_ADAPTER_TO_REMOVE();

    if (!beforeExecution) {
      // polygon
      polygonAdapters[0].currentChainBridgeAdapter = payload.CCIP_NEW_ADAPTER();
      polygonAdapters[1].currentChainBridgeAdapter = payload.LZ_NEW_ADAPTER();
      polygonAdapters[2].currentChainBridgeAdapter = payload.HL_NEW_ADAPTER();
      polygonAdapters[3].currentChainBridgeAdapter = payload.POL_NEW_ADAPTER();
      polygonAdapters[0].destinationBridgeAdapter = payload.DESTINATION_CCIP_NEW_ADAPTER_POLYGON();
      polygonAdapters[1].destinationBridgeAdapter = payload.DESTINATION_LZ_NEW_ADAPTER_POLYGON();
      polygonAdapters[2].destinationBridgeAdapter = payload.DESTINATION_HL_NEW_ADAPTER_POLYGON();
      polygonAdapters[3].destinationBridgeAdapter = payload.DESTINATION_POL_NEW_ADAPTER();
      // avalanche
      avalancheAdapters[0].currentChainBridgeAdapter = payload.CCIP_NEW_ADAPTER();
      avalancheAdapters[1].currentChainBridgeAdapter = payload.LZ_NEW_ADAPTER();
      avalancheAdapters[2].currentChainBridgeAdapter = payload.HL_NEW_ADAPTER();
      avalancheAdapters[0].destinationBridgeAdapter = payload
        .DESTINATION_CCIP_NEW_ADAPTER_AVALANCHE();
      avalancheAdapters[1].destinationBridgeAdapter = payload
        .DESTINATION_LZ_NEW_ADAPTER_AVALANCHE();
      avalancheAdapters[2].destinationBridgeAdapter = payload
        .DESTINATION_HL_NEW_ADAPTER_AVALANCHE();
      // binance
      binanceAdapters[0].currentChainBridgeAdapter = payload.CCIP_NEW_ADAPTER();
      binanceAdapters[1].currentChainBridgeAdapter = payload.LZ_NEW_ADAPTER();
      binanceAdapters[2].currentChainBridgeAdapter = payload.HL_NEW_ADAPTER();
      binanceAdapters[0].destinationBridgeAdapter = payload.DESTINATION_CCIP_NEW_ADAPTER_BNB();
      binanceAdapters[1].destinationBridgeAdapter = payload.DESTINATION_LZ_NEW_ADAPTER_BNB();
      binanceAdapters[2].destinationBridgeAdapter = payload.DESTINATION_HL_NEW_ADAPTER_BNB();
      // gnosis
      gnosisAdapters[0].currentChainBridgeAdapter = payload.GNOSIS_NEW_ADAPTER();
      gnosisAdapters[1].currentChainBridgeAdapter = payload.LZ_NEW_ADAPTER();
      gnosisAdapters[2].currentChainBridgeAdapter = payload.HL_NEW_ADAPTER();
      gnosisAdapters[0].destinationBridgeAdapter = payload.DESTINATION_GNOSIS_NEW_ADAPTER();
      gnosisAdapters[1].destinationBridgeAdapter = payload.DESTINATION_LZ_NEW_ADAPTER_GNOSIS();
      gnosisAdapters[2].destinationBridgeAdapter = payload.DESTINATION_HL_NEW_ADAPTER_GNOSIS();
      // arbitrum
      arbitrumAdapters[0].currentChainBridgeAdapter = payload.ARB_NEW_ADAPTER();
      arbitrumAdapters[0].destinationBridgeAdapter = payload.DESTINATION_ARB_NEW_ADAPTER();
      // optimism
      optimismAdapters[0].currentChainBridgeAdapter = payload.OPT_NEW_ADAPTER();
      optimismAdapters[0].destinationBridgeAdapter = payload.DESTINATION_OPT_NEW_ADAPTER();
      // metis
      metisAdapters[0].currentChainBridgeAdapter = payload.METIS_NEW_ADAPTER();
      metisAdapters[0].destinationBridgeAdapter = payload.DESTINATION_METIS_NEW_ADAPTER();
      // scroll
      scrollAdapters[0].currentChainBridgeAdapter = payload.SCROLL_NEW_ADAPTER();
      scrollAdapters[0].destinationBridgeAdapter = payload.DESTINATION_SCROLL_NEW_ADAPTER();
      // base
      baseAdapters[0].currentChainBridgeAdapter = payload.BASE_NEW_ADAPTER();
      baseAdapters[0].destinationBridgeAdapter = payload.DESTINATION_BASE_NEW_ADAPTER();
      // ethereum
      ethereumAdapters[0].currentChainBridgeAdapter = payload.SAME_CHAIN_NEW_ADAPTER();
      ethereumAdapters[0].destinationBridgeAdapter = payload.SAME_CHAIN_NEW_ADAPTER();
    }
    forwarderAdapters[0].adapters = polygonAdapters;
    forwarderAdapters[0].chainId = ChainIds.POLYGON;
    forwarderAdapters[1].adapters = avalancheAdapters;
    forwarderAdapters[1].chainId = ChainIds.AVALANCHE;
    forwarderAdapters[2].adapters = binanceAdapters;
    forwarderAdapters[2].chainId = ChainIds.BNB;
    forwarderAdapters[3].adapters = gnosisAdapters;
    forwarderAdapters[3].chainId = ChainIds.GNOSIS;
    forwarderAdapters[4].adapters = arbitrumAdapters;
    forwarderAdapters[4].chainId = ChainIds.ARBITRUM;
    forwarderAdapters[5].adapters = optimismAdapters;
    forwarderAdapters[5].chainId = ChainIds.OPTIMISM;
    forwarderAdapters[6].adapters = metisAdapters;
    forwarderAdapters[6].chainId = ChainIds.METIS;
    forwarderAdapters[7].adapters = baseAdapters;
    forwarderAdapters[7].chainId = ChainIds.BASE;
    forwarderAdapters[8].adapters = scrollAdapters;
    forwarderAdapters[8].chainId = ChainIds.SCROLL;
    forwarderAdapters[9].adapters = ethereumAdapters;
    forwarderAdapters[9].chainId = ChainIds.MAINNET;

    return forwarderAdapters;
  }

  function _getAdapterByChain(
    bool beforeExecution
  ) internal view override returns (AdapterAllowed[] memory) {
    AdapterAllowed[] memory adaptersAllowed = new AdapterAllowed[](14);
    adaptersAllowed[0] = AdapterAllowed({
      adapter: payload.CCIP_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.POLYGON,
      allowed: true
    });
    adaptersAllowed[1] = AdapterAllowed({
      adapter: payload.LZ_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.POLYGON,
      allowed: true
    });
    adaptersAllowed[2] = AdapterAllowed({
      adapter: payload.HL_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.POLYGON,
      allowed: true
    });
    adaptersAllowed[3] = AdapterAllowed({
      adapter: payload.POL_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.POLYGON,
      allowed: true
    });
    adaptersAllowed[4] = AdapterAllowed({
      adapter: payload.CCIP_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.AVALANCHE,
      allowed: true
    });
    adaptersAllowed[5] = AdapterAllowed({
      adapter: payload.LZ_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.AVALANCHE,
      allowed: true
    });
    adaptersAllowed[6] = AdapterAllowed({
      adapter: payload.HL_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.AVALANCHE,
      allowed: true
    });
    adaptersAllowed[7] = AdapterAllowed({
      adapter: payload.CCIP_NEW_ADAPTER(),
      chainId: ChainIds.POLYGON,
      allowed: false
    });
    adaptersAllowed[8] = AdapterAllowed({
      adapter: payload.LZ_NEW_ADAPTER(),
      chainId: ChainIds.POLYGON,
      allowed: false
    });
    adaptersAllowed[9] = AdapterAllowed({
      adapter: payload.HL_NEW_ADAPTER(),
      chainId: ChainIds.POLYGON,
      allowed: false
    });
    adaptersAllowed[10] = AdapterAllowed({
      adapter: payload.POL_NEW_ADAPTER(),
      chainId: ChainIds.POLYGON,
      allowed: false
    });
    adaptersAllowed[11] = AdapterAllowed({
      adapter: payload.CCIP_NEW_ADAPTER(),
      chainId: ChainIds.AVALANCHE,
      allowed: false
    });
    adaptersAllowed[12] = AdapterAllowed({
      adapter: payload.LZ_NEW_ADAPTER(),
      chainId: ChainIds.AVALANCHE,
      allowed: false
    });
    adaptersAllowed[13] = AdapterAllowed({
      adapter: payload.HL_NEW_ADAPTER(),
      chainId: ChainIds.AVALANCHE,
      allowed: false
    });
    if (!beforeExecution) {
      adaptersAllowed[0].allowed = false;
      adaptersAllowed[1].allowed = false;
      adaptersAllowed[2].allowed = false;
      adaptersAllowed[3].allowed = false;
      adaptersAllowed[4].allowed = false;
      adaptersAllowed[5].allowed = false;
      adaptersAllowed[6].allowed = false;
      adaptersAllowed[7].allowed = true;
      adaptersAllowed[8].allowed = true;
      adaptersAllowed[9].allowed = true;
      adaptersAllowed[10].allowed = true;
      adaptersAllowed[11].allowed = true;
      adaptersAllowed[12].allowed = true;
      adaptersAllowed[13].allowed = true;
    }

    return adaptersAllowed;
  }
}
