// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Ethereum.sol';
import {IDefaultInterestRateStrategy} from 'aave-address-book/AaveV2.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig, InterestStrategyValues} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502} from './AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502.sol';

/**
 * @dev Test for AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502
 * command: make test-contract filter=AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502
 */
contract AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502_Test is
  ProtocolV2TestBase
{
  AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502 internal proposal;

  struct Changes {
    address asset;
    uint256 reserveFactor;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19874343);
    proposal = new AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](5);
    assetsChanged[0] = AaveV2EthereumAssets.USDP_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.GUSD_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.LUSD_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.FRAX_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.sUSD_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint i = 0; i < assetsChanged.length; i++) {
      ReserveConfig memory cfgAfter = _findReserveConfig(allConfigsAfter, assetsChanged[i]);
      assertEq(cfgAfter.reserveFactor, 95_00);
      assertFalse(cfgAfter.borrowingEnabled);

      ReserveConfig memory cfgBefore = _findReserveConfig(allConfigsBefore, assetsChanged[i]);

      IDefaultInterestRateStrategy strategy = IDefaultInterestRateStrategy(
        cfgBefore.interestRateStrategy
      );

      InterestStrategyValues memory expectedStrategyValues = InterestStrategyValues({
        addressesProvider: address(AaveV2Ethereum.POOL_ADDRESSES_PROVIDER),
        optimalUsageRatio: _bpsToRay(20_00),
        baseVariableBorrowRate: _bpsToRay(3_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(200_00),
        stableRateSlope1: strategy.stableRateSlope1(),
        stableRateSlope2: strategy.stableRateSlope2()
      });

      _validateInterestRateStrategy(
        cfgAfter.interestRateStrategy,
        cfgAfter.interestRateStrategy,
        expectedStrategyValues
      );
    }
  }

  function _bpsToRay(uint256 amount) internal pure returns (uint256) {
    return (amount * 1e27) / 10_000;
  }
}
