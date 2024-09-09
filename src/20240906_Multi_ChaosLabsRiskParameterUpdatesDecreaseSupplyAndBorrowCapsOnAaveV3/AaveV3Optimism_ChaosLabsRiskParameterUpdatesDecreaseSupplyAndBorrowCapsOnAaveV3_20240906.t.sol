// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906} from './AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.sol';

/**
 * @dev Test for AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240906_Multi_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3/AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906.t.sol -vv
 */
contract AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906_Test is
  ProtocolV3TestBase
{
  AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 125022388);
    proposal = new AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_ChaosLabsRiskParameterUpdatesDecreaseSupplyAndBorrowCapsOnAaveV3_20240906',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }
}
