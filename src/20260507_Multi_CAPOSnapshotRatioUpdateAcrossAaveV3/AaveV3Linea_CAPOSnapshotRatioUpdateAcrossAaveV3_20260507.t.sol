// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Linea, AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CAPOUpdateBaseTest} from 'src/helpers/capo/CAPOUpdateBaseTest.sol';
import {AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';

/**
 * @dev Test for AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol -vv
 */
contract AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_Test is
  ProtocolV3TestBase,
  CAPOUpdateBaseTest
{
  AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('linea'), 30547773);
    proposal = new AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507',
      AaveV3Linea.POOL,
      address(proposal)
    );
  }

  function test_postExecution_wstETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'wstETH',
        adapter: AaveV3LineaAssets.wstETH_ORACLE,
        expectedSnapshotRatio: proposal.wstETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.wstETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3LineaAssets.wstETH_ORACLE)
      })
    );
  }

  function test_postExecution_ezETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'ezETH',
        adapter: AaveV3LineaAssets.ezETH_ORACLE,
        expectedSnapshotRatio: proposal.ezETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.ezETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3LineaAssets.ezETH_ORACLE)
      })
    );
  }

  function test_postExecution_weETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'weETH',
        adapter: AaveV3LineaAssets.weETH_ORACLE,
        expectedSnapshotRatio: proposal.weETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.weETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3LineaAssets.weETH_ORACLE)
      })
    );
  }

  function test_retrospective_wstETH() public {
    _runRetrospective(AaveV3LineaAssets.wstETH_ORACLE, 'wstETH');
  }

  function test_retrospective_ezETH() public {
    _runRetrospective(AaveV3LineaAssets.ezETH_ORACLE, 'ezETH');
  }

  function test_retrospective_weETH() public {
    _runRetrospective(AaveV3LineaAssets.weETH_ORACLE, 'weETH');
  }

  function _runRetrospective(address adapter, string memory symbol) internal {
    _runRetrospectiveAndReport({
      adapterAddr: adapter,
      retrospectiveDays: 30,
      network: 'linea',
      reportName: string.concat(
        'AaveV3Linea_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_',
        symbol,
        '_Capo'
      )
    });
  }
}
