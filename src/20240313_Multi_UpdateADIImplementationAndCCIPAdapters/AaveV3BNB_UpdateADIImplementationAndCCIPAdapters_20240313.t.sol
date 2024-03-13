// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import './BaseTest.sol';

import {AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313.sol';

/**
 * @dev Test for AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313
 * command: make test-contract filter=AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313
 */
contract AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313_Test is BaseTest {
  AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313 internal payload;

  constructor()
    BaseTest(GovernanceV3BNB.CROSS_CHAIN_CONTROLLER, MiscBNB.PROXY_ADMIN, 'bnb', 36903911)
  {}

  function setUp() public override {
    super.setUp();
    payload = new AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313();
    payloadAddress = address(payload);
  }

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
      adaptersAllowed[5].allowed = true;
    }

    return adaptersAllowed;
  }
}
