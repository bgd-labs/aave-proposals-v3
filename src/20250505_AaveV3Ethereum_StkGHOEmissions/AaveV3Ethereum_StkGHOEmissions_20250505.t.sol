// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

import {AaveV3Ethereum_StkGHOEmissions_20250505} from './AaveV3Ethereum_StkGHOEmissions_20250505.sol';

/**
 * @dev Test for AaveV3Ethereum_StkGHOEmissions_20250505
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250505_AaveV3Ethereum_StkGHOEmissions/AaveV3Ethereum_StkGHOEmissions_20250505.t.sol -vv
 */
contract AaveV3Ethereum_StkGHOEmissions_20250505_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StkGHOEmissions_20250505 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22420134);
    proposal = new AaveV3Ethereum_StkGHOEmissions_20250505();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_StkGHOEmissions_20250505', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBeforestkGHO, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveSafetyModule.STK_GHO
    );

    assertEq(
      emissionPerSecondBeforestkGHO,
      proposal.AAVE_EMISSION_PER_SECOND_STK_GHO(),
      'emissions before not equal stkGHO'
    );

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfterstkGHO, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveSafetyModule.STK_GHO
    );

    assertEq(
      emissionPerSecondAfterstkGHO,
      proposal.AAVE_EMISSION_PER_SECOND_STK_GHO(),
      'emissions after not equal stkGHO'
    );
    assertApproxEqAbs(
      emissionPerSecondAfterstkGHO,
      emissionPerSecondBeforestkGHO,
      1,
      'stkGHO emissions not same as previous'
    );
  }

  function test_checkDistributionEnd() public {
    uint256 endTimestampBefore = IStakeToken(AaveSafetyModule.STK_GHO).distributionEnd();

    assertLt(
      endTimestampBefore,
      block.timestamp + proposal.DISTRIBUTION_DURATION(),
      'New distribution duration is lower than previously configured'
    );

    executePayload(vm, address(proposal));

    uint256 endTimestampAfter = IStakeToken(AaveSafetyModule.STK_GHO).distributionEnd();

    assertEq(
      endTimestampAfter,
      block.timestamp + proposal.DISTRIBUTION_DURATION(),
      'New distribution duration has not been set correctly'
    );
  }

  function test_checkAllowance() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_GHO
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_GHO
    );

    assertGt(allowanceAfter, allowanceBefore);
    // With previous remaining allowance, this can be greater than or equal to
    assertGe(
      allowanceAfter,
      proposal.DISTRIBUTION_DURATION() * proposal.AAVE_EMISSION_PER_SECOND_STK_GHO()
    );
  }

  function test_checkRewards_stkGHO() public {
    address stakedToken = AaveV3EthereumAssets.GHO_UNDERLYING;
    address staker = 0xDD62115f601dAeBCCfDd2aEED834513D8DC2F4E2;
    uint256 rewardsPerDay = 100 ether;

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(stakedToken).approve(AaveSafetyModule.STK_GHO, 1 ether);
    IERC20(stakedToken).balanceOf(staker);
    IStakeToken(AaveSafetyModule.STK_GHO).stake(staker, 1 ether);
    vm.stopPrank();

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_GHO).getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= rewardsPerDay);

    vm.stopPrank();
  }
}
