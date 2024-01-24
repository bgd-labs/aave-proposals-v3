// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RegisterADIScrollAdapter_20240122, ICrossChainForwarder} from './AaveV3Ethereum_RegisterADIScrollAdapter_20240122.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';

interface IBaseAdapter {
  /**
   * @notice method to get the trusted remote address from a specified chain id
   * @param chainId id of the chain from where to get the trusted remote
   * @return address of the trusted remote
   */
  function getTrustedRemoteByChainId(uint256 chainId) external view returns (address);
}

/**
 * @dev Test for AaveV3Ethereum_RegisterADIScrollAdapter_20240122
 * command: make test-contract filter=AaveV3Ethereum_RegisterADIScrollAdapter_20240122
 */
contract AaveV3Ethereum_RegisterADIScrollAdapter_20240122_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RegisterADIScrollAdapter_20240122 internal proposal;

  uint256 public ethFork;
  uint256 public scrollFork;

  function setUp() public {
    ethFork = vm.createFork(vm.rpcUrl('mainnet'), 19062921);
    scrollFork = vm.createFork(vm.rpcUrl('scroll'), 2679843);

    vm.selectFork(ethFork);
    proposal = new AaveV3Ethereum_RegisterADIScrollAdapter_20240122();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    address scroll_adapter_ethereum = proposal.SCROLL_ADAPTER_ETHEREUM();
    address scroll_adapter_scroll = proposal.SCROLL_ADAPTER_SCROLL();

    executePayload(vm, address(proposal));

    ICrossChainForwarder.ChainIdBridgeConfig[] memory ethConfig = ICrossChainForwarder(
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER
    ).getForwarderBridgeAdaptersByChain(ChainIds.SCROLL);

    assertEq(ethConfig.length, 1);
    assertEq(ethConfig[0].destinationBridgeAdapter, scroll_adapter_scroll);
    assertEq(ethConfig[0].currentChainBridgeAdapter, scroll_adapter_ethereum);

    vm.selectFork(scrollFork);
    address[] memory scrollConfig = ICrossChainReceiver(GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER)
      .getReceiverBridgeAdaptersByChain(ChainIds.MAINNET);

    assertEq(scrollConfig.length, 1);
    assertEq(scrollConfig[0], scroll_adapter_scroll);

    assertEq(
      IBaseAdapter(scroll_adapter_scroll).getTrustedRemoteByChainId(ChainIds.MAINNET),
      GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER
    );

    ICrossChainReceiver.ReceiverConfiguration memory config = ICrossChainReceiver(
      GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER
    ).getConfigurationByChain(ChainIds.MAINNET);

    assertEq(config.requiredConfirmation, uint8(1));
  }
}
