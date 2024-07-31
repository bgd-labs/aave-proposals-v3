// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716} from './AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716.sol';

/**
 * @dev Test for AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240716_Multi_ReduceReserveFactorOnWstETH/AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716.t.sol -vv
 */
contract AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20320832);
    proposal = new AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ReduceReserveFactorOnWstETH_20240716',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
