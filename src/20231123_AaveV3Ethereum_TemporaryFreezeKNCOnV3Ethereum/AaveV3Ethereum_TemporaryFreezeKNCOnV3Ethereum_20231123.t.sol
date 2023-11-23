// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123} from './AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123.sol';

/**
 * @dev Test for AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123
 * command: make test-contract filter=AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123
 */
contract AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123_Test is ProtocolV3TestBase {
  AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18635734);
    proposal = new AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV3Ethereum_TemporaryFreezeKNCOnV3Ethereum_20231123',
      AaveV3Ethereum.POOL,
      address(proposal)
    );

    assertEq(
      _findReserveConfig(allConfigsAfter, AaveV3EthereumAssets.KNC_UNDERLYING).isFrozen,
      true
    );
  }
}
