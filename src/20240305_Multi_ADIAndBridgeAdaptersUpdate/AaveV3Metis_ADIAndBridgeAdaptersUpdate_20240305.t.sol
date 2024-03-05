// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305} from './AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305.sol';
import {ChainIds} from 'aave-helpers/ChainIds.sol';
import {ProxyAdmin} from 'solidity-utils/contracts/transparent-proxy/ProxyAdmin.sol';
import {MiscMetis} from 'aave-address-book/MiscMetis.sol';
import {TransparentUpgradeableProxy} from 'solidity-utils/contracts/transparent-proxy/TransparentUpgradeableProxy.sol';
import {ICrossChainReceiver} from 'aave-address-book/common/ICrossChainController.sol';

/**
 * @dev Test for AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305
 * command: make test-contract filter=AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305
 */
contract AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305_Test is ProtocolV3TestBase {
  AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 14662925);
    proposal = new AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305',
      AaveV3Metis.POOL,
      address(proposal)
    );
  }
}
