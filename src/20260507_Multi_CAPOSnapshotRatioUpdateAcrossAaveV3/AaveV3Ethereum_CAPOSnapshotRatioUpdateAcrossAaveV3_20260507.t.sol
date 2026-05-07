// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CAPOUpdateBaseTest} from 'src/helpers/capo/CAPOUpdateBaseTest.sol';
import {AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';

/**
 * @dev Test for AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol -vv
 */
contract AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_Test is
  ProtocolV3TestBase,
  CAPOUpdateBaseTest
{
  AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25044803);
    proposal = new AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_postExecution_sUSDe() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'sUSDe',
        adapter: AaveV3EthereumAssets.sUSDe_ORACLE,
        expectedSnapshotRatio: proposal.sUSDe_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.sUSDe_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: proposal.sUSDe_MAX_YEARLY_RATIO_GROWTH_PERCENT()
      })
    );
  }

  function test_postExecution_rETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'rETH',
        adapter: AaveV3EthereumAssets.rETH_ORACLE,
        expectedSnapshotRatio: proposal.rETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.rETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3EthereumAssets.rETH_ORACLE)
      })
    );
  }

  function test_postExecution_weETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'weETH',
        adapter: AaveV3EthereumAssets.weETH_ORACLE,
        expectedSnapshotRatio: proposal.weETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.weETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3EthereumAssets.weETH_ORACLE)
      })
    );
  }

  function test_postExecution_ETHx() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'ETHx',
        adapter: AaveV3EthereumAssets.ETHx_ORACLE,
        expectedSnapshotRatio: proposal.ETHx_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.ETHx_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3EthereumAssets.ETHx_ORACLE)
      })
    );
  }

  function test_postExecution_osETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'osETH',
        adapter: AaveV3EthereumAssets.osETH_ORACLE,
        expectedSnapshotRatio: proposal.osETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.osETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3EthereumAssets.osETH_ORACLE)
      })
    );
  }

  function test_postExecution_ezETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'ezETH',
        adapter: AaveV3EthereumAssets.ezETH_ORACLE,
        expectedSnapshotRatio: proposal.ezETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.ezETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3EthereumAssets.ezETH_ORACLE)
      })
    );
  }

  function test_postExecution_cbETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'cbETH',
        adapter: AaveV3EthereumAssets.cbETH_ORACLE,
        expectedSnapshotRatio: proposal.cbETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.cbETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3EthereumAssets.cbETH_ORACLE)
      })
    );
  }

  function test_retrospective_sUSDe() public {
    _runRetrospective(AaveV3EthereumAssets.sUSDe_ORACLE, 'sUSDe');
  }

  function test_retrospective_rETH() public {
    _runRetrospective(AaveV3EthereumAssets.rETH_ORACLE, 'rETH');
  }

  function test_retrospective_weETH() public {
    _runRetrospective(AaveV3EthereumAssets.weETH_ORACLE, 'weETH');
  }

  function test_retrospective_ETHx() public {
    _runRetrospective(AaveV3EthereumAssets.ETHx_ORACLE, 'ETHx');
  }

  function test_retrospective_osETH() public {
    _runRetrospective(AaveV3EthereumAssets.osETH_ORACLE, 'osETH');
  }

  function test_retrospective_ezETH() public {
    _runRetrospective(AaveV3EthereumAssets.ezETH_ORACLE, 'ezETH');
  }

  function test_retrospective_cbETH() public {
    _runRetrospective(AaveV3EthereumAssets.cbETH_ORACLE, 'cbETH');
  }

  function _runRetrospective(address adapter, string memory symbol) internal {
    _runRetrospectiveAndReport({
      adapterAddr: adapter,
      retrospectiveDays: 30,
      network: 'mainnet',
      reportName: string.concat(
        'AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_',
        symbol,
        '_Capo'
      )
    });
  }
}
