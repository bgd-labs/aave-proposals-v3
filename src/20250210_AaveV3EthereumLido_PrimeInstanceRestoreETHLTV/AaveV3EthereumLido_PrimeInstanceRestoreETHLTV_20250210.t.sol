// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210} from './AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210.sol';

/**
 * @dev Test for AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250210_AaveV3EthereumLido_PrimeInstanceRestoreETHLTV/AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210.t.sol -vv
 */
contract AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21816550);
    proposal = new AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_PrimeInstanceRestoreETHLTV_20250210',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
