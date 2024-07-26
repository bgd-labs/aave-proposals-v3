// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GhoStewardCCIPExtension_20240726} from './AaveV3Ethereum_GhoStewardCCIPExtension_20240726.sol';

/**
 * @dev Test for AaveV3Ethereum_GhoStewardCCIPExtension_20240726
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240726_Multi_GhoStewardCCIPExtension/AaveV3Ethereum_GhoStewardCCIPExtension_20240726.t.sol -vv
 */
contract AaveV3Ethereum_GhoStewardCCIPExtension_20240726_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GhoStewardCCIPExtension_20240726 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20393794);
    proposal = new AaveV3Ethereum_GhoStewardCCIPExtension_20240726();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GhoStewardCCIPExtension_20240726',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
