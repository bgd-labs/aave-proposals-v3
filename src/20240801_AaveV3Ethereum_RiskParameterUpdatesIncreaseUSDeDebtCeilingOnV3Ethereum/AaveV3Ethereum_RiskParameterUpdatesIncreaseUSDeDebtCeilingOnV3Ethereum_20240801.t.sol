// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801} from './AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801.sol';

/**
 * @dev Test for AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240801_AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum/AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801.t.sol -vv
 */
contract AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20432284);
    proposal = new AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801',
      AaveV3Ethereum.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV3EthereumAssets.USDe_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory config = _findReserveConfig(
      allConfigsAfter,
      AaveV3EthereumAssets.USDe_UNDERLYING
    );
    assertEq(config.debtCeiling, 50_000_000_00);
  }
}
