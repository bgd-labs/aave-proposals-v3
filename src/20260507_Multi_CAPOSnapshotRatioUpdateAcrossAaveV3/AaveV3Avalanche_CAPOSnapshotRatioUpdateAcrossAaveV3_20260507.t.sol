// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CAPOUpdateBaseTest} from 'src/helpers/capo/CAPOUpdateBaseTest.sol';
import {AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';

/**
 * @dev Test for AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol -vv
 */
contract AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_Test is
  ProtocolV3TestBase,
  CAPOUpdateBaseTest
{
  AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 84842911);
    proposal = new AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_postExecution_sAVAX() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'sAVAX',
        adapter: AaveV3AvalancheAssets.sAVAX_ORACLE,
        expectedSnapshotRatio: proposal.sAVAX_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.sAVAX_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3AvalancheAssets.sAVAX_ORACLE)
      })
    );
  }

  function test_postExecution_sUSDe() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'sUSDe',
        adapter: AaveV3AvalancheAssets.sUSDe_ORACLE,
        expectedSnapshotRatio: proposal.sUSDe_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.sUSDe_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3AvalancheAssets.sUSDe_ORACLE)
      })
    );
  }

  function test_retrospective_sAVAX() public {
    _runRetrospective(AaveV3AvalancheAssets.sAVAX_ORACLE, 'sAVAX');
  }

  function test_retrospective_sUSDe() public {
    _runRetrospective(AaveV3AvalancheAssets.sUSDe_ORACLE, 'sUSDe');
  }

  function _runRetrospective(address adapter, string memory symbol) internal {
    _runRetrospectiveAndReport({
      adapterAddr: adapter,
      retrospectiveDays: 30,
      network: 'avalanche',
      reportName: string.concat(
        'AaveV3Avalanche_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_',
        symbol,
        '_Capo'
      )
    });
  }
}
