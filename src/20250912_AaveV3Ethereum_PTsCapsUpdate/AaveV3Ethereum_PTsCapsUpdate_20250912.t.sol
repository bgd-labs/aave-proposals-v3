// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_PTsCapsUpdate_20250912} from './AaveV3Ethereum_PTsCapsUpdate_20250912.sol';

/**
 * @dev Test for AaveV3Ethereum_PTsCapsUpdate_20250912
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250912_AaveV3Ethereum_PTsCapsUpdate/AaveV3Ethereum_PTsCapsUpdate_20250912.t.sol -vv
 */
contract AaveV3Ethereum_PTsCapsUpdate_20250912_Test is ProtocolV3TestBase {
  AaveV3Ethereum_PTsCapsUpdate_20250912 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23348439);
    proposal = new AaveV3Ethereum_PTsCapsUpdate_20250912();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_PTsCapsUpdate_20250912', AaveV3Ethereum.POOL, address(proposal));
  }
}
