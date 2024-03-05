// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305 is IProposalGenericExecutor {
  address public constant ADAPTER_TO_REMOVE = 0x3829943c53F2d00e20B58475aF19716724bF90Ba;
  address public constant NEW_ADAPTER = address(0); // TODO: change for real address when deployed
  address public constant NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION = address(0); // TODO: change for real address when deployed

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(MiscArbitrum.PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER)),
      NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );

    // Set new Receiver bridge adapter
    uint256[] memory chainIds = new uint256[](1);
    chainIds[0] = ChainIds.MAINNET;

    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdapterConfig = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](1);

    bridgeAdapterConfig[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: NEW_ADAPTER,
      chainIds: chainIds
    });

    ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
      bridgeAdapterConfig
    );

    // remove old Receiver bridge adapter
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory bridgeAdaptersToRemove = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](1);

    bridgeAdaptersToRemove[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: ADAPTER_TO_REMOVE,
      chainIds: chainIds
    });
    ICrossChainReceiver(GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(
      bridgeAdaptersToRemove
    );
  }
}
