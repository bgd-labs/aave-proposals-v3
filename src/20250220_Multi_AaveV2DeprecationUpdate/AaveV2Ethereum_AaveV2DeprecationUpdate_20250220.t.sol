// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_AaveV2DeprecationUpdate_20250220} from './AaveV2Ethereum_AaveV2DeprecationUpdate_20250220.sol';

/**
 * @dev Test for AaveV2Ethereum_AaveV2DeprecationUpdate_20250220
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250220_Multi_AaveV2DeprecationUpdate/AaveV2Ethereum_AaveV2DeprecationUpdate_20250220.t.sol -vv
 */
contract AaveV2Ethereum_AaveV2DeprecationUpdate_20250220_Test is ProtocolV2TestBase {
  AaveV2Ethereum_AaveV2DeprecationUpdate_20250220 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21886703);
    proposal = new AaveV2Ethereum_AaveV2DeprecationUpdate_20250220();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_AaveV2DeprecationUpdate_20250220',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }
}
