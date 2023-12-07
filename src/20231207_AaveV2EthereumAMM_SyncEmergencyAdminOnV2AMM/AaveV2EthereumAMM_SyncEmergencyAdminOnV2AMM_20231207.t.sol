// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2EthereumAMM} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207} from './AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207.sol';

/**
 * @dev Test for AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207
 * command: make test-contract filter=AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207
 */
contract AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207_Test is ProtocolV2TestBase {
  AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18735013);
    proposal = new AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2EthereumAMM_SyncEmergencyAdminOnV2AMM_20231207',
      AaveV2EthereumAMM.POOL,
      address(proposal)
    );
  }
}
