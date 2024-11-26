// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_EnableSUSDeUSDTLiquid_20241125} from './AaveV3Ethereum_EnableSUSDeUSDTLiquid_20241125.sol';

/**
 * @dev Test for AaveV3Ethereum_EnableSUSDeUSDTLiquid_20241125
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241125_AaveV3Ethereum_EnableSUSDeUSDTLiquid/AaveV3Ethereum_EnableSUSDeUSDTLiquid_20241125.t.sol -vv
 */
contract AaveV3Ethereum_EnableSUSDeUSDTLiquid_20241125_Test is ProtocolV3TestBase {
  AaveV3Ethereum_EnableSUSDeUSDTLiquid_20241125 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21271611);
    proposal = new AaveV3Ethereum_EnableSUSDeUSDTLiquid_20241125();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_EnableSUSDeUSDTLiquid_20241125',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
