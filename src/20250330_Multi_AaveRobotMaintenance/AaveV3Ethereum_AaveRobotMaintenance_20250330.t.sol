// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IERC20, IAaveCLRobotOperator, AaveV3Ethereum_AaveRobotMaintenance_20250330} from './AaveV3Ethereum_AaveRobotMaintenance_20250330.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveRobotMaintenance_20250330
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250330_Multi_AaveRobotMaintenance/AaveV3Ethereum_AaveRobotMaintenance_20250330.t.sol -vv
 */
contract AaveV3Ethereum_AaveRobotMaintenance_20250330_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveRobotMaintenance_20250330 internal proposal;

  address public constant OLD_STATA_ROBOT_ADDRESS = 0xda82148a3944BBe442116f41cDb329b0edF11d41;
  address public constant OLD_VOTING_CHAIN_ROBOT_ADDRESS =
    0x7Ed0A6A294Cf085c90917c0ee1aa34e795932558;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22160683);
    proposal = new AaveV3Ethereum_AaveRobotMaintenance_20250330();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AaveRobotMaintenance_20250330',
      AaveV3Ethereum.POOL,
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

    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposal.VOTING_CHAIN_ROBOT(),
      uint96(proposal.VOTING_CHAIN_ROBOT_LINK_AMOUNT())
    );

    executePayload(vm, address(proposal));
  }

  function test_oldRobotsCancelled() public {
    vm.expectEmit();
    emit IAaveCLRobotOperator.KeeperCancelled(
      proposal.OLD_STATA_ROBOT_ID(),
      OLD_STATA_ROBOT_ADDRESS
    );

    vm.expectEmit();
    emit IAaveCLRobotOperator.KeeperCancelled(
      proposal.OLD_VOTING_CHAIN_ROBOT_ID(),
      OLD_VOTING_CHAIN_ROBOT_ADDRESS
    );

    executePayload(vm, address(proposal));
  }

  function test_newRootsConsumerBalance() public {
    uint256 linkBalanceBefore = IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(
      proposal.OLD_ROOTS_CONSUMER()
    );
    assertEq(linkBalanceBefore, 100 ether);

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(proposal.ROOTS_CONSUMER()),
      linkBalanceBefore
    );
  }

  function test_removeVotingPortals() public {
    address votingPortal_eth_eth = proposal.VOTING_PORTAL_ETH_ETH();
    address votingPortal_eth_avax = proposal.VOTING_PORTAL_ETH_AVAX();
    address votingPortal_eth_pol = proposal.VOTING_PORTAL_ETH_POL();

    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_eth), true);
    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_avax), true);
    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_pol), true);

    // execute approval
    executePayload(vm, address(proposal));

    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_eth), false);
    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_avax), false);
    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_pol), false);
  }
}
