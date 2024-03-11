// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {IDefaultInterestRateStrategy} from 'aave-address-book/AaveV3.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig, InterestStrategyValues} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216} from './AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216.sol';

/**
 * @dev Test for AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216
 * command: make test-contract filter=AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216
 */
contract AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216_Test is ProtocolV3TestBase {
  AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 116936293);
    proposal = new AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216',
      AaveV3Optimism.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3OptimismAssets.WETH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory reserveConfigAfter = _findReserveConfig(allConfigsAfter, assetsChanged[0]);

    ReserveConfig memory reserveConfigBefore = _findReserveConfig(
      allConfigsBefore,
      assetsChanged[0]
    );

    IDefaultInterestRateStrategy strategy = IDefaultInterestRateStrategy(
      reserveConfigBefore.interestRateStrategy
    );

    InterestStrategyValues memory expectedStrategyValues = InterestStrategyValues({
      addressesProvider: address(AaveV3Optimism.POOL_ADDRESSES_PROVIDER),
      optimalUsageRatio: strategy.OPTIMAL_USAGE_RATIO(),
      baseVariableBorrowRate: strategy.getBaseVariableBorrowRate(),
      baseStableBorrowRate: _bpsToRay(6_00),
      variableRateSlope1: _bpsToRay(3_00),
      variableRateSlope2: strategy.getVariableRateSlope2(),
      stableRateSlope1: strategy.getStableRateSlope1(),
      stableRateSlope2: strategy.getStableRateSlope2(),
      optimalStableToTotalDebtRatio: strategy.OPTIMAL_STABLE_TO_TOTAL_DEBT_RATIO()
    });

    _validateInterestRateStrategy(
      reserveConfigAfter.interestRateStrategy,
      reserveConfigAfter.interestRateStrategy,
      expectedStrategyValues
    );
  }

  function _bpsToRay(uint256 amount) internal pure returns (uint256) {
    return (amount * 1e27) / 10_000;
  }
}
