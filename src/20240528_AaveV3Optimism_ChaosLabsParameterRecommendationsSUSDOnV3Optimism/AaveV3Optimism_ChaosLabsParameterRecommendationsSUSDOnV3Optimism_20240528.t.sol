// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528} from './AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528.sol';
import {AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {DataTypes} from 'aave-address-book/AaveV3.sol';

/**
 * @dev Test for AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240528_AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism/AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528.t.sol -vv
 */
contract AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528_Test is
  ProtocolV3TestBase
{
  AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 120646741);
    proposal = new AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528',
      AaveV3Optimism.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3OptimismAssets.sUSD_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory config = _findReserveConfig(
      allConfigsAfter,
      AaveV3OptimismAssets.sUSD_UNDERLYING
    );
    assertEq(config.isFrozen, false);
    assertEq(config.ltv, 60_00);
    assertEq(config.liquidationThreshold, 70_00);
    assertEq(config.borrowCap, 5_600_000);
    assertEq(config.supplyCap, 7_000_000);

    DataTypes.EModeCategory memory eModeStablecoinCategory = AaveV3Optimism
      .POOL
      .getEModeCategoryData(1);
    assertEq(eModeStablecoinCategory.ltv, 90_00);
    assertEq(eModeStablecoinCategory.liquidationThreshold, 93_00);
  }
}
