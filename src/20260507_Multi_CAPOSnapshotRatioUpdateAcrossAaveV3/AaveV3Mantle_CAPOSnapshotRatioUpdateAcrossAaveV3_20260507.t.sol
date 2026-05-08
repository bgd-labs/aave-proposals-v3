// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Mantle, AaveV3MantleAssets} from 'aave-address-book/AaveV3Mantle.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CAPOUpdateBaseTest} from 'src/helpers/capo/CAPOUpdateBaseTest.sol';
import {AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';

/**
 * @dev Test for AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol -vv
 */
contract AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_Test is
  ProtocolV3TestBase,
  CAPOUpdateBaseTest
{
  AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mantle'), 95023228);
    proposal = new AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest({
      reportName: 'AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507',
      pool: AaveV3Mantle.POOL,
      payload: address(proposal),
      runE2E: false, // todo debug why 'no good collateral'
      runSeatbelt: true
    });
  }

  function test_postExecution_sUSDe() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'sUSDe',
        adapter: AaveV3MantleAssets.sUSDe_ORACLE,
        expectedSnapshotRatio: proposal.sUSDe_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.sUSDe_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3MantleAssets.sUSDe_ORACLE)
      })
    );
  }

  function test_retrospective_sUSDe() public {
    _runRetrospective(AaveV3MantleAssets.sUSDe_ORACLE, 'sUSDe');
  }

  function _runRetrospective(address adapter, string memory symbol) internal {
    _runRetrospectiveAndReport({
      adapterAddr: adapter,
      retrospectiveDays: 30,
      network: 'mantle',
      reportName: string.concat(
        'AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_',
        symbol,
        '_Capo'
      )
    });
  }
}
