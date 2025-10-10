// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AllowPyUSDAsCollateral_20251009} from './AaveV3Ethereum_AllowPyUSDAsCollateral_20251009.sol';

/**
 * @dev Test for AaveV3Ethereum_AllowPyUSDAsCollateral_20251009
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251009_AaveV3Ethereum_AllowPyUSDAsCollateral/AaveV3Ethereum_AllowPyUSDAsCollateral_20251009.t.sol -vv
 */
contract AaveV3Ethereum_AllowPyUSDAsCollateral_20251009_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AllowPyUSDAsCollateral_20251009 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23541379);
    proposal = new AaveV3Ethereum_AllowPyUSDAsCollateral_20251009();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AllowPyUSDAsCollateral_20251009',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
