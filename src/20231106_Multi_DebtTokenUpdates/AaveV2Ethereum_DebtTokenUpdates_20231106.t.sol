// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

/**
 * @dev Test for AaveV2Ethereum_DebtTokenUpdates_20231106
 * command: make test-contract filter=AaveV2Ethereum_DebtTokenUpdates_20231106
 */
contract AaveV2Ethereum_DebtTokenUpdates_20231106_Test is ProtocolV2TestBase {
  address internal proposal = address(0x37DF9bd44728e513472D5d44793118cBaE975E12);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18515006);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _unPause();
    GovV3Helpers.executePayload(vm, 4);
    defaultTest('AaveV2Ethereum_DebtTokenUpdates_20231106', AaveV2Ethereum.POOL, address(proposal));
  }

  function _unPause() internal {
    hoax(0xCA76Ebd8617a03126B6FB84F9b1c1A0fB71C2633);
    AaveV2Ethereum.POOL_CONFIGURATOR.setPoolPause(false);
  }
}
