// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';

contract BaseCCCImplementationUpdatePayload is IProposalGenericExecutor {
  struct CCCImplementationUpdateInput {
    address proxyAdmin;
    address ccc;
    address newCCCImplementation;
  }

  address public immutable CROSS_CHAIN_CONTROLLER_IMPLEMENTATION;
  address public immutable CROSS_CHAIN_CONTROLLER;
  address public immutable PROXY_ADMIN;

  constructor(CCCImplementationUpdateInput memory updateInput) {
    PROXY_ADMIN = updateInput.proxyAdmin;
    CROSS_CHAIN_CONTROLLER = updateInput.ccc;
    CROSS_CHAIN_CONTROLLER_IMPLEMENTATION = updateInput.newCCCImplementation;
  }

  function execute() public virtual {
    // Update CrossChainController implementation
    ProxyAdmin(PROXY_ADMIN).upgradeAndCall(
      TransparentUpgradeableProxy(payable(CROSS_CHAIN_CONTROLLER)),
      CROSS_CHAIN_CONTROLLER_IMPLEMENTATION,
      abi.encodeWithSignature('initializeRevision()')
    );
  }
}
