// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV4Ethereum_SVRfeeds_20260507} from './AaveV4Ethereum_SVRfeeds_20260507.sol';
import {AaveV4Ethereum_SVRfeeds_20260507_Test} from './AaveV4Ethereum_SVRfeeds_20260507.t.sol';

/**
 * @dev Fork test - forks from a block where the payload has already been executed.
 * Verifies post-execution state: SVR price sources and e2e flows.
 * Skipped when RPC_TENDERLY_VTESTNET is not set.
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_AaveV4Ethereum_SVRfeeds/AaveV4Ethereum_SVRfeeds_20260507_Fork.t.sol -vv
 */
contract AaveV4Ethereum_SVRfeeds_20260507_ForkTest is AaveV4Ethereum_SVRfeeds_20260507_Test {
  // https://etherscan.io/address/0x614edc5e7dce84968fb8011787fc1b4ea762dbc5
  address internal constant DEPLOYED_PAYLOAD = 0x614EDC5E7dce84968FB8011787fc1b4eA762dBC5;

  function setUp() public override {
    string memory rpcUrl = vm.envOr('RPC_TENDERLY_VTESTNET', string(''));
    vm.skip(bytes(rpcUrl).length == 0);
    vm.createSelectFork(rpcUrl);

    payload = AaveV4Ethereum_SVRfeeds_20260507(DEPLOYED_PAYLOAD);
  }

  /// @dev Skip, cannot verify on a post-execution fork.
  function test_priceSources_coreHub_before() public override {
    vm.skip(true, 'cannot verify on a post-execution fork');
  }
  function test_priceSources_primeHub_before() public override {
    vm.skip(true, 'cannot verify on a post-execution fork');
  }
  function test_priceSources_plusHub_before() public override {
    vm.skip(true, 'cannot verify on a post-execution fork');
  }
  function test_reservePrices_approxEq_beforeAfter() public override {
    vm.skip(true, 'cannot verify on a post-execution fork');
  }
  function test_noOldFeedRemainsAfterExec() public override {
    vm.skip(true, 'cannot verify on a post-execution fork');
  }

  /// @dev No-op, payload already executed on the fork.
  function _executePayload() internal override {}
}
