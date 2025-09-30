// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xdc005c2385a548143bbeb35b8bb92e5f0ed29829a445f5e986a2b010bc349c6a
 * - Discussion: https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070
 */
contract AaveV3Arbitrum_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://arbiscan.io/address/0x659966ace41944f6e321ca7fe76de4775779d11c
  address public constant REWARDS_STEWARD = 0x659966aCE41944f6E321cA7FE76de4775779d11C;

  function execute() external {
    EmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).setClaimer(
      address(AaveV3Arbitrum.COLLECTOR),
      REWARDS_STEWARD
    );
  }
}
