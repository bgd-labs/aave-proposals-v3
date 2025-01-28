// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122} from './AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122.sol';

/**
 * @dev Test for AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250122_AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate/AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122.t.sol -vv
 */
contract AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21681966);
    proposal = new AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_PrimeInstanceWstETHBorrowRateRsETHSupplyCapUpdate_20250122',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
