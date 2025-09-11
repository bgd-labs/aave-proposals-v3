// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: PENDING
 * - Discussion: https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070
 */
contract AaveV3Optimism_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://optimistic.etherscan.io/address/0xfD2aaE32247E5015AcB04Aa8220616D6647979aC
  address public constant REWARDS_STEWARD = 0xfD2aaE32247E5015AcB04Aa8220616D6647979aC;

  function execute() external {
    EmissionManager(AaveV3Optimism.EMISSION_MANAGER).setClaimer(
      address(AaveV3Optimism.COLLECTOR),
      REWARDS_STEWARD
    );
  }
}
