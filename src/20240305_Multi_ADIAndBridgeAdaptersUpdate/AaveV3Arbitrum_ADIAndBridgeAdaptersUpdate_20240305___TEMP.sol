// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';

abstract contract BaseReceiverUpdate is IProposalGenericExecutor {
  struct ConstructorInput {
    address newCCCImplementation;
    address ccc;
    address proxyAdmin;
  }

  address public immutable NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION;
  address public immutable NEW_CROSS_CHAIN_CONTROLLER;
  address public immutable PROXY_ADMIN;

  constructor(ConstructorInput memory constructorInput) {
    NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION = constructorInput.newCCCImplementation;
    NEW_CROSS_CHAIN_CONTROLLER = constructorInput.ccc;
    PROXY_ADMIN = constructorInput.proxyAdmin;
  }

  function execute() external {
    // Update CrossChainController implementation
    ProxyAdmin(PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(CROSS_CHAIN_CONTROLLER)),
      NEW_CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );

    // remove old Receiver bridge adapter
    uint256[] supportedChains = ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).getSupportedChains();
    for (uint256 i = 0; i < supportedChains.length; i++) {
      address[] memory adaptersToRemove = ICrossChainReceiver(CROSS_CHAIN_CONTROLLER)
        .getReceiverBridgeAdaptersByChain(supportedChains[i]);

      uint256[] memory supportedChainsInput = new uint256[](1);
      supportedChainsInput[0] = supportedChains[i];

      ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
        memory adaptersToRemoveInput = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](
          adaptersToRemove.length
        );

      for (uint256 j = 0; j < adaptersToRemove.length; j++) {
        adaptersToRemoveInput[j] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
          bridgeAdapter: adaptersToRemove[j],
          chainIds: supportedChainsInput
        });
      }
      ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).disallowReceiverBridgeAdapters(
        adaptersToRemoveInput
      );
    }

    // add receiver adapters
    ICrossChainReceiver(CROSS_CHAIN_CONTROLLER).allowReceiverBridgeAdapters(
      getReceiverBridgeAdaptersToAllow()
    );
  }

  function getReceiverBridgeAdaptersToAllow()
    public
    pure
    virtual
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory);
}

/**
 * @title aDI and bridge adapters update
 * @author BGD Labs @bgdlabs
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305 is
  BaseReceiverUpdate(
    ConstructorInput({
      newCCCImplementation: 0x6e633269af45F37c44659D98f382dd0DD524E5Df,
      ccc: GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER,
      proxyAdmin: MiscArbitrum.PROXY_ADMIN
    })
  )
{
  function getReceiverBridgeAdaptersToAllow()
    public
    pure
    override
    returns (ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[] memory)
  {
    uint256[] memory receiverChainIds = new uint256[](1);
    ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[]
      memory receiverAdaptersToAllow = new ICrossChainReceiver.ReceiverBridgeAdapterConfigInput[](
        1
      );

    receiverChainIds[0] = ChainIds.MAINNET;
    receiverAdaptersToAllow[0] = ICrossChainReceiver.ReceiverBridgeAdapterConfigInput({
      bridgeAdapter: 0xc8a2ADC4261c6b669CdFf69E717E77C9cFeB420d,
      chainIds: receiverChainIds
    });

    return receiverAdaptersToAllow;
  }
}
