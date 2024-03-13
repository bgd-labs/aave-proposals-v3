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
import {BaseCCCImplementationUpdatePayloadTest} from './BaseCCCImplementationUpdatePayloadTest.sol';

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

abstract contract BaseTest is BaseCCCImplementationUpdatePayloadTest {
  BaseAdaptersUpdatePayload internal ethereumPayload;
  BaseAdaptersUpdatePayload internal polygonPayload;
  BaseAdaptersUpdatePayload internal avalanchePayload;
  BaseAdaptersUpdatePayload internal binancePayload;

  constructor(
    address ccc,
    address proxyAdmin,
    bytes memory _payloadCode,
    string memory _network,
    uint256 _blockNumber
  ) BaseCCCImplementationUpdatePayloadTest(ccc, proxyAdmin, _payloadCode, _network, _blockNumber) {}

  function setUp() public override {
    super.setUp();
    ethereumPayload = new AaveV3Ethereum_UpdateADIImplementationAndCCIPAdapters_20240313();
    polygonPayload = new AaveV3Polygon_UpdateADIImplementationAndCCIPAdapters_20240313();
    avalanchePayload = new AaveV3Avalanche_UpdateADIImplementationAndCCIPAdapters_20240313();
    binancePayload = new AaveV3BNB_UpdateADIImplementationAndCCIPAdapters_20240313();
  }

  function getPayloadByChainId(uint256 chainId) public view returns (BaseAdaptersUpdatePayload) {
    if (chainId == ChainIds.MAINNET) {
      return ethereumPayload;
    } else if (chainId == ChainIds.POLYGON) {
      return polygonPayload;
    } else if (chainId == ChainIds.BNB) {
      return binancePayload;
    } else if (chainId == ChainIds.AVALANCHE) {
      return avalanchePayload;
    }
    revert();
  }

  function getTrustedRemoteByChainId(uint256 chainId) public view returns (address) {
    if (chainId == ChainIds.MAINNET) {
      return GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER;
    } else if (chainId == ChainIds.POLYGON) {
      return GovernanceV3Polygon.CROSS_CHAIN_CONTROLLER;
    } else if (chainId == ChainIds.AVALANCHE) {
      return GovernanceV3Avalanche.CROSS_CHAIN_CONTROLLER;
    }
    revert();
  }

  function test_trustedRemotes() public {
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receivers = BaseAdaptersUpdatePayload(payloadAddress)
        .getReceiverBridgeAdaptersToAllow();

    for (uint256 i = 0; i < receivers.length; i++) {
      for (uint256 j = 0; j < receivers[i].chainIds.length; j++) {
        assertEq(
          getTrustedRemoteByChainId(receivers[i].chainIds[j]),
          IBaseAdapter(receivers[i].bridgeAdapter).getTrustedRemoteByChainId(
            receivers[i].chainIds[j]
          )
        );
      }
    }
  }

  function test_correctPathConfiguration() public {
    BaseAdaptersUpdatePayload.DestinationAdaptersInput[]
      memory destinationConfigs = BaseAdaptersUpdatePayload(payloadAddress)
        .getDestinationAdapters();

    for (uint256 i = 0; i < destinationConfigs.length; i++) {
      assertEq(
        getPayloadByChainId(destinationConfigs[i].chainId).CCIP_NEW_ADAPTER(),
        destinationConfigs[i].adapter
      );
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

  function test_onlyUpdatedNeededAdapter() public {
    uint256[] memory supportedChainsBefore = ICrossChainReceiver(CROSS_CHAIN_CONTROLLER)
      .getSupportedChains();
    AdaptersByChain[] memory adaptersBefore = _getCurrentReceiverAdaptersByChain();

    executePayload(vm, payloadAddress);

    uint256[] memory supportedChainsAfter = ICrossChainReceiver(CROSS_CHAIN_CONTROLLER)
      .getSupportedChains();

    assertEq(supportedChainsBefore, supportedChainsAfter);
    for (uint256 i = 0; i < supportedChainsBefore.length; i++) {
      assertEq(supportedChainsAfter[i], supportedChainsBefore[i]);
    }

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory adaptersToRemove = BaseAdaptersUpdatePayload(payloadAddress)
        .getReceiverBridgeAdaptersToRemove();

    for (uint256 i = 0; i < adaptersBefore.length; i++) {
      for (uint256 j = 0; j < adaptersToRemove.length; j++) {
        for (uint256 x = 0; x < adaptersToRemove[j].chainIds.length; x++) {
          if (adaptersToRemove[j].chainIds[x] == adaptersBefore[i].chainId) {
            for (uint256 k = 0; k < adaptersBefore[i].adapters.length; k++) {
              if (adaptersBefore[i].adapters[k] == adaptersToRemove[j].bridgeAdapter) {
                assertEq(
                  ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).isReceiverBridgeAdapterAllowed(
                    adaptersToRemove[j].bridgeAdapter,
                    adaptersBefore[i].chainId
                  ),
                  false
                );
              } else {
                assertEq(
                  ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).isReceiverBridgeAdapterAllowed(
                    adaptersBefore[i].adapters[k],
                    adaptersBefore[i].chainId
                  ),
                  true
                );
              }
            }
          }
        }
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
