// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204} from './AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204.sol';

/**
 * @dev Test for AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204.t.sol -vv
 */
contract AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204_Test is ProtocolV3TestBase {
  AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('linea'), 26320295);
    proposal = new AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204',
      AaveV3Linea.POOL,
      address(proposal)
    );
  }
}
