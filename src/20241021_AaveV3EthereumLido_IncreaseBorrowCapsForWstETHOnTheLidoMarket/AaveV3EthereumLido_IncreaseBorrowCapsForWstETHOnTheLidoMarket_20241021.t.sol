// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021} from './AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021.sol';

/**
 * @dev Test for AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241021_AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket/AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021.t.sol -vv
 */
contract AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21016338);
    proposal = new AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_IncreaseBorrowCapsForWstETHOnTheLidoMarket_20241021',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }
}
