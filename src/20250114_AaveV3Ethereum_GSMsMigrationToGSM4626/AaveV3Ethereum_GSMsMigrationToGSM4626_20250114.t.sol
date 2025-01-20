// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GSMsMigrationToGSM4626_20250114} from './AaveV3Ethereum_GSMsMigrationToGSM4626_20250114.sol';

/**
 * @dev Test for AaveV3Ethereum_GSMsMigrationToGSM4626_20250114
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250114_AaveV3Ethereum_GSMsMigrationToGSM4626/AaveV3Ethereum_GSMsMigrationToGSM4626_20250114.t.sol -vv
 */
contract AaveV3Ethereum_GSMsMigrationToGSM4626_20250114_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GSMsMigrationToGSM4626_20250114 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21624435);
    proposal = new AaveV3Ethereum_GSMsMigrationToGSM4626_20250114();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GSMsMigrationToGSM4626_20250114',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
