// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import 'aave-helpers/ProtocolV3TestBase.sol';

import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';

import {BaseCCCImplementationUpdatePayload} from './BaseCCCImplementationUpdatePayload.sol';

contract BaseCCCImplementationUpdatePayloadTest is ProtocolV3TestBase {
  address public immutable CROSS_CHAIN_CONTROLLER;
  address public immutable PROXY_ADMIN;

  bytes public payloadCode;
  address public payloadAddress;
  string public network;
  uint256 public blockNumber;

  constructor(
    address ccc,
    address proxyAdmin,
    bytes memory _payloadCode,
    string memory _network,
    uint256 _blockNumber
  ) {
    CROSS_CHAIN_CONTROLLER = ccc;
    PROXY_ADMIN = proxyAdmin;
    network = _network;
    blockNumber = _blockNumber;
    payloadCode = _payloadCode;
  }

  function setUp() public virtual {
    vm.createSelectFork(vm.rpcUrl(network), blockNumber);
    payloadAddress = GovV3Helpers.deployDeterministic(payloadCode);
  }

  function test_implementationOfCCCUpdate() public {
    address newImplementation = BaseCCCImplementationUpdatePayload(payloadAddress)
      .CROSS_CHAIN_CONTROLLER_IMPLEMENTATION();

    address cccImplementationBefore = ProxyAdmin(PROXY_ADMIN).getProxyImplementation(
      TransparentUpgradeableProxy(payable(CROSS_CHAIN_CONTROLLER))
    );
    assertTrue(cccImplementationBefore != newImplementation);

    executePayload(vm, payloadAddress);

    address cccImplementationAfter = ProxyAdmin(PROXY_ADMIN).getProxyImplementation(
      TransparentUpgradeableProxy(payable(CROSS_CHAIN_CONTROLLER))
    );
    assertTrue(cccImplementationAfter == newImplementation);
  }
}
