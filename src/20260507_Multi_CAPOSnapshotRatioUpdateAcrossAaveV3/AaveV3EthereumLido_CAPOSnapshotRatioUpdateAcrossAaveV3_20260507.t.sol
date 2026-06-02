// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {CAPOUpdateBaseTest} from 'src/helpers/capo/CAPOUpdateBaseTest.sol';
import {AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507} from './AaveV3Ethereum_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.sol';

/**
 * @dev Test for AaveV3EthereumLido_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507
 * The Lido (Prime) market shares the sUSDe and ezETH CAPO adapters with Ethereum Core,
 * so a single AaveV3Ethereum payload updates both markets.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_Multi_CAPOSnapshotRatioUpdateAcrossAaveV3/AaveV3EthereumLido_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507.t.sol -vv
 */
contract AaveV3EthereumLido_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507_Test is
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
    return 'AaveV3EthereumLido_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507';
  }

  function _pool() internal pure override returns (IPool) {
    return AaveV3EthereumLido.POOL;
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_CAPOSnapshotRatioUpdateAcrossAaveV3_20260507',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_addressBookOraclesMatchLive() public view {
    _assertAddressBookOracleMatchesLive(
      AaveV3EthereumLidoAssets.sUSDe_UNDERLYING,
      AaveV3EthereumLidoAssets.sUSDe_ORACLE
    );
    _assertAddressBookOracleMatchesLive(
      AaveV3EthereumLidoAssets.ezETH_UNDERLYING,
      AaveV3EthereumLidoAssets.ezETH_ORACLE
    );
  }

  function test_postExecution_sUSDe() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'sUSDe',
        adapter: AaveV3EthereumLidoAssets.sUSDe_ORACLE,
        expectedSnapshotRatio: proposal.sUSDe_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.sUSDe_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: proposal.sUSDe_MAX_YEARLY_RATIO_GROWTH_PERCENT()
      })
    );
  }

  function test_postExecution_ezETH() public {
    _runPostExecutionAssertions(
      OracleExpectation({
        label: 'ezETH',
        adapter: AaveV3EthereumLidoAssets.ezETH_ORACLE,
        expectedSnapshotRatio: proposal.ezETH_SNAPSHOT_RATIO(),
        expectedSnapshotTimestamp: proposal.ezETH_SNAPSHOT_TIMESTAMP(),
        expectedMaxYearlyGrowthPercent: _preservedGrowth(AaveV3EthereumLidoAssets.ezETH_ORACLE)
      })
    );
  }

  function test_snapshotAnchored_sUSDe() public {
    _runSnapshotAnchoredTest(
      AaveV3EthereumLidoAssets.sUSDe_ORACLE,
      proposal.sUSDe_SNAPSHOT_RATIO(),
      proposal.sUSDe_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_snapshotAnchored_ezETH() public {
    _runSnapshotAnchoredTest(
      AaveV3EthereumLidoAssets.ezETH_ORACLE,
      proposal.ezETH_SNAPSHOT_RATIO(),
      proposal.ezETH_SNAPSHOT_TIMESTAMP()
    );
  }

  function test_retrospective_sUSDe() public {
    _runRetrospective(AaveV3EthereumLidoAssets.sUSDe_ORACLE, 'sUSDe');
  }

  function test_retrospective_ezETH() public {
    _runRetrospective(AaveV3EthereumLidoAssets.ezETH_ORACLE, 'ezETH');
  }

  function test_priceApproxEq_sUSDe() public view {
    _assertOraclePriceApproxEq(
      AaveV3EthereumLidoAssets.sUSDe_UNDERLYING,
      1.23e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }

  function test_priceApproxEq_ezETH() public view {
    _assertOraclePriceApproxEq(
      AaveV3EthereumLidoAssets.ezETH_UNDERLYING,
      2303e8,
      PRICE_APPROX_EQ_TOLERANCE
    );
  }
}
