// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {IBaseAdapter} from 'aave-address-book/common/IBaseAdapter.sol';
import {AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {BaseAdaptersUpdatePayload} from './BaseAdaptersUpdatePayload.sol';
import {AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313.sol';
import {AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313} from './AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313.sol';

import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';

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
  function CROSS_CHAIN_CONTROLLER_IMPLEMENTATION() external returns (address);
}

abstract contract BaseTest is ProtocolV3TestBase {
  address public immutable CROSS_CHAIN_CONTROLLER;
  address public immutable PROXY_ADMIN;

  address public payloadAddress;
  string public network;
  uint256 public blockNumber;

  AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313 internal ethereumPayload;
  AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313 internal polygonPayload;
  AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313 internal avalanchePayload;
  AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313 internal binancePayload;

  constructor(address ccc, address proxyAdmin, string memory _network, uint256 _blockNumber) {
    CROSS_CHAIN_CONTROLLER = ccc;
    PROXY_ADMIN = proxyAdmin;
    network = _network;
    blockNumber = _blockNumber;
  }

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl(network), blockNumber);
    ethereumPayload = new AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313();
    polygonPayload = new AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313();
    avalanchePayload = new AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313();
    binancePayload = new AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313();
  }

  function test_trustedRemotes() public {
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receivers = BaseAdaptersUpdatePayload(payloadAddress)
        .getReceiverBridgeAdaptersToAllow();

    for (uint256 i = 0; i < receivers.length; i++) {
      for (uint256 j = 0; j < receivers[i].chainIds.length; j++) {
        if (receivers[i].chainIds[j] == ChainIds.MAINNET) {
          assertEq(
            GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER,
            IBaseAdapter(receivers[i].bridgeAdapter).getTrustedRemoteByChainId(
              receivers[i].chainIds[j]
            )
          );
        } else if (receivers[i].chainIds[j] == ChainIds.POLYGON) {
          assertEq(
            GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER,
            IBaseAdapter(receivers[i].bridgeAdapter).getTrustedRemoteByChainId(
              receivers[i].chainIds[j]
            )
          );
        } else if (receivers[i].chainIds[j] == ChainIds.AVALANCHE) {
          assertEq(
            GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER,
            IBaseAdapter(receivers[i].bridgeAdapter).getTrustedRemoteByChainId(
              receivers[i].chainIds[j]
            )
          );
        }
      }
    }
  }

  function test_correctPathConfiguration() public {
    BaseAdaptersUpdatePayload.DestinationAdaptersInput[]
      memory destinationConfigs = BaseAdaptersUpdatePayload(payloadAddress)
        .getDestinationAdapters();

    for (uint256 i = 0; i < destinationConfigs.length; i++) {
      if (destinationConfigs[i].chainId == ChainIds.MAINNET) {
        assertEq(ethereumPayload.CCIP_NEW_ADAPTER(), destinationConfigs[i].adapter);
      } else if (destinationConfigs[i].chainId == ChainIds.POLYGON) {
        assertEq(polygonPayload.CCIP_NEW_ADAPTER(), destinationConfigs[i].adapter);
      } else if (destinationConfigs[i].chainId == ChainIds.BNB) {
        assertEq(binancePayload.CCIP_NEW_ADAPTER(), destinationConfigs[i].adapter);
      } else if (destinationConfigs[i].chainId == ChainIds.AVALANCHE) {
        assertEq(avalanchePayload.CCIP_NEW_ADAPTER(), destinationConfigs[i].adapter);
      }
    }
  }

  function test_correctAdapterNames() public {
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receivers = BaseAdaptersUpdatePayload(payloadAddress)
        .getReceiverBridgeAdaptersToAllow();

    for (uint256 i = 0; i < receivers.length; i++) {
      string memory adapterName = IBaseAdapter(receivers[i].bridgeAdapter).adapterName();
      assertEq(keccak256(abi.encode(adapterName)), keccak256(abi.encode('CCIP adapter')));
    }
  }

  function test_receiversAreCorrectlySetAfterExecution() public {
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory beforeReceivers = BaseAdaptersUpdatePayload(payloadAddress)
        .getReceiverBridgeAdaptersToAllow();

    for (uint256 i = 0; i < beforeReceivers.length; i++) {
      for (uint256 j = 0; j < beforeReceivers[i].chainIds.length; j++) {
        assertEq(
          ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).isReceiverBridgeAdapterAllowed(
            beforeReceivers[i].bridgeAdapter,
            beforeReceivers[i].chainIds[j]
          ),
          false
        );
      }
    }

    executePayload(vm, payloadAddress);

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receivers = BaseAdaptersUpdatePayload(payloadAddress)
        .getReceiverBridgeAdaptersToAllow();

    for (uint256 i = 0; i < receivers.length; i++) {
      for (uint256 j = 0; j < receivers[i].chainIds.length; j++) {
        assertEq(
          ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).isReceiverBridgeAdapterAllowed(
            receivers[i].bridgeAdapter,
            receivers[i].chainIds[j]
          ),
          true
        );
      }
    }
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    //
    //    _checkAllReceiversAreRepresented(false);
    //    _checkAllForwarderAdaptersAreRepresented(false);
    _checkImplementationAddress(
      Payload(payloadAddress).CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(),
      false
    );
    //
    //    AdaptersByChain[] memory receiversBeforeExecution = _getCurrentReceiverAdaptersByChain();
    //
    executePayload(vm, payloadAddress);
    //
    //    AdaptersByChain[] memory afterBeforeExecution = _getCurrentReceiverAdaptersByChain();
    //
    //    //    _checkAllReceiversAreRepresented(true);
    //    //    _checkAllForwarderAdaptersAreRepresented(true);
    _checkImplementationAddress(
      Payload(payloadAddress).CROSS_CHAIN_CONTROLLER_IMPLEMENTATION(),
      true
    );
  }

  // -------------- virtual methods --------------------------

  function _getForwarderAdaptersByChain(
    bool afterExecution
  ) internal view virtual returns (ForwarderAdapters[] memory) {
    ForwarderAdapters[] memory forwarderAdapters = new ForwarderAdapters[](0);
    return forwarderAdapters;
  }

  function _getReceiverAdaptersByChain(
    bool afterExecution
  ) internal view virtual returns (AdaptersByChain[] memory);

  // ------------------------ checks -------------
  //  function _checkAllForwarderAdaptersAreRepresented(bool afterExecution) internal {
  //    ForwarderAdapters[] memory forwarderAdapters = _getForwarderAdaptersByChain(afterExecution);
  //
  //    for (uint256 i = 0; i < forwarderAdapters.length; i++) {
  //      _testForwarderAdapterCorrectness(
  //        forwarderAdapters[i].chainId,
  //        forwarderAdapters[i].adapters,
  //        afterExecution
  //      );
  //    }
  //  }

  function _checkAllReceiversAreRepresented(bool afterExecution) internal virtual {
    AdaptersByChain[] memory receiverAdaptersByChain = _getReceiverAdaptersByChain(afterExecution);

    for (uint256 i = 0; i < receiverAdaptersByChain.length; i++) {
      _testReceiverAdaptersByChain(
        receiverAdaptersByChain[i].chainId,
        receiverAdaptersByChain[i].adapters
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
    assertEq(adaptersCount, adapters.length);
  }

  function _testReceiverAdaptersByChain(uint256 chainId, address[] memory adapters) internal {
    address[] memory receiverAdapters = ICrossChainReceiver(CROSS_CHAIN_CONTROLLER)
      .getReceiverBridgeAdaptersByChain(chainId);

    uint256 adaptersCount;
    for (uint256 i = 0; i < receiverAdapters.length; i++) {
      for (uint256 j = 0; j < adapters.length; j++) {
        if (receiverAdapters[i] == adapters[j]) {
          adaptersCount++;
        }
      }
    }
    assertEq(adaptersCount, adapters.length);
  }

  function _testOnlyUpdatedReceiverAdapterChanges(
    address[] memory previousReceivers,
    address newAdapter,
    uint256 chainId
  ) internal {
    address[] memory currentReceiverAdapters = ICrossChainReceiver(CROSS_CHAIN_CONTROLLER)
      .getReceiverBridgeAdaptersByChain(chainId);

    uint256 adaptersCount;
    uint256 newAdapterCount;
    for (uint256 i = 0; i < currentReceiverAdapters.length; i++) {
      for (uint256 j = 0; j < previousReceivers.length; j++) {
        if (currentReceiverAdapters[i] == previousReceivers[j]) {
          adaptersCount++;
        }
        if (currentReceiverAdapters[i] == newAdapter) {
          newAdapterCount++;
        }
      }
    }

    assertEq(previousReceivers.length, currentReceiverAdapters.length);
    assertEq(currentReceiverAdapters.length, adaptersCount + newAdapterCount);
  }

  function _getCurrentReceiverAdaptersByChain() internal returns (AdaptersByChain[] memory) {
    uint256[] memory supportedChains = ICrossChainReceiver(CROSS_CHAIN_CONTROLLER)
      .getSupportedChains();

    AdaptersByChain[] memory receiverAdapters = new AdaptersByChain[](supportedChains.length);

    for (uint256 i = 0; i < supportedChains.length; i++) {
      address[] memory receivers = ICrossChainReceiver(CROSS_CHAIN_CONTROLLER)
        .getReceiverBridgeAdaptersByChain(supportedChains[i]);

      receiverAdapters[i] = AdaptersByChain({adapters: receivers, chainId: supportedChains[i]});
    }

    return receiverAdapters;
  }
}
