// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Steward Deployment: MainnetSwapSteward and RewardsSteward
 * @author @TokenLogic
 * - Snapshot: PENDING
 * - Discussion: PENDING
 */
contract AaveV3Gnosis_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 is
  IProposalGenericExecutor
{
  // https://gnosisscan.io/address/0xE513b6304712D1055C88f72f1952FAe49c09f4ce
  address public constant REWARDS_STEWARD = 0xE513b6304712D1055C88f72f1952FAe49c09f4ce;

  function execute() external {
    EmissionManager(AaveV3Gnosis.EMISSION_MANAGER).setClaimer(
      address(AaveV3Gnosis.COLLECTOR),
      REWARDS_STEWARD
    );
  }
}
