// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Mantle, AaveV3MantleAssets} from 'aave-address-book/AaveV3Mantle.sol';
import {IPool, DataTypes} from 'aave-address-book/AaveV3.sol';
import {ReserveConfiguration} from 'aave-v3-origin/contracts/protocol/libraries/configuration/ReserveConfiguration.sol';

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
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mantle'), 95521792);
    proposal = new AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function _network() internal pure override returns (string memory) {
    return 'mantle';
  }

  function _reportPrefix() internal pure override returns (string memory) {
    return 'AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507';
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3Mantle.POOL;
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _enableMantleE2ECollateral();
    defaultTest({
      reportName: 'AaveV3Mantle_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507',
      pool: AaveV3Mantle.POOL,
      payload: address(proposal)
    });
  }

  function _enableMantleE2ECollateral() internal {
    address asset = AaveV3MantleAssets.WMNT_UNDERLYING;
    DataTypes.ReserveConfigurationMap memory config = AaveV3Mantle.POOL.getConfiguration(asset);
    assertGt(AaveV3Mantle.POOL.getConfiguration(asset).getDebtCeiling(), 0);
    config.setDebtCeiling(0);
    bytes32 slot = keccak256(abi.encode(asset, 52));
    vm.store(address(AaveV3Mantle.POOL), slot, bytes32(config.data));
    assertEq(AaveV3Mantle.POOL.getConfiguration(asset).getDebtCeiling(), 0);
  }

  function test_addressBookOraclesMatchLive() public view {
    _assertAddressBookOracleMatchesLive(
      AaveV3MantleAssets.sUSDe_UNDERLYING,
      AaveV3MantleAssets.sUSDe_ORACLE
    );
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

  function test_snapshotAnchored_sUSDe() public {
    _runSnapshotAnchoredTest(
      AaveV3MantleAssets.sUSDe_ORACLE,
      proposal.sUSDe_SNAPSHOT_RATIO(),
      proposal.sUSDe_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_retrospective_sUSDe() public {
    _runRetrospective(AaveV3MantleAssets.sUSDe_ORACLE, 'sUSDe');
  }

  function test_priceApproxEq_sUSDe() public view {
    _assertOraclePriceApproxEq(
      AaveV3MantleAssets.sUSDe_UNDERLYING,
      1.23e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }
}
