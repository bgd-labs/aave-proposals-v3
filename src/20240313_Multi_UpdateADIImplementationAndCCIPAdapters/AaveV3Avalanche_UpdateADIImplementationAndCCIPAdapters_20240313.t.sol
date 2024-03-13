// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

import './BaseTest.sol';

import {AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313.sol';

/**
 * @dev Test for AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313_Test is BaseTest {
  constructor()
    BaseTest(
      GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
      MiscAvalanche.PROXY_ADMIN,
      type(AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313).creationCode,
      'avalanche',
      42801819
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

  function _getReceiverAdaptersByChain(
    bool afterExecution
  ) internal view override returns (AdaptersByChain[] memory) {
    address[] memory adapters = new address[](1);
    AdaptersByChain[] memory receiverAdaptersByChain = new AdaptersByChain[](1);

    adapters[0] = BaseAdaptersUpdatePayload(payloadAddress).CCIP_ADAPTER_TO_REMOVE();

    if (afterExecution) {
      adapters[0] = BaseAdaptersUpdatePayload(payloadAddress).CCIP_NEW_ADAPTER();
    }
    receiverAdaptersByChain[0].adapters = adapters;
    receiverAdaptersByChain[0].chainId = ChainIds.MAINNET;

    return receiverAdaptersByChain;
  }
}
