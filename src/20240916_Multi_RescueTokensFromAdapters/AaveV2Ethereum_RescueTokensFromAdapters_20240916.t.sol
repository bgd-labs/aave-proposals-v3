// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV3Ethereum_RescueTokensFromAdapters_20240916} from './AaveV3Ethereum_RescueTokensFromAdapters_20240916.sol';

/**
 * @dev Test for AaveV2Ethereum_RescueTokensFromAdapters_20240916
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240916_Multi_RescueTokensFromAdapters/AaveV2Ethereum_RescueTokensFromAdapters_20240916.t.sol -vv
 */
contract AaveV3Ethereum_RescueTokensFromAdapters_20240916_Test is ProtocolV2TestBase {
  AaveV3Ethereum_RescueTokensFromAdapters_20240916 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20734906);
    proposal = new AaveV3Ethereum_RescueTokensFromAdapters_20240916();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RescueTokensFromAdapters_20240916',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }
}
