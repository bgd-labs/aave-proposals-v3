// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_ReserveFactorUpdatesMidJuly_20240711} from './AaveV2Ethereum_ReserveFactorUpdatesMidJuly_20240711.sol';

/**
 * @dev Test for AaveV2Ethereum_ReserveFactorUpdatesMidJuly_20240711
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240711_Multi_ReserveFactorUpdatesMidJuly/AaveV2Ethereum_ReserveFactorUpdatesMidJuly_20240711.t.sol -vv
 */
contract AaveV2Ethereum_ReserveFactorUpdatesMidJuly_20240711_Test is ProtocolV2TestBase {
  AaveV2Ethereum_ReserveFactorUpdatesMidJuly_20240711 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20279308);
    proposal = new AaveV2Ethereum_ReserveFactorUpdatesMidJuly_20240711();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_ReserveFactorUpdatesMidJuly_20240711',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }
}
