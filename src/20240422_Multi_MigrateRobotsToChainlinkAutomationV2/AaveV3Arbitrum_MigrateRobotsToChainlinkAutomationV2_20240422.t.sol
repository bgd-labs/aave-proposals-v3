// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422} from './AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422.sol';
import {ArbSys} from './interfaces/ArbSys.sol';

/**
 * @dev Test for AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422
 * command: make test-contract filter=AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422
 */
contract AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422 internal proposal;
  address public constant ARB_SYS = 0x0000000000000000000000000000000000000064;

  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);
  event KeeperCancelled(uint256 indexed id, address indexed upkeep);

  function setUp() public {
    uint256 blockNumber = 213434099;
    vm.createSelectFork(vm.rpcUrl('arbitrum'), blockNumber);
    proposal = new AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422();

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
      'AaveV3Arbitrum_MigrateRobotsToChainlinkAutomationV2_20240422',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_oldKeeperCancelledAndNewRegistered() public {
    // validate robots cancelled
    vm.expectEmit();
    emit KeeperCancelled(
      proposal.OLD_EXECUTION_CHAIN_ROBOT_ID(),
      proposal.EXECUTION_CHAIN_ROBOT_ADDRESS()
    );

    // validate robots registered
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.EXECUTION_CHAIN_ROBOT_ADDRESS(),
      uint96(proposal.EXECUTION_CHAIN_ROBOT_LINK_AMOUNT())
    );
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.STATIC_A_TOKEN_ROBOT_ADDRESS(),
      uint96(proposal.STATIC_A_TOKEN_ROBOT_LINK_AMOUNT())
    );

    executePayload(vm, address(proposal));
  }
}
