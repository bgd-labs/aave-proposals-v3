// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_UpdatePrimeRsETHLSTEmode_20250602} from './AaveV3EthereumLido_UpdatePrimeRsETHLSTEmode_20250602.sol';

/**
 * @dev Test for AaveV3EthereumLido_UpdatePrimeRsETHLSTEmode_20250602
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250408_AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance/AaveV3EthereumLido_UpdatePrimeRsETHLSTEmode_20250602.t.sol -vv
 */
contract AaveV3EthereumLido_UpdatePrimeRsETHLSTEmode_20250602_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_UpdatePrimeRsETHLSTEmode_20250602 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22617492);
    proposal = new AaveV3EthereumLido_UpdatePrimeRsETHLSTEmode_20250602();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_UpdatePrimeRsETHLSTEmode_20250602',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
