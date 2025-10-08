// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008} from './AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008.sol';

/**
 * @dev Test for AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251008_Multi_FullDeprecationOfDPIAcrossAaveDeployments/AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008.t.sol -vv
 */
contract AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008_Test is
  ProtocolV3TestBase
{
  AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 77413306);
    proposal = new AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
