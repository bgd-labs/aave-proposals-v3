// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617} from './AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617.sol';

/**
 * @dev Test for AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617.t.sol -vv
 */
contract AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617_Test is ProtocolV3TestBase {
  AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617 internal proposal;
  event KeeperCancelled(uint256 indexed id, address indexed upkeep);

  address public constant PROOF_OF_RESERVE_ROBOT_ADDRESS =
    0x7aE2930B50CFEbc99FE6DB16CE5B9C7D8d09332C;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 48662670);
    proposal = new AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_keeperCancelled() public {
    vm.expectEmit();
    emit KeeperCancelled(proposal.OLD_POR_ROBOT_ID(), PROOF_OF_RESERVE_ROBOT_ADDRESS);

    executePayload(vm, address(proposal));
  }
}
