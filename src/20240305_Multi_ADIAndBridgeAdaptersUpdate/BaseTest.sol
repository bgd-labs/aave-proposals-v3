// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';

contract BaseTest is Test {
  address public ccc;
  address public proxyAdmin;

  function _checkAdapterCorrectness(uint256 chainId, address[] memory adapters) internal {
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory forwarderBridgeAdapters = ICrossChainForwarder(ccc).getForwarderBridgeAdaptersByChain(
        chainId
      );

    assertEq(adapters.length, forwarderBridgeAdapters.length);

    uint256 adaptersCount;
    for (uint256 i = 0; i < forwarderBridgeAdapters.length; i++) {
      for (uint256 j = 0; j < adapters.length; j++) {
        if (forwarderBridgeAdapters[i].currentChainBridgeAdapter == adapters[j]) {
          adaptersCount++;
        }
      }
    }
    assertEq(adaptersCount, forwarderBridgeAdapters.length);
  }

  function _testReceiverAdapterAllowed(address adapter, uint256 chainId, bool allowed) internal {
    assertEq(ICrossChainReceiver(ccc).isReceiverBridgeAdapterAllowed(adapter, chainId), allowed);
  }

  function _testImplementationAddress(address implementation, bool equal) internal {
    address cccImplementation = ProxyAdmin(proxyAdmin).getProxyImplementation(
      TransparentUpgradeableProxy(payable(ccc))
    );
    assertEq(cccImplementation == implementation, equal);
  }
}
