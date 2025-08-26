// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: PENDING
 * - Discussion: PENDING
 */
contract AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://basescan.com/address/0x6046A62a80a2c19A0De91063602ce90533c62ae1
  address public constant REWARDS_STEWARD = 0x6046A62a80a2c19A0De91063602ce90533c62ae1;

  function execute() external {
    EmissionManager(AaveV3BNB.EMISSION_MANAGER).setClaimer(
      address(AaveV3BNB.COLLECTOR),
      REWARDS_STEWARD
    );
  }
}
