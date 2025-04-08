// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405} from './AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

/**
 * @dev Test for AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250405_AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance/AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405.t.sol -vv
 */
contract AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22201396);
    proposal = new AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_removeVotingPortals() public {
    address votingPortal_eth_eth = proposal.VOTING_PORTAL_ETH_ETH();
    address votingPortal_eth_avax = proposal.VOTING_PORTAL_ETH_AVAX();
    address votingPortal_eth_pol = proposal.VOTING_PORTAL_ETH_POL();

    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_eth), true);
    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_avax), true);
    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_pol), true);

    assertEq(
      GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(
        GovernanceV3Ethereum.VOTING_PORTAL_ETH_ETH
      ),
      true
    );
    assertEq(
      GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(
        GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX
      ),
      true
    );
    assertEq(
      GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(
        GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL
      ),
      true
    );

    assertEq(GovernanceV3Ethereum.GOVERNANCE.getVotingPortalsCount(), 6);

    // execute approval
    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_eth), false);
    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_avax), false);
    assertEq(GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(votingPortal_eth_pol), false);

    assertEq(
      GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(
        GovernanceV3Ethereum.VOTING_PORTAL_ETH_ETH
      ),
      true
    );
    assertEq(
      GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(
        GovernanceV3Ethereum.VOTING_PORTAL_ETH_AVAX
      ),
      true
    );
    assertEq(
      GovernanceV3Ethereum.GOVERNANCE.isVotingPortalApproved(
        GovernanceV3Ethereum.VOTING_PORTAL_ETH_POL
      ),
      true
    );

    assertEq(GovernanceV3Ethereum.GOVERNANCE.getVotingPortalsCount(), 3);
  }
}
