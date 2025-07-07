// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {ArbSys} from '../interfaces/ArbSys.sol';
import {IAaveCLRobotOperator, AaveV3Arbitrum_AaveRobotMaintenance_20250330} from './AaveV3Arbitrum_AaveRobotMaintenance_20250330.sol';

/**
 * @dev Test for AaveV3Arbitrum_AaveRobotMaintenance_20250330
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250330_Multi_AaveRobotMaintenance/AaveV3Arbitrum_AaveRobotMaintenance_20250330.t.sol -vv
 */
contract AaveV3Arbitrum_AaveRobotMaintenance_20250330_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_AaveRobotMaintenance_20250330 internal proposal;

  address public constant ARB_SYS = 0x0000000000000000000000000000000000000064;
  address public constant OLD_STATA_ROBOT_ADDRESS = 0x0451f67bA61966C346daBAbB50a30Cc6A9A67C69;

  function setUp() public {
    uint256 blockNumber = 354070703;
    vm.createSelectFork(vm.rpcUrl('arbitrum'), blockNumber);
    proposal = new AaveV3Arbitrum_AaveRobotMaintenance_20250330();

    // https://github.com/foundry-rs/foundry/issues/5085
    vm.mockCall(
      ARB_SYS,
      abi.encodeWithSelector(ArbSys.arbBlockNumber.selector),
      abi.encode(blockNumber)
    );
    vm.mockCall(
      ARB_SYS,
      abi.encodeWithSelector(ArbSys.arbBlockHash.selector, blockNumber - 1),
      abi.encode(0xbe6f5dfa9ce3324bd677f5195ecd8d1a258cbf3800f24621d0e0d2724224704f)
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_AaveRobotMaintenance_20250330',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_robotsRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposal.STATA_ROBOT(),
      proposal.STATA_ROBOT_LINK_AMOUNT()
    );

    executePayload(vm, address(proposal));
  }

  function test_oldRobotsCancelled() public {
    vm.expectEmit();
    emit IAaveCLRobotOperator.KeeperCancelled(
      proposal.OLD_STATA_ROBOT_ID(),
      OLD_STATA_ROBOT_ADDRESS
    );

    executePayload(vm, address(proposal));
  }
}
