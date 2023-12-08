// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

/**
 * @dev Test for AaveV2Ethereum_MultichainStableDebtTokenUpgrades_20231107
 * command: make test-contract filter=AaveV2Ethereum_MultichainStableDebtTokenUpgrades_20231107
 */
contract AaveV2Ethereum_MultichainStableDebtTokenUpgrades_20231107_Test is ProtocolV2TestBase {
  address internal proposal = address(0x3D33aBB521Ef3AA17b76c3FF9aDbEBA3903C5114);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18520277);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _unPause();
    defaultTest(
      'AaveV2Ethereum_MultichainStableDebtTokenUpgrades_20231107',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
    defaultTest(
      'AaveV2Ethereum_MultichainStableDebtTokenUpgradesSentinel_20231107',
      AaveV2Ethereum.POOL,
      address(0x6C43cd7DC9f8d6F9892b4757941F910E3c7f2244)
    );
  }

  function _unPause() internal {
    hoax(0xCA76Ebd8617a03126B6FB84F9b1c1A0fB71C2633);
    AaveV2Ethereum.POOL_CONFIGURATOR.setPoolPause(false);
  }
}
