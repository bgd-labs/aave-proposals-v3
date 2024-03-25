// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovV3Helpers, IPayloadsControllerCore, PayloadsControllerUtils} from 'aave-helpers/GovV3Helpers.sol';

import {AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324} from './AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324.sol';
import {GhoInterestRateStrategy} from './GhoInterestRateStrategy.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324
 * command: make test-contract filter=AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324
 */
contract AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324 internal proposal;
  GhoInterestRateStrategy internal strategy;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19511307);
    strategy = GhoInterestRateStrategy(
      GovV3Helpers.deployDeterministic(type(GhoInterestRateStrategy).creationCode)
    );

    proposal = AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324(
      GovV3Helpers.deployDeterministic(
        type(AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324).creationCode,
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
      'AaveV3Ethereum_GHOStewardsBorrowRateUpdate_20240324',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
