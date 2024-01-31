// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IDefaultInterestRateStrategy} from 'aave-address-book/AaveV2.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig, InterestStrategyValues} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121} from './AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121.sol';

/**
 * @dev Test for AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121
 * command: make test-contract filter=AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121
 */
contract AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121_Test is ProtocolV2TestBase {
  AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19055881);
    proposal = new AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV2EthereumAssets.AMPL_UNDERLYING;

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
      addressesProvider: address(AaveV2Ethereum.POOL_ADDRESSES_PROVIDER),
      optimalUsageRatio: strategy.OPTIMAL_UTILIZATION_RATE(),
      baseVariableBorrowRate: strategy.baseVariableBorrowRate(),
      variableRateSlope1: strategy.variableRateSlope1(),
      variableRateSlope2: 0,
      stableRateSlope1: strategy.stableRateSlope1(),
      stableRateSlope2: strategy.stableRateSlope2()
    });

    _validateInterestRateStrategy(
      reserveConfigAfter.interestRateStrategy,
      reserveConfigAfter.interestRateStrategy,
      expectedStrategyValues
    );

    reserveConfigBefore.reserveFactor = 99_90;
    reserveConfigBefore.interestRateStrategy = reserveConfigAfter.interestRateStrategy;
    _validateReserveConfig(reserveConfigBefore, allConfigsAfter);
  }
}
