// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {StaticATokenLM} from 'aave-v3-origin/periphery/contracts/static-a-token/StaticATokenLM.sol';
import {StaticATokenFactory} from 'aave-v3-origin/periphery/contracts/static-a-token/StaticATokenFactory.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';

contract GenericUpgradePayload {
  ProxyAdmin public immutable PROXY_ADMIN;
  address public immutable FACTORY;
  address public immutable NEW_TOKEN_IMPLEMENTATION;
  address public immutable NEW_FACTORY_IMPLEMENTATION;

  constructor(
    address proxyAdmin,
    address factory,
    address newFactoryImpl,
    address newTokenImplementation
  ) {
    PROXY_ADMIN = ProxyAdmin(proxyAdmin);
    FACTORY = factory;
    NEW_FACTORY_IMPLEMENTATION = newFactoryImpl;
    NEW_TOKEN_IMPLEMENTATION = newTokenImplementation;
  }

  function execute() external {
    address[] memory tokens = StaticATokenFactory(FACTORY).getStaticATokens();
    for (uint256 i = 0; i < tokens.length; i++) {
      PROXY_ADMIN.upgradeToAndCall(
        TransparentUpgradeableProxy(payable(tokens[i])),
        NEW_TOKEN_IMPLEMENTATION,
        abi.encodeWithSelector(StaticATokenLM.upgradeInitialize.selector)
      );
    }
    PROXY_ADMIN.upgrade(TransparentUpgradeableProxy(payable(FACTORY)), NEW_FACTORY_IMPLEMENTATION);
  }
}
