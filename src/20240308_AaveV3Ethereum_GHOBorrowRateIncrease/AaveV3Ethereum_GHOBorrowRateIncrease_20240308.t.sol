// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GHOBorrowRateIncrease_20240308} from './AaveV3Ethereum_GHOBorrowRateIncrease_20240308.sol';
import {GhoInterestRateStrategy} from './GhoInterestRateStrategy.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOBorrowRateIncrease_20240308
 * command: make test-contract filter=AaveV3Ethereum_GHOBorrowRateIncrease_20240308
 */
contract AaveV3Ethereum_GHOBorrowRateIncrease_20240308_Test is ProtocolV3TestBase {
  GhoInterestRateStrategy internal interestRateStrategy;
  AaveV3Ethereum_GHOBorrowRateIncrease_20240308 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19391086);
    interestRateStrategy = GhoInterestRateStrategy(
      GovV3Helpers.deployDeterministic(type(GhoInterestRateStrategy).creationCode)
    );
    proposal = AaveV3Ethereum_GHOBorrowRateIncrease_20240308(
      GovV3Helpers.deployDeterministic(
        type(AaveV3Ethereum_GHOBorrowRateIncrease_20240308).creationCode,
        abi.encode(
          GovV3Helpers.predictDeterministicAddress(type(GhoInterestRateStrategy).creationCode)
        )
      )
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHOBorrowRateIncrease_20240308',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
