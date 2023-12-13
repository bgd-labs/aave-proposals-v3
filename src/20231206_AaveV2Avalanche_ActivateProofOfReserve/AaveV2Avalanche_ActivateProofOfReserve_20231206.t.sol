// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

/**
 * @dev Test for AaveV2Avalanche_ActivateProofOfReserve_20231206
 * command: make test-contract filter=AaveV2Avalanche_ActivateProofOfReserve_20231206
 */
contract AaveV2Avalanche_ActivateProofOfReserve_20231206_Test is ProtocolV2TestBase {
  address constant payload = 0xE3Ce388aaA268781B34A6ad5b87d81e81E52f3f4;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 38700698);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV2Avalanche_ActivateProofOfReserve_20231206', AaveV2Avalanche.POOL, payload);
  }
}
