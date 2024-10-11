// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001} from './AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001.sol';

/**
 * @dev Test for AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241001_AaveV3EthereumLido_WstETHSlope1UoptimalUpdate/AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001.t.sol -vv
 */
contract AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20936571);
    proposal = new AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_WstETHSlope1UoptimalUpdate_20241001',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
