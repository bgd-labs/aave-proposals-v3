// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203} from './AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.sol';

/**
 * @dev Test for AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251203_Multi_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances/AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203.t.sol -vv
 */
contract AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203_Test is
  ProtocolV3TestBase
{
  AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 73032650);
    proposal = new AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_RemoveUSDSAsCollateralAndIncreaseRFAcrossAllAaveInstances_20251203',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }
}
