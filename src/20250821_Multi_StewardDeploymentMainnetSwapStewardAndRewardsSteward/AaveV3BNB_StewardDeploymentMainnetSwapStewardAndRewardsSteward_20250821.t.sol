// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {EmissionManager} from 'aave-v3-origin/contracts/rewards/EmissionManager.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IRewardsController} from 'aave-v3-origin/contracts/rewards/interfaces/IRewardsController.sol';

import {AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821} from './AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.sol';

interface IRewardsSteward {
  function claimAllRewards(address[] calldata assets) external;
}

/**
 * @dev Test for AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250821_Multi_StewardDeploymentMainnetSwapStewardAndRewardsSteward/AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821.t.sol -vv
 */
contract AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821_Test is
  ProtocolV3TestBase
{
  AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821 internal proposal;
  address[] assets = new address[](1);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 60816310);
    proposal = new AaveV3BNB_StewardDeploymentMainnetSwapStewardAndRewardsSteward_20250821();
    assets[0] = AaveV3BNBAssets.ETH_A_TOKEN;
  }

  function test_claimerIsSetCorrectly() public {
    assertEq(
      IRewardsController(AaveV3BNB.DEFAULT_INCENTIVES_CONTROLLER).getClaimer(
        address(AaveV3BNB.COLLECTOR)
      ),
      address(0)
    );

    executePayload(vm, address(proposal));

    assertEq(
      IRewardsController(AaveV3BNB.DEFAULT_INCENTIVES_CONTROLLER).getClaimer(
        address(AaveV3BNB.COLLECTOR)
      ),
      proposal.REWARDS_STEWARD()
    );
  }

  function test_canClaimRewards() public {
    address steward = proposal.REWARDS_STEWARD();
    vm.expectRevert('CLAIMER_UNAUTHORIZED');
    IRewardsSteward(steward).claimAllRewards(assets);

    executePayload(vm, address(proposal));

    IRewardsSteward(steward).claimAllRewards(assets);
  }
}
