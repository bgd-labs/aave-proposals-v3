// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CAPOUpdateBaseTest} from 'src/helpers/capo/CAPOUpdateBaseTest.sol';
import {AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';

/**
 * @dev Test for AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol -vv
 */
contract AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_Test is
  ProtocolV3TestBase,
  CAPOUpdateBaseTest
{
  AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 87105250);
    proposal = new AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function _network() internal pure override returns (string memory) {
    return 'polygon';
  }

  function _reportPrefix() internal pure override returns (string memory) {
    return 'AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507';
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3Polygon.POOL;
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_addressBookOraclesMatchLive() public view {
    _assertAddressBookOracleMatchesLive(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      AaveV3PolygonAssets.MaticX_ORACLE
    );
    _assertAddressBookOracleMatchesLive(
      AaveV3PolygonAssets.wstETH_UNDERLYING,
      AaveV3PolygonAssets.wstETH_ORACLE
    );
  }

  function test_postExecution_MaticX() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'MaticX',
        adapter: AaveV3PolygonAssets.MaticX_ORACLE,
        expectedSnapshotRatio: proposal.MaticX_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.MaticX_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3PolygonAssets.MaticX_ORACLE)
      })
    );
  }

  function test_postExecution_wstETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'wstETH',
        adapter: AaveV3PolygonAssets.wstETH_ORACLE,
        expectedSnapshotRatio: proposal.wstETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.wstETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3PolygonAssets.wstETH_ORACLE)
      })
    );
  }

  function test_snapshotAnchored_MaticX() public {
    _runSnapshotAnchoredTest(
      AaveV3PolygonAssets.MaticX_ORACLE,
      proposal.MaticX_SNAPSHOT_RATIO(),
      proposal.MaticX_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_snapshotAnchored_wstETH() public {
    _runSnapshotAnchoredTest(
      AaveV3PolygonAssets.wstETH_ORACLE,
      proposal.wstETH_SNAPSHOT_RATIO(),
      proposal.wstETH_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_retrospective_MaticX() public {
    _runRetrospective(AaveV3PolygonAssets.MaticX_ORACLE, 'MaticX');
  }

  function test_retrospective_wstETH() public {
    _runRetrospective(AaveV3PolygonAssets.wstETH_ORACLE, 'wstETH');
  }

  function test_priceApproxEq_MaticX() public view {
    _assertOraclePriceApproxEq(
      AaveV3PolygonAssets.MaticX_UNDERLYING,
      0.1086e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_priceApproxEq_wstETH() public view {
    _assertOraclePriceApproxEq(
      AaveV3PolygonAssets.wstETH_UNDERLYING,
      2638e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_supplyBorrowNearLtv_wstETH_USDCn() public {
    _runSupplyBorrowNearLtv({
      collateralAsset: AaveV3PolygonAssets.wstETH_UNDERLYING,
      collateralAmount: 50 ether,
      debtAsset: AaveV3PolygonAssets.USDCn_UNDERLYING
    });
  }
}
