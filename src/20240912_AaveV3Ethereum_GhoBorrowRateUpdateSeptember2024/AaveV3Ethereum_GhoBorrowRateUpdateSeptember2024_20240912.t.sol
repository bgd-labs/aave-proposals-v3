// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912} from './AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912.sol';

/**
 * @dev Test for AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240912_AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024/AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912.t.sol -vv
 */
contract AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20736417);
    proposal = new AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GhoBorrowRateUpdateSeptember2024_20240912',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
