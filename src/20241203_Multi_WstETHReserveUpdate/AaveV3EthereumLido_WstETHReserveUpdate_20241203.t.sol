// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_WstETHReserveUpdate_20241203} from './AaveV3EthereumLido_WstETHReserveUpdate_20241203.sol';

/**
 * @dev Test for AaveV3EthereumLido_WstETHReserveUpdate_20241203
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241203_Multi_WstETHReserveUpdate/AaveV3EthereumLido_WstETHReserveUpdate_20241203.t.sol -vv
 */
contract AaveV3EthereumLido_WstETHReserveUpdate_20241203_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_WstETHReserveUpdate_20241203 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21322524);
    proposal = new AaveV3EthereumLido_WstETHReserveUpdate_20241203();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_WstETHReserveUpdate_20241203',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
