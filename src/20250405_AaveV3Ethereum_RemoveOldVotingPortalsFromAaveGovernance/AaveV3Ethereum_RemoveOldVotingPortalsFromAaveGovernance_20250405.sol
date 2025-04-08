// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

/**
 * @title Removal of legacy VotingPortals from Governance v3
 * @author BGD Labs @bgdlabs
 * - Discussion: TODO
 */
contract AaveV3Ethereum_RemoveOldVotingPortalsFromAaveGovernance_20250405 is
  IProposalGenericExecutor
{
  address public constant VOTING_PORTAL_ETH_ETH = 0xf23f7De3AC42F22eBDA17e64DC4f51FB66b8E21f;
  address public constant VOTING_PORTAL_ETH_AVAX = 0x33aCEf7365809218485873B7d0d67FeE411B5D79;
  address public constant VOTING_PORTAL_ETH_POL = 0x9b24C168d6A76b5459B1d47071a54962a4df36c3;

  function execute() external {
    address[] memory votingPortalsToRemove = new address[](3);
    votingPortalsToRemove[0] = VOTING_PORTAL_ETH_ETH;
    votingPortalsToRemove[1] = VOTING_PORTAL_ETH_AVAX;
    votingPortalsToRemove[2] = VOTING_PORTAL_ETH_POL;

    GovernanceV3Ethereum.GOVERNANCE.removeVotingPortals(votingPortalsToRemove);
  }
}
