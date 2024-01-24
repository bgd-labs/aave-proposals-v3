// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ICrossChainForwarder} from 'aave-address-book/common/ICrossChainController.sol';

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
