// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CAPOUpdateBaseTest} from 'src/helpers/capo/CAPOUpdateBaseTest.sol';
import {AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';

/**
 * @dev Test for AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol -vv
 */
contract AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_Test is
  ProtocolV3TestBase,
  CAPOUpdateBaseTest
{
  AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 46250763);
    proposal = new AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function _network() internal pure override returns (string memory) {
    return 'gnosis';
  }

  function _reportPrefix() internal pure override returns (string memory) {
    return 'AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507';
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3Gnosis.POOL;
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }

  function test_addressBookOraclesMatchLive() public view {
    _assertAddressBookOracleMatchesLive(
      AaveV3GnosisAssets.wstETH_UNDERLYING,
      AaveV3GnosisAssets.wstETH_ORACLE
    );
    _assertAddressBookOracleMatchesLive(
      AaveV3GnosisAssets.sDAI_UNDERLYING,
      AaveV3GnosisAssets.sDAI_ORACLE
    );
  }

  function test_postExecution_wstETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'wstETH',
        adapter: AaveV3GnosisAssets.wstETH_ORACLE,
        expectedSnapshotRatio: proposal.wstETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.wstETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3GnosisAssets.wstETH_ORACLE)
      })
    );
  }

  function test_postExecution_sDAI() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'sDAI',
        adapter: AaveV3GnosisAssets.sDAI_ORACLE,
        expectedSnapshotRatio: proposal.sDAI_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.sDAI_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3GnosisAssets.sDAI_ORACLE)
      })
    );
  }

  function test_snapshotAnchored_wstETH() public {
    _runSnapshotAnchoredTest(
      AaveV3GnosisAssets.wstETH_ORACLE,
      proposal.wstETH_SNAPSHOT_RATIO(),
      proposal.wstETH_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_snapshotAnchored_sDAI() public {
    _runSnapshotAnchoredTest(
      AaveV3GnosisAssets.sDAI_ORACLE,
      proposal.sDAI_SNAPSHOT_RATIO(),
      proposal.sDAI_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_retrospective_wstETH() public {
    _runRetrospective(AaveV3GnosisAssets.wstETH_ORACLE, 'wstETH');
  }

  function test_retrospective_sDAI() public {
    _runRetrospective(AaveV3GnosisAssets.sDAI_ORACLE, 'sDAI');
  }

  function test_priceApproxEq_wstETH() public view {
    _assertOraclePriceApproxEq(
      AaveV3GnosisAssets.wstETH_UNDERLYING,
      2634e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_priceApproxEq_sDAI() public view {
    _assertOraclePriceApproxEq(
      AaveV3GnosisAssets.sDAI_UNDERLYING,
      1.24e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_supplyBorrowNearLtv_wstETH_WXDAI() public {
    _runSupplyBorrowNearLtv({
      collateralAsset: AaveV3GnosisAssets.wstETH_UNDERLYING,
      collateralAmount: 10 ether,
      debtAsset: AaveV3GnosisAssets.WXDAI_UNDERLYING
    });
  }
}
