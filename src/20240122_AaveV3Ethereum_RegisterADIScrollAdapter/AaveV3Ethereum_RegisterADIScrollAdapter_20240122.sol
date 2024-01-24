// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';

interface ICrossChainForwarder {
  /**
   * @notice object storing the connected pair of bridge adapters, on current and destination chain
   * @param destinationBridgeAdapter address of the bridge adapter on the destination chain
   * @param currentChainBridgeAdapter address of the bridge adapter deployed on current network
   */
  struct ChainIdBridgeConfig {
    address destinationBridgeAdapter;
    address currentChainBridgeAdapter;
  }
  /**
   * @notice object storing the pair bridgeAdapter (current deployed chain) destination chain bridge adapter configuration
   * @param currentChainBridgeAdapter address of the bridge adapter deployed on current chain
   * @param destinationBridgeAdapter address of the bridge adapter on the destination chain
   * @param destinationChainId id of the destination chain using our own nomenclature
   */
  struct ForwarderBridgeAdapterConfigInput {
    address currentChainBridgeAdapter;
    address destinationBridgeAdapter;
    uint256 destinationChainId;
  }

  /**
   * @notice method to get all the forwarder bridge adapters of a chain
   * @param chainId id of the chain we want to get the adapters from
   * @return an array of chain configurations where the bridge adapter can communicate
   */
  function getForwarderBridgeAdaptersByChain(
    uint256 chainId
  ) external view returns (ChainIdBridgeConfig[] memory);

  /**
   * @notice method to enable bridge adapters
   * @param bridgeAdapters array of new bridge adapter configurations
   */
  function enableBridgeAdapters(ForwarderBridgeAdapterConfigInput[] memory bridgeAdapters) external;
}

/**
 * @title Register a.DI Scroll adapter
 * @author BGD Labs @bgdlabs
 * - Snapshot: N/A (Technical maintenance proposal)
 * - Forum: https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/15
 */
contract AaveV3Ethereum_RegisterADIScrollAdapter_20240122 is IProposalGenericExecutor {
  address public constant SCROLL_ADAPTER_ETHEREUM = 0xb29F03cbCc646201eC83E9F2C164747beA84b162;
  address public constant SCROLL_ADAPTER_SCROLL = 0x118DFD5418890c0332042ab05173Db4A2C1d283c;
  uint256 public constant SCROLL_CHAIN_ID = ChainIds.SCROLL;

  function execute() external {
    ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[]
      memory bridgeAdaptersToEnable = new ICrossChainForwarder.ForwarderBridgeAdapterConfigInput[](
        1
      );

    bridgeAdaptersToEnable[0] = ICrossChainForwarder.ForwarderBridgeAdapterConfigInput({
      currentChainBridgeAdapter: SCROLL_ADAPTER_ETHEREUM,
      destinationBridgeAdapter: SCROLL_ADAPTER_SCROLL,
      destinationChainId: SCROLL_CHAIN_ID
    });

    ICrossChainForwarder(GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER).enableBridgeAdapters(
      bridgeAdaptersToEnable
    );
  }
}
