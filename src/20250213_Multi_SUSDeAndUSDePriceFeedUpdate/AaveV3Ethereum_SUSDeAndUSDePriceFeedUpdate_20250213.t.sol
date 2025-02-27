// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213} from './AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213.sol';

/**
 * @dev Test for AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250213_Multi_SUSDeAndUSDePriceFeedUpdate/AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213.t.sol -vv
 */
contract AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21840388);
    proposal = new AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
