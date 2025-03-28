// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IRewardsController} from 'aave-v3-origin/contracts/rewards/interfaces/IRewardsController.sol';
import {IERC20AaveLM} from 'aave-v3-origin/contracts/extensions/stata-token/interfaces/IERC20AaveLM.sol';

import {AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318} from './AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318.sol';

/**
 * @dev Test for AaveV3Base_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250318_Multi_AllowBalancerDAOToClaimLiquidityMiningRewards/AaveV3Base_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318.t.sol -vv
 */
contract AaveV3Base_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318_Test is
  ProtocolV3TestBase
{
  address public constant CLAIMER = 0x9ff471F9f98F42E5151C7855fD1b5aa906b1AF7e;
  address public constant BALANCER_VAULT = 0xbA1333333333a1BA1108E8412f11850A5C319bA9;
  AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 27755124);
    proposal = new AaveV3Multi_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318(
      CLAIMER,
      BALANCER_VAULT,
      AaveV3Base.EMISSION_MANAGER
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_AllowBalancerDAOToClaimLiquidityMiningRewards_20250318',
      AaveV3Base.POOL,
      address(proposal)
    );

    assertEq(
      IRewardsController(AaveV3Base.DEFAULT_INCENTIVES_CONTROLLER).getClaimer(
        proposal.BALANCER_VAULT()
      ),
      proposal.CLAIMER()
    );
  }
}
