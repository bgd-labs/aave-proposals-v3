// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023} from './AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.sol';

/**
 * @dev Test for AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.t.sol -vv
 */
contract AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023_Test is
  ProtocolV3TestBase
{
  AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 21510561);
    proposal = new AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023',
      AaveV3Metis.POOL,
      address(proposal)
    );
  }
}
