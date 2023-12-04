// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IDefaultInterestRateStrategy} from 'aave-address-book/AaveV2.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig, InterestStrategyValues} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203} from './AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203.sol';

/**
 * @dev Test for AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203
 * command: make test-contract filter=AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203
 */
contract AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203_Test is ProtocolV2TestBase {
  AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18706339);
    proposal = new AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203();
  }

  function _validateChanges(
    ReserveConfig memory reserveConfigBefore,
    ReserveConfig memory reserveConfigAfter,
    ReserveConfig[] memory allConfigsAfter
  ) internal view {
    IDefaultInterestRateStrategy strategy = IDefaultInterestRateStrategy(
      reserveConfigBefore.interestRateStrategy
    );

    InterestStrategyValues memory expectedStrategyValues = InterestStrategyValues({
      addressesProvider: address(AaveV2Ethereum.POOL_ADDRESSES_PROVIDER),
      optimalUsageRatio: strategy.OPTIMAL_UTILIZATION_RATE(),
      baseVariableBorrowRate: _bpsToRay(20_00),
      variableRateSlope1: _bpsToRay(0),
      variableRateSlope2: _bpsToRay(300_00),
      stableRateSlope1: strategy.stableRateSlope1(),
      stableRateSlope2: strategy.stableRateSlope2()
    });

    _validateInterestRateStrategy(
      reserveConfigAfter.interestRateStrategy,
      reserveConfigAfter.interestRateStrategy,
      expectedStrategyValues
    );

    reserveConfigBefore.reserveFactor = 99_00;
    reserveConfigBefore.interestRateStrategy = reserveConfigAfter.interestRateStrategy;
    _validateReserveConfig(reserveConfigBefore, allConfigsAfter);
  }

  function testProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203',
      AaveV2Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](20);
    assetsChanged[0] = AaveV2EthereumAssets.YFI_UNDERLYING;
    assetsChanged[1] = AaveV2EthereumAssets.ZRX_UNDERLYING;
    assetsChanged[2] = AaveV2EthereumAssets.UNI_UNDERLYING;
    assetsChanged[3] = AaveV2EthereumAssets.BAT_UNDERLYING;
    assetsChanged[4] = AaveV2EthereumAssets.ENJ_UNDERLYING;
    assetsChanged[5] = AaveV2EthereumAssets.KNC_UNDERLYING;
    assetsChanged[6] = AaveV2EthereumAssets.MANA_UNDERLYING;
    assetsChanged[7] = AaveV2EthereumAssets.MKR_UNDERLYING;
    assetsChanged[8] = AaveV2EthereumAssets.REN_UNDERLYING;
    assetsChanged[9] = AaveV2EthereumAssets.SNX_UNDERLYING;
    assetsChanged[10] = AaveV2EthereumAssets.CRV_UNDERLYING;
    assetsChanged[11] = AaveV2EthereumAssets.BAL_UNDERLYING;
    assetsChanged[12] = AaveV2EthereumAssets.xSUSHI_UNDERLYING;
    assetsChanged[13] = AaveV2EthereumAssets.RAI_UNDERLYING;
    assetsChanged[14] = AaveV2EthereumAssets.AMPL_UNDERLYING;
    assetsChanged[15] = AaveV2EthereumAssets.DPI_UNDERLYING;
    assetsChanged[16] = AaveV2EthereumAssets.ENS_UNDERLYING;
    assetsChanged[17] = AaveV2EthereumAssets.UST_UNDERLYING;
    assetsChanged[18] = AaveV2EthereumAssets.CVX_UNDERLYING;
    assetsChanged[19] = AaveV2EthereumAssets.ONE_INCH_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    for (uint256 i = 0; i < assetsChanged.length; i++) {
      ReserveConfig memory reserveConfigBefore = _findReserveConfig(
        allConfigsBefore,
        assetsChanged[i]
      );
      ReserveConfig memory reserveConfigAfter = _findReserveConfig(
        allConfigsAfter,
        assetsChanged[i]
      );
      _validateChanges(reserveConfigBefore, reserveConfigAfter, allConfigsAfter);
    }
  }

  function _bpsToRay(uint256 amount) internal pure returns (uint256) {
    return (amount * 1e27) / 10_000;
  }
}
