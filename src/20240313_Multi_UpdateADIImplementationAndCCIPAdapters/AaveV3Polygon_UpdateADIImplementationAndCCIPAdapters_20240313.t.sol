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
  constructor()
    BaseTest(
      GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
      MiscPolygon.PROXY_ADMIN,
      type(AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
      'polygon',
      54566890
    )
  {}

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
}
