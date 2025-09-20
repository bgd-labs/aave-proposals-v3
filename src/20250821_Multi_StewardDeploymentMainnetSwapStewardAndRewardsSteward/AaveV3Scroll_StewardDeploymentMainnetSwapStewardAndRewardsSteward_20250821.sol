// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xdc005c2385a548143bbeb35b8bb92e5f0ed29829a445f5e986a2b010bc349c6a
 * - Discussion: https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070
 */
contract AaveV3Scroll_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://scrollscan.com/address/0xc50C0D9C4E5df6f2F244a72FD4DA562877CD16EE
  address public constant REWARDS_STEWARD = 0xc50C0D9C4E5df6f2F244a72FD4DA562877CD16EE;

  function execute() external {
    EmissionManager(AaveV3Scroll.EMISSION_MANAGER).setClaimer(
      address(AaveV3Scroll.COLLECTOR),
      REWARDS_STEWARD
    );
  }
}
