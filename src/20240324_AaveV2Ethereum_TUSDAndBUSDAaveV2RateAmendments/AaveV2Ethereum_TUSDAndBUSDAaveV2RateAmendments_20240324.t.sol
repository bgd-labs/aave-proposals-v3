// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IDefaultInterestRateStrategy} from 'aave-address-book/AaveV2.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig, InterestStrategyValues} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324} from './AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324.sol';

/**
 * @dev Test for AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324
 * command: make test-contract filter=AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324
 */
contract AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324_Test is ProtocolV2TestBase {
  AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19502937);
    proposal = new AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_TUSDAndBUSDAaveV2RateAmendments_20240324',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV2EthereumAssets.BUSD_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.TUSD_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetsChanged.length; i++) {
      ReserveConfig memory reserveConfigAfter = _findReserveConfig(
        allConfigsAfter,
        assetsChanged[i]
      );

      ReserveConfig memory reserveConfigBefore = _findReserveConfig(
        allConfigsBefore,
        assetsChanged[i]
      );

      IDefaultInterestRateStrategy strategyBefore = IDefaultInterestRateStrategy(
        reserveConfigBefore.interestRateStrategy
      );

      InterestStrategyValues memory expectedStrategyValues = InterestStrategyValues({
        addressesProvider: address(AaveV2Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: strategyBefore.OPTIMAL_UTILIZATION_RATE(),
        baseVariableBorrowRate: _bpsToRay(10_00),
        variableRateSlope1: 0,
        variableRateSlope2: 0,
        stableRateSlope1: strategyBefore.stableRateSlope1(),
        stableRateSlope2: strategyBefore.stableRateSlope2()
      });

      _validateInterestRateStrategy(
        reserveConfigAfter.interestRateStrategy,
        reserveConfigAfter.interestRateStrategy,
        expectedStrategyValues
      );
    }
  }

  function _bpsToRay(uint256 amount) internal pure returns (uint256) {
    return (amount * 1e27) / 10_000;
  }
}
