// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {MiscBNB} from 'aave-address-book/MiscBNB.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';

/**
 * @dev Test for AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase {
  AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 36699072);
    proposal = new AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305', AaveV3BNB.POOL, address(proposal));
  }
}
