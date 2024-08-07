// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {AaveV2Polygon_RenewalOfAaveGuardian2024_20240708} from './AaveV2Polygon_RenewalOfAaveGuardian2024_20240708.sol';
import {RenewalV2BaseTest, GuardianUpdateTestParams} from './RenewalV2BaseTest.sol';
/**
 * @dev Test for AaveV2Polygon_RenewalOfAaveGuardian2024_20240708
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20240708_Multi_RenewalOfAaveGuardian2024/AaveV2Polygon_RenewalOfAaveGuardian2024_20240708.t.sol -vv
 */
contract AaveV2Polygon_RenewalOfAaveGuardian2024_20240708_Test is RenewalV2BaseTest {
  AaveV2Polygon_RenewalOfAaveGuardian2024_20240708 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 60023363);
    proposal = new AaveV2Polygon_RenewalOfAaveGuardian2024_20240708();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Polygon_RenewalOfAaveGuardian2024_20240708',
      AaveV2Polygon.POOL,
      address(proposal)
    );
  }

  /**
   * @dev executes the test to check the guardian is updated correctly
   */
  function test_guardianUpdate() public {
    _checkGuardianUpdate(
      GuardianUpdateTestParams({
        proposal: address(proposal),
        oldGuardian: MiscPolygon.PROTOCOL_GUARDIAN,
        newGuardian: proposal.GUARDIAN(),
        addressesProvider: AaveV2Polygon.POOL_ADDRESSES_PROVIDER,
        poolConfigurator: AaveV2Polygon.POOL_CONFIGURATOR
      })
    );
  }
}
