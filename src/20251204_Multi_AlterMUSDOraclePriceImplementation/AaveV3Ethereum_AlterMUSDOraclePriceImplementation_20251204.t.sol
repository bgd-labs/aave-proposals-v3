// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204} from './AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204.sol';

/**
 * @dev Test for AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204.t.sol -vv
 */
contract AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23938706);
    proposal = new AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
