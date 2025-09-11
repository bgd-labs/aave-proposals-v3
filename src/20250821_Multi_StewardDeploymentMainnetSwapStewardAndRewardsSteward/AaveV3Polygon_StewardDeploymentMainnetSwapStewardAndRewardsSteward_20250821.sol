// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: PENDING
 * - Discussion: https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070
 */
contract AaveV3Polygon_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://polygonscan.com/address/0xF18F15362e5fB4277DCE713F170341942F43aC3E
  address public constant REWARDS_STEWARD = 0xF18F15362e5fB4277DCE713F170341942F43aC3E;

  function execute() external {
    EmissionManager(AaveV3Polygon.EMISSION_MANAGER).setClaimer(
      address(AaveV3Polygon.COLLECTOR),
      REWARDS_STEWARD
    );
  }
}
