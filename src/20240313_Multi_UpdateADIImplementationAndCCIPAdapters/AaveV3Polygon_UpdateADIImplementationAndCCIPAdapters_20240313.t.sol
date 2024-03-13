// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import './BaseTest.sol';
import {AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313.sol';

/**
 * @dev Test for AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313_Test is BaseTest {
  AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313 internal payload;

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
    payload = new AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313();
    payloadAddress = address(payload);
  }

  //  function _getForwarderAdaptersByChain(
  //    bool afterExecution
  //  ) internal view override returns (ForwarderAdapters[] memory) {
  //    ForwarderAdapters[] memory forwarderAdapters = new ForwarderAdapters[](1);
  //
  //    ICrossChainForwarder.ChainIdBridgeConfig[]
  //      memory adapters = new ICrossChainForwarder.ChainIdBridgeConfig[](1);
  //    adapters[0].currentChainBridgeAdapter = payload.CCIP_ADAPTER_TO_REMOVE();
  //
  //    if (afterExecution) {
  //      adapters[0].currentChainBridgeAdapter = payload.CCIP_NEW_ADAPTER();
  //      adapters[0].destinationBridgeAdapter = payload.DESTINATION_CCIP_NEW_ADAPTER();
  //    }
  //    forwarderAdapters[0].adapters = adapters;
  //    forwarderAdapters[0].chainId = ChainIds.MAINNET;
  //
  //    return forwarderAdapters;
  //  }

  function _getReceiverAdaptersByChain(
    bool afterExecution
  ) internal view override returns (AdaptersByChain[] memory) {
    address[] memory adapters = new address[](1);
    AdaptersByChain[] memory receiverAdaptersByChain = new AdaptersByChain[](1);

    adapters[0] = payload.CCIP_ADAPTER_TO_REMOVE();

    if (afterExecution) {
      adapters[0] = payload.CCIP_NEW_ADAPTER();
    }
    receiverAdaptersByChain[0].adapters = adapters;
    receiverAdaptersByChain[0].chainId = ChainIds.MAINNET;

    return receiverAdaptersByChain;
  }

  function _getAdapterByChain(
    bool afterExecution
  ) internal view override returns (AdapterAllowed[] memory) {
    AdapterAllowed[] memory adaptersAllowed = new AdapterAllowed[](2);
    adaptersAllowed[0] = AdapterAllowed({
      adapter: payload.CCIP_ADAPTER_TO_REMOVE(),
      chainId: ChainIds.MAINNET,
      allowed: true
    });
    adaptersAllowed[1] = AdapterAllowed({
      adapter: payload.CCIP_NEW_ADAPTER(),
      chainId: ChainIds.MAINNET,
      allowed: false
    });
    if (afterExecution) {
      adaptersAllowed[0].allowed = false;
      adaptersAllowed[1].allowed = true;
    }

    return adaptersAllowed;
  }
}
