// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xdc005c2385a548143bbeb35b8bb92e5f0ed29829a445f5e986a2b010bc349c6a
 * - Discussion: https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070
 */
contract AaveV3Base_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://basescan.org/address/0xF7212c40810e2192dc5ba45a5E8ad39E3E39Ea4b
  address public constant REWARDS_STEWARD = 0xF7212c40810e2192dc5ba45a5E8ad39E3E39Ea4b;

  function execute() external {
    EmissionManager(AaveV3Base.EMISSION_MANAGER).setClaimer(
      address(AaveV3Base.COLLECTOR),
      REWARDS_STEWARD
    );
  }
}
