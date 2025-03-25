// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OrbitProgramRenewal_20250325} from './AaveV3EthereumLido_OrbitProgramRenewal_20250325.sol';

/**
 * @dev Test for AaveV3EthereumLido_OrbitProgramRenewal_20250325
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250325_AaveV3EthereumLido_OrbitProgramRenewal/AaveV3EthereumLido_OrbitProgramRenewal_20250325.t.sol -vv
 */
contract AaveV3EthereumLido_OrbitProgramRenewal_20250325_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_OrbitProgramRenewal_20250325 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22124480);
    proposal = new AaveV3EthereumLido_OrbitProgramRenewal_20250325();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OrbitProgramRenewal_20250325',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
