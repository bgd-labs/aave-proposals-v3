// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import 'aave-helpers/ProtocolV3TestBase.sol';

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ICrossChainReceiver, ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {IBaseAdapter} from 'aave-address-book/common/IBaseAdapter.sol';

import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {GovernanceV3Avalanche} from 'aave-address-book/GovernanceV3Avalanche.sol';

import {AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';
import {BaseAdaptersUpdatePayload} from './BaseAdaptersUpdatePayload.sol';
import {AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';
import {AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';
import {AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';
import {AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322} from './AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322.sol';

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

  bytes public payloadCode;
  address public payloadAddress;
  string public network;
  uint256 public blockNumber;

  BaseAdaptersUpdatePayload internal ethereumPayload;
  BaseAdaptersUpdatePayload internal polygonPayload;
  BaseAdaptersUpdatePayload internal avalanchePayload;
  BaseAdaptersUpdatePayload internal binancePayload;
  BaseAdaptersUpdatePayload internal gnosisPayload;

  constructor(
    address ccc,
    bytes memory _payloadCode,
    string memory _network,
    uint256 _blockNumber
  ) {
    CROSS_CHAIN_CONTROLLER = ccc;
    network = _network;
    blockNumber = _blockNumber;
    payloadCode = _payloadCode;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl(network), blockNumber);
    payloadAddress = GovV3Helpers.deployDeterministic(payloadCode);

    ethereumPayload = new AaveV3Ethereum_LayerZeroBridgeAdapterUpdateToV2_20240322();
    polygonPayload = new AaveV3Polygon_LayerZeroBridgeAdapterUpdateToV2_20240322();
    avalanchePayload = new AaveV3Avalanche_LayerZeroBridgeAdapterUpdateToV2_20240322();
    binancePayload = new AaveV3BNB_LayerZeroBridgeAdapterUpdateToV2_20240322();
    gnosisPayload = new AaveV3Gnosis_LayerZeroBridgeAdapterUpdateToV2_20240322();
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
    } else if (chainId == ChainIds.GNOSIS) {
      return gnosisPayload;
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
        getPayloadByChainId(destinationConfigs[i].chainId).LZ_NEW_ADAPTER(),
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
      assertEq(keccak256(abi.encode(adapterName)), keccak256(abi.encode('LayerZero adapter')));
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

  function test_forwarderAdaptersAreSet() public {
    executePayload(vm, payloadAddress);

    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory forwarders = BaseAdaptersUpdatePayload(payloadAddress)
        .getForwarderBridgeAdaptersToEnable();

    for (uint256 i = 0; i < forwarders.length; i++) {
      ICrossChainForwarder.ChainIdBridgeConfig[]
        memory forwardersBridgeAdaptersByChain = ICrossChainForwarder(CROSS_CHAIN_CONTROLLER)
          .getForwarderBridgeAdaptersByChain(forwarders[i].destinationChainId);
      bool newAdapterFound;
      for (uint256 j = 0; j < forwardersBridgeAdaptersByChain.length; j++) {
        if (
          forwardersBridgeAdaptersByChain[j].destinationBridgeAdapter ==
          forwarders[i].destinationBridgeAdapter &&
          forwardersBridgeAdaptersByChain[j].currentChainBridgeAdapter ==
          forwarders[i].currentChainBridgeAdapter
        ) {
          newAdapterFound = true;
        }
      }
      assertEq(newAdapterFound, true);
    }
  }

  function test_onlyChangedNeededForwarders() public {
    ForwarderAdapters[]
      memory forwardersBridgeAdaptersByChainBefore = _getCurrentForwarderAdaptersByChain();

    ICrossChainForwarder.BridgeAdapterToDisable[]
      memory adaptersToRemove = BaseAdaptersUpdatePayload(payloadAddress)
        .getForwarderBridgeAdaptersToRemove();

    executePayload(vm, payloadAddress);

    ForwarderAdapters[]
      memory forwardersBridgeAdaptersByChainAfter = _getCurrentForwarderAdaptersByChain();

    assertEq(
      forwardersBridgeAdaptersByChainAfter.length,
      forwardersBridgeAdaptersByChainBefore.length
    );

    for (uint256 l = 0; l < forwardersBridgeAdaptersByChainBefore.length; l++) {
      for (uint256 j = 0; j < forwardersBridgeAdaptersByChainAfter.length; j++) {
        if (
          forwardersBridgeAdaptersByChainBefore[l].chainId ==
          forwardersBridgeAdaptersByChainAfter[j].chainId
        ) {
          for (uint256 i = 0; i < forwardersBridgeAdaptersByChainBefore[l].adapters.length; i++) {
            bool forwarderFound;
            for (uint256 m = 0; m < forwardersBridgeAdaptersByChainAfter[j].adapters.length; m++) {
              if (
                forwardersBridgeAdaptersByChainBefore[l].adapters[i].destinationBridgeAdapter ==
                forwardersBridgeAdaptersByChainAfter[j].adapters[m].destinationBridgeAdapter &&
                forwardersBridgeAdaptersByChainBefore[l].adapters[i].currentChainBridgeAdapter ==
                forwardersBridgeAdaptersByChainAfter[j].adapters[m].currentChainBridgeAdapter
              ) {
                forwarderFound = true;
                break;
              }
            }
            if (!forwarderFound) {
              bool isAdapterToBeRemoved;
              for (uint256 k = 0; k < adaptersToRemove.length; k++) {
                if (
                  forwardersBridgeAdaptersByChainBefore[l].adapters[i].currentChainBridgeAdapter ==
                  adaptersToRemove[k].bridgeAdapter
                ) {
                  for (uint256 n = 0; n < adaptersToRemove[k].chainIds.length; n++) {
                    if (
                      forwardersBridgeAdaptersByChainBefore[l].chainId ==
                      adaptersToRemove[k].chainIds[n]
                    ) {
                      isAdapterToBeRemoved = true;
                      break;
                    }
                  }
                }
              }
              assertEq(isAdapterToBeRemoved, true);
            }
          }
        }
      }
    }
  }

  function _getCurrentForwarderAdaptersByChain() internal returns (ForwarderAdapters[] memory) {
    uint256[] memory supportedChains = new uint256[](10);
    supportedChains[0] = ChainIds.POLYGON;
    supportedChains[1] = ChainIds.AVALANCHE;
    supportedChains[2] = ChainIds.BNB;
    supportedChains[3] = ChainIds.GNOSIS;
    supportedChains[4] = ChainIds.ARBITRUM;
    supportedChains[5] = ChainIds.OPTIMISM;
    supportedChains[6] = ChainIds.METIS;
    supportedChains[7] = ChainIds.BASE;
    supportedChains[8] = ChainIds.SCROLL;
    supportedChains[9] = ChainIds.MAINNET;

    ForwarderAdapters[] memory forwarderAdapters = new ForwarderAdapters[](supportedChains.length);

    for (uint256 i = 0; i < supportedChains.length; i++) {
      ICrossChainForwarder.ChainIdBridgeConfig[] memory forwarders = ICrossChainForwarder(
        CROSS_CHAIN_CONTROLLER
      ).getForwarderBridgeAdaptersByChain(supportedChains[i]);

      forwarderAdapters[i] = ForwarderAdapters({adapters: forwarders, chainId: supportedChains[i]});
    }
    return forwarderAdapters;
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
