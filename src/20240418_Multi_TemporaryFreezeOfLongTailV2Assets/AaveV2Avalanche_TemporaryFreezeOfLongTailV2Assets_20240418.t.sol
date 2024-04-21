// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418} from './AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418.sol';

/**
 * @dev Test for AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418
 * command: make test-contract filter=AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418
 */
contract AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418_Test is ProtocolV2TestBase {
  AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 44360962);
    proposal = new AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (ReserveConfig[] memory allConfigsBefore, ReserveConfig[] memory allConfigsAfter) = defaultTest(
      'AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418',
      AaveV2Avalanche.POOL,
      address(proposal)
    );

    address[] memory assetsChanged = new address[](1);
    assetsChanged[0] = AaveV2AvalancheAssets.AAVEe_UNDERLYING;

    _noReservesConfigsChangesApartFrom(allConfigsBefore, allConfigsAfter, assetsChanged);

    ReserveConfig memory configAfter = _findReserveConfig(allConfigsAfter, assetsChanged[0]);

    assertEq(configAfter.isFrozen, true);
  }
}
