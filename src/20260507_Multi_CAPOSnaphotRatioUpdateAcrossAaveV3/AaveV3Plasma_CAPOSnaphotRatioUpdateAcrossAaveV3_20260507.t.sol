// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CAPOUpdateBaseTest} from 'src/helpers/capo/CAPOUpdateBaseTest.sol';
import {AaveV3Plasma_CAPOSnaphotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Plasma_CAPOSnaphotRatioUpdateAcrossAaveV3_20260507.sol';

/**
 * @dev Test for AaveV3Plasma_CAPOSnaphotRatioUpdateAcrossAaveV3_20260507
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_Multi_CAPOSnaphotRatioUpdateAcrossAaveV3/AaveV3Plasma_CAPOSnaphotRatioUpdateAcrossAaveV3_20260507.t.sol -vv
 */
contract AaveV3Plasma_CAPOSnaphotRatioUpdateAcrossAaveV3_20260507_Test is
  ProtocolV3TestBase,
  CAPOUpdateBaseTest
{
  AaveV3Plasma_CAPOSnaphotRatioUpdateAcrossAaveV3_20260507 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 21244905);
    proposal = new AaveV3Plasma_CAPOSnaphotRatioUpdateAcrossAaveV3_20260507();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_CAPOSnaphotRatioUpdateAcrossAaveV3_20260507',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_postExecution_sUSDe() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'sUSDe',
        adapter: AaveV3PlasmaAssets.sUSDe_ORACLE,
        expectedSnapshotRatio: proposal.sUSDe_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.sUSDe_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3PlasmaAssets.sUSDe_ORACLE)
      })
    );
  }

  function test_postExecution_weETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'weETH',
        adapter: AaveV3PlasmaAssets.weETH_ORACLE,
        expectedSnapshotRatio: proposal.weETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.weETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3PlasmaAssets.weETH_ORACLE)
      })
    );
  }

  function test_retrospective_sUSDe() public {
    _runRetrospective(AaveV3PlasmaAssets.sUSDe_ORACLE, 'sUSDe');
  }

  function test_retrospective_weETH() public {
    _runRetrospective(AaveV3PlasmaAssets.weETH_ORACLE, 'weETH');
  }

  function _runRetrospective(address adapter, string memory symbol) internal {
    _runRetrospectiveAndReport({
      adapterAddr: adapter,
      retrospectiveDays: 30,
      network: 'plasma',
      reportName: string.concat(
        'AaveV3Plasma_CAPOSnaphotRatioUpdateAcrossAaveV3_20260507_',
        symbol,
        '_Capo'
      )
    });
  }
}
