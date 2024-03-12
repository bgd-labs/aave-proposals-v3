// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import './BaseTest.sol';

/**
 * @dev Test for AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305_Test is BaseTest {
  AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305 internal payload;

  constructor()
    BaseTest(GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER, MiscScroll.PROXY_ADMIN, 'scroll', 4063725)
  {}

  function setUp() public override {
    super.setUp();
    payload = new AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305();
    payloadAddress = address(payload);
  }

  function _getAdapterNames() internal view override returns (AdapterName[] memory) {
    AdapterName[] memory adapterNames = new AdapterName[](1);
    adapterNames[0] = AdapterName({adapter: payload.NEW_ADAPTER(), name: 'Scroll native adapter'});

    return adapterNames;
  }

  function _getTrustedRemotes() internal view override returns (TrustedRemote[] memory) {
    TrustedRemote[] memory trustedRemotes = new TrustedRemote[](1);
    trustedRemotes[0] = TrustedRemote({
      adapter: payload.NEW_ADAPTER(),
      expectedRemote: GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
      remoteChainId: ChainIds.MAINNET
    });

    return trustedRemotes;
  }

  function _getReceiverAdaptersByChain(
    bool beforeExecution
  ) internal view override returns (AdaptersByChain[] memory) {
    address[] memory adapters = new address[](1);
    AdaptersByChain[] memory receiverAdaptersByChain = new AdaptersByChain[](1);

    if (beforeExecution) {
      adapters[0] = payload.ADAPTER_TO_REMOVE();
    } else {
      adapters[0] = payload.NEW_ADAPTER();
    }
    receiverAdaptersByChain[0].adapters = adapters;
    receiverAdaptersByChain[0].chainId = ChainIds.MAINNET;

    return receiverAdaptersByChain;
  }

  function _getAdapterByChain(
    bool beforeExecution
  ) internal view override returns (AdapterAllowed[] memory) {
    AdapterAllowed[] memory adaptersAllowed = new AdapterAllowed[](2);
    adaptersAllowed[0] = AdapterAllowed({
      adapter: payload.ADAPTER_TO_REMOVE(),
      chainId: ChainIds.MAINNET,
      allowed: true
    });
    adaptersAllowed[1] = AdapterAllowed({
      adapter: payload.NEW_ADAPTER(),
      chainId: ChainIds.MAINNET,
      allowed: false
    });

    if (!beforeExecution) {
      adaptersAllowed[0].allowed = false;
      adaptersAllowed[1].allowed = true;
    }

    return adaptersAllowed;
  }
}
