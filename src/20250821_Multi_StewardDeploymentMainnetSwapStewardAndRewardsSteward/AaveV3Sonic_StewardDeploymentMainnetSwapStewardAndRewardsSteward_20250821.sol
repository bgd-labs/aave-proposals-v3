// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xdc005c2385a548143bbeb35b8bb92e5f0ed29829a445f5e986a2b010bc349c6a
 * - Discussion: https://governance.aave.com/t/arfc-steward-deployment-mainnetswapsteward-and-rewardssteward/23070
 */
contract AaveV3Sonic_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://sonicscan.org/address/0x9eFf17b168867Dc2bCD87D2Ab44e4857902dbC29
  address public constant REWARDS_STEWARD = 0x9eFf17b168867Dc2bCD87D2Ab44e4857902dbC29;

  function execute() external {
    EmissionManager(AaveV3Sonic.EMISSION_MANAGER).setClaimer(
      address(AaveV3Sonic.COLLECTOR),
      REWARDS_STEWARD
    );
  }
}
