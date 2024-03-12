// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {IBaseAdapter} from 'aave-address-book/common/IBaseAdapter.sol';
import {AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305.sol';

struct AdapterName {
  address adapter;
  string name;
}

struct TrustedRemote {
  address adapter;
  address expectedRemote;
  uint256 remoteChainId;
}

struct AdapterAllowed {
  address adapter;
  uint256 chainId;
  bool allowed;
}

struct AdaptersByChain {
  address[] adapters;
  uint256 chainId;
}

struct ForwarderAdapters {
  ICrossChainForwarder.ChainIdBridgeConfig[] adapters;
  uint256 chainId;
}

interface Payload {
  function NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION() external returns (address);
}

contract BaseTest is ProtocolV3TestBase {
  address public immutable CROSS_CHAIN_CONTROLLER;
  address public immutable PROXY_ADMIN;

  address public payloadAddress;

  AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305 internal ethereumPayload;

  constructor(address ccc, address proxyAdmin, string memory network, uint256 blockNumber) {
    CROSS_CHAIN_CONTROLLER = ccc;
    PROXY_ADMIN = proxyAdmin;

    vm.createSelectFork(vm.rpcUrl(network), blockNumber);
    ethereumPayload = new AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _checkTrustedRemotes();
    _checkCorrectPathConfiguration();
    _checkCorrectAdapterNames();

    _checkCurrentReceiversState(true);
    _checkAllReceiversAreRepresented(true);
    _checkAllForwarderAdaptersAreRepresented(true);
    _checkImplementationAddress(
      Payload(payloadAddress).NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(),
      false
    );

    executePayload(vm, payloadAddress);

    _checkCurrentReceiversState(false);
    _checkAllReceiversAreRepresented(false);
    _checkAllForwarderAdaptersAreRepresented(false);
    _checkImplementationAddress(
      Payload(payloadAddress).NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(),
      true
    );
  }

  // -------------- virtual methods --------------------------
  function _checkCorrectPathConfiguration() internal view virtual {}

  function _getAdapterNames() internal view virtual returns (AdapterName[] memory);

  function _getTrustedRemotes() internal view virtual returns (TrustedRemote[] memory);

  function _getAdapterByChain(
    bool beforeExecution
  ) internal view virtual returns (AdapterAllowed[] memory);

  function _getForwarderAdaptersByChain(
    bool beforeExecution
  ) internal view virtual returns (ForwarderAdapters[] memory) {
    ForwarderAdapters[] memory forwarderAdapters = new ForwarderAdapters[](0);
    return forwarderAdapters;
  }

  function _getReceiverAdaptersByChain(
    bool beforeExecution
  ) internal view virtual returns (AdaptersByChain[] memory);

  // ------------------------ checks -------------
  function _checkAllForwarderAdaptersAreRepresented(bool beforeExecution) internal view {
    ForwarderAdapters[] memory forwarderAdapters = _getForwarderAdaptersByChain(beforeExecution);

    for (uint256 i = 0; i < forwarderAdapters.length; i++) {
      _testForwarderAdapterCorrectness(
        forwarderAdapters[i].chainId,
        forwarderAdapters[i].adapters,
        !beforeExecution
      );
    }
  }

  function _checkAllReceiversAreRepresented(bool beforeExecution) internal view virtual {
    AdaptersByChain[] memory receiverAdaptersByChain = _getReceiverAdaptersByChain(beforeExecution);

    for (uint256 i = 0; i < receiverAdaptersByChain.length; i++) {
      _testReceiverAdaptersByChain(
        receiverAdaptersByChain[i].chainId,
        receiverAdaptersByChain[i].adapters
      );
    }
  }

  function _checkCurrentReceiversState(bool beforeExecution) internal {
    AdapterAllowed[] memory adaptersByChain = _getAdapterByChain(beforeExecution);

    for (uint256 i = 0; i < adaptersByChain.length; i++) {
      assertEq(
        ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).isReceiverBridgeAdapterAllowed(
          adaptersByChain[i].adapter,
          adaptersByChain[i].chainId
        ),
        adaptersByChain[i].allowed
      );
    }
  }

  function _checkCorrectAdapterNames() internal {
    AdapterName[] memory adapterNames = _getAdapterNames();

    for (uint256 i = 0; i < adapterNames.length; i++) {
      string memory adapterName = IBaseAdapter(adapterNames[i].adapter).adapterName();
      assertEq(keccak256(abi.encode(adapterName)), keccak256(abi.encode(adapterNames[i].name)));
    }
  }

  function _checkTrustedRemotes() internal {
    TrustedRemote[] memory trustedRemotes = _getTrustedRemotes();

    for (uint256 i = 0; i < trustedRemotes.length; i++) {
      assertEq(
        trustedRemotes[i].expectedRemote,
        IBaseAdapter(trustedRemotes[i].adapter).getTrustedRemoteByChainId(
          trustedRemotes[i].remoteChainId
        )
      );
    }
  }

  function _checkImplementationAddress(address implementation, bool equal) internal {
    address cccImplementation = ProxyAdmin(PROXY_ADMIN).getProxyImplementation(
      TransparentUpgradeableProxy(payable(CROSS_CHAIN_CONTROLLER))
    );
    assertEq(cccImplementation == implementation, equal);
  }

  //-----------------------------------------------------------------

  function _testForwarderAdapterCorrectness(
    uint256 chainId,
    ICrossChainForwarder.ChainIdBridgeConfig[] memory adapters,
    bool checkDestination
  ) internal {
    ICrossChainForwarder.ChainIdBridgeConfig[]
      memory forwarderBridgeAdapters = ICrossChainForwarder(CROSS_CHAIN_CONTROLLER)
        .getForwarderBridgeAdaptersByChain(chainId);

    assertEq(adapters.length, forwarderBridgeAdapters.length);

    uint256 adaptersCount;
    for (uint256 i = 0; i < forwarderBridgeAdapters.length; i++) {
      for (uint256 j = 0; j < adapters.length; j++) {
        if (
          forwarderBridgeAdapters[i].currentChainBridgeAdapter ==
          adapters[j].currentChainBridgeAdapter
        ) {
          if (checkDestination) {
            if (
              forwarderBridgeAdapters[i].destinationBridgeAdapter ==
              adapters[j].destinationBridgeAdapter
            ) {
              adaptersCount++;
            }
          } else {
            adaptersCount++;
          }
        }
      }
    }
    assertEq(adaptersCount, forwarderBridgeAdapters.length);
  }

  function _testReceiverAdaptersByChain(uint256 chainId, address[] memory adapters) internal {
    address[] memory receiverAdapters = ICrossChainReceiver(CROSS_CHAIN_CONTROLLER)
      .getReceiverBridgeAdaptersByChain(chainId);

    assertEq(adapters.length, receiverAdapters.length);
    uint256 adaptersCount;
    for (uint256 i = 0; i < receiverAdapters.length; i++) {
      for (uint256 j = 0; j < adapters.length; j++) {
        if (receiverAdapters[i] == adapters[j]) {
          adaptersCount++;
        }
      }
    }
    assertEq(adaptersCount, receiverAdapters.length);
  }
}
