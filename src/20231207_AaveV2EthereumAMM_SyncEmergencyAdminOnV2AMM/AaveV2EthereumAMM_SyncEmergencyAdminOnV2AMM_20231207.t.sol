// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {Errors} from 'aave-address-book/AaveV2.sol';
import {AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207} from './AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207.sol';

/**
 * @dev Test for AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207
 * command: make test-contract filter=AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207
 */
contract AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207_Test is Test {
  event Paused();

  AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18735013);
    proposal = new AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    // check that old guardian could not pause
    vm.startPrank(AaveV2EthereumAMM.EMERGENCY_ADMIN);

    vm.expectRevert(bytes(Errors.LPC_CALLER_NOT_EMERGENCY_ADMIN));
    AaveV2EthereumAMM.POOL_CONFIGURATOR.setPoolPause(true);

    vm.stopPrank();

    // check that new guardian can pause
    vm.startPrank(MiscEthereum.PROTOCOL_GUARDIAN);

    vm.expectEmit();
    emit Paused();

    AaveV2EthereumAMM.POOL_CONFIGURATOR.setPoolPause(true);

    vm.stopPrank();
  }
}
