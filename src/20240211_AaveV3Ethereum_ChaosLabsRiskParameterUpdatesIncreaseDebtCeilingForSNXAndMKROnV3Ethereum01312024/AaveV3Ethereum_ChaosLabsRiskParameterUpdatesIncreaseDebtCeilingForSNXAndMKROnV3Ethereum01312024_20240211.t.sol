// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211} from './AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211.sol';

/**
 * @dev Test for AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211
 * command: make test-contract filter=AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211
 */
contract AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19204803);
    proposal = new AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Ethereum_ChaosLabsRiskParameterUpdatesIncreaseDebtCeilingForSNXAndMKROnV3Ethereum01312024_20240211',
      AaveV3Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](2);
    assetsChanged[0] = AaveV3EthereumAssets.MKR_UNDERLYING;
    assetsChanged[1] = AaveV3EthereumAssets.SNX_UNDERLYING;
    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory mkrConfigAfter = _findReserveConfig(allConfigsAfter, assetsChanged[0]);
    mkrConfigAfter.debtCeiling = 12_000_000_00;
    _validateReserveConfig(mkrConfigAfter, allConfigsAfter);

    ReserveConfig memory snxConfigAfter = _findReserveConfig(allConfigsAfter, assetsChanged[1]);
    snxConfigAfter.debtCeiling = 4_000_000_00;
    _validateReserveConfig(snxConfigAfter, allConfigsAfter);
  }
}
