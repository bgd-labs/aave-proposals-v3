// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumEtherFiAssets} from 'aave-address-book/AaveV3EthereumEtherFi.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {IPriceCapAdapter} from 'src/interfaces/IPriceCapAdapter.sol';

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
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25127618);
    proposal = new AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507();
  }

  function _executePayload() internal override {
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function _network() internal pure override returns (string memory) {
    return 'mainnet';
  }

  function _reportPrefix() internal pure override returns (string memory) {
    return 'AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507';
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3Ethereum.POOL;
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

  function test_addressBookOraclesMatchLive() public view {
    _assertAddressBookOracleMatchesLive(
      AaveV3EthereumAssets.sUSDe_UNDERLYING,
      AaveV3EthereumAssets.sUSDe_ORACLE
    );
    _assertAddressBookOracleMatchesLive(
      AaveV3EthereumAssets.rETH_UNDERLYING,
      AaveV3EthereumAssets.rETH_ORACLE
    );
    _assertAddressBookOracleMatchesLive(
      AaveV3EthereumAssets.weETH_UNDERLYING,
      AaveV3EthereumAssets.weETH_ORACLE
    );
    _assertAddressBookOracleMatchesLive(
      AaveV3EthereumAssets.ETHx_UNDERLYING,
      AaveV3EthereumAssets.ETHx_ORACLE
    );
    _assertAddressBookOracleMatchesLive(
      AaveV3EthereumAssets.osETH_UNDERLYING,
      AaveV3EthereumAssets.osETH_ORACLE
    );
    _assertAddressBookOracleMatchesLive(
      AaveV3EthereumAssets.ezETH_UNDERLYING,
      AaveV3EthereumAssets.ezETH_ORACLE
    );
    _assertAddressBookOracleMatchesLive(
      AaveV3EthereumAssets.cbETH_UNDERLYING,
      AaveV3EthereumAssets.cbETH_ORACLE
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

  function test_unaffected_EtherFi_weETH() public {
    IPriceCapAdapter etherFiWeETH = IPriceCapAdapter(AaveV3EthereumEtherFiAssets.weETH_ORACLE);
    uint256 snapshotRatioBefore = etherFiWeETH.getSnapshotRatio();
    uint256 snapshotTimestampBefore = etherFiWeETH.getSnapshotTimestamp();
    uint256 maxYearlyGrowthBefore = etherFiWeETH.getMaxYearlyGrowthRatePercent();
    assertGt(snapshotRatioBefore, 0, 'precondition: EtherFi weETH adapter should be initialized');

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(etherFiWeETH.getSnapshotRatio(), snapshotRatioBefore);
    assertEq(etherFiWeETH.getSnapshotTimestamp(), snapshotTimestampBefore);
    assertEq(etherFiWeETH.getMaxYearlyGrowthRatePercent(), maxYearlyGrowthBefore);
  }

  function test_snapshotAnchored_sUSDe() public {
    _runSnapshotAnchoredTest(
      AaveV3EthereumAssets.sUSDe_ORACLE,
      proposal.sUSDe_SNAPSHOT_RATIO(),
      proposal.sUSDe_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_snapshotAnchored_rETH() public {
    _runSnapshotAnchoredTest(
      AaveV3EthereumAssets.rETH_ORACLE,
      proposal.rETH_SNAPSHOT_RATIO(),
      proposal.rETH_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_snapshotAnchored_weETH() public {
    _runSnapshotAnchoredTest(
      AaveV3EthereumAssets.weETH_ORACLE,
      proposal.weETH_SNAPSHOT_RATIO(),
      proposal.weETH_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_snapshotAnchored_ETHx() public {
    _runSnapshotAnchoredTest(
      AaveV3EthereumAssets.ETHx_ORACLE,
      proposal.ETHx_SNAPSHOT_RATIO(),
      proposal.ETHx_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_snapshotAnchored_osETH() public {
    _runSnapshotAnchoredTest(
      AaveV3EthereumAssets.osETH_ORACLE,
      proposal.osETH_SNAPSHOT_RATIO(),
      proposal.osETH_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_snapshotAnchored_ezETH() public {
    _runSnapshotAnchoredTest(
      AaveV3EthereumAssets.ezETH_ORACLE,
      proposal.ezETH_SNAPSHOT_RATIO(),
      proposal.ezETH_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_snapshotAnchored_cbETH() public {
    _runSnapshotAnchoredTest(
      AaveV3EthereumAssets.cbETH_ORACLE,
      proposal.cbETH_SNAPSHOT_RATIO(),
      proposal.cbETH_SNAPSHOT_TIMESTAMP()
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

  function test_priceApproxEq_sUSDe() public view {
    _assertOraclePriceApproxEq(
      AaveV3EthereumAssets.sUSDe_UNDERLYING,
      1.23e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_priceApproxEq_rETH() public view {
    _assertOraclePriceApproxEq(
      AaveV3EthereumAssets.rETH_UNDERLYING,
      2485e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_priceApproxEq_weETH() public view {
    _assertOraclePriceApproxEq(
      AaveV3EthereumAssets.weETH_UNDERLYING,
      2339e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_priceApproxEq_ETHx() public view {
    _assertOraclePriceApproxEq(
      AaveV3EthereumAssets.ETHx_UNDERLYING,
      2326e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_priceApproxEq_osETH() public view {
    _assertOraclePriceApproxEq(
      AaveV3EthereumAssets.osETH_UNDERLYING,
      2288e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_priceApproxEq_ezETH() public view {
    _assertOraclePriceApproxEq(
      AaveV3EthereumAssets.ezETH_UNDERLYING,
      2303e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_priceApproxEq_cbETH() public view {
    _assertOraclePriceApproxEq(
      AaveV3EthereumAssets.cbETH_UNDERLYING,
      2415e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_supplyBorrowNearLtv_rETH_USDC() public {
    _runSupplyBorrowNearLtv({
      collateralAsset: AaveV3EthereumAssets.rETH_UNDERLYING,
      collateralAmount: 100 ether,
      debtAsset: AaveV3EthereumAssets.USDC_UNDERLYING
    });
  }

  function test_supplyBorrowNearLtv_weETH_USDC() public {
    _runSupplyBorrowNearLtv({
      collateralAsset: AaveV3EthereumAssets.weETH_UNDERLYING,
      collateralAmount: 100 ether,
      debtAsset: AaveV3EthereumAssets.USDC_UNDERLYING
    });
  }
}
