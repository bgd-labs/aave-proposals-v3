// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: PENDING
 * - Discussion: PENDING
 */
contract AaveV3Avalanche_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://snowtrace.io/address/0x4C6Cf8b226500d92FCBC498c3EC4C2e1091dAC08
  address public constant REWARDS_STEWARD = 0x4C6Cf8b226500d92FCBC498c3EC4C2e1091dAC08;

  function execute() external {
    EmissionManager(AaveV3Avalanche.EMISSION_MANAGER).setClaimer(
      address(AaveV3Avalanche.COLLECTOR),
      REWARDS_STEWARD
    );
  }
}
