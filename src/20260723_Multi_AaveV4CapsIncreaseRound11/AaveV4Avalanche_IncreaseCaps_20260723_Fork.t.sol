// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Avalanche_IncreaseCaps_20260723_Test} from './AaveV4Avalanche_IncreaseCaps_20260723.t.sol';

/**
 * @dev Fork test - forks from a block where the payload has already been executed.
 * Verifies post-execution state and caps.
 * Skipped when RPC_TENDERLY_VTESTNET is not set.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260723_Multi_AaveV4CapsIncreaseRound11/AaveV4Avalanche_IncreaseCaps_20260723_Fork.t.sol -vv
 */
contract AaveV4Avalanche_IncreaseCaps_20260723_ForkTest is
  AaveV4Avalanche_IncreaseCaps_20260723_Test
{
  function setUp() public override {
    string memory rpcUrl = vm.envOr('RPC_TENDERLY_VTESTNET', string(''));
    vm.skip(bytes(rpcUrl).length == 0);
    vm.createSelectFork(rpcUrl);
  }

  function test_executeWithRecording() public override {}

  function test_caps_before() public view override {}

  function _executePayload() internal override {}
}
