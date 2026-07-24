// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Ethereum_IncreaseCaps_20260723_Test} from './AaveV4Ethereum_IncreaseCaps_20260723.t.sol';

/**
 * @dev Fork test - forks from a block where the payload has already been executed.
 * Verifies post-execution state: caps and e2e flows.
 * Skipped when RPC_TENDERLY_VTESTNET is not set.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260723_Multi_AaveV4CapsIncreaseRound11/AaveV4Ethereum_IncreaseCaps_20260723_Fork.t.sol -vv
 */
contract AaveV4Ethereum_IncreaseCaps_20260723_ForkTest is
  AaveV4Ethereum_IncreaseCaps_20260723_Test
{
  function setUp() public override {
    string memory rpcUrl = vm.envOr('RPC_TENDERLY_VTESTNET', string(''));
    vm.skip(bytes(rpcUrl).length == 0);
    vm.createSelectFork(rpcUrl);
  }

  /// @dev Skip, no diff report for fork tests (no pre-execution state).
  function test_executeWithRecording() public override {}

  /// @dev Skip, no pre-execution state.
  function test_caps_coreHub_before() public override {}

  /// @dev Skip, no pre-execution state.
  function test_caps_primeHub_before() public override {}

  /// @dev No-op, payload already executed on the fork.
  function _executePayload() internal override {}
}
