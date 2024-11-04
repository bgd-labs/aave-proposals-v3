// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {AaveV3Ethereum_StkGHOIncentivesQ4_20241029} from './AaveV3Ethereum_StkGHOIncentivesQ4_20241029.sol';

/**
 * @dev Test for AaveV3Ethereum_StkGHOIncentivesQ4_20241029
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241029_AaveV3Ethereum_StkGHOIncentivesQ4/AaveV3Ethereum_StkGHOIncentivesQ4_20241029.t.sol -vv
 **/
contract AaveV3Ethereum_StkGHOIncentivesQ4_20241029_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StkGHOIncentivesQ4_20241029 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21072841);
    proposal = new AaveV3Ethereum_StkGHOIncentivesQ4_20241029();
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBeforeStkGHO, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveSafetyModule.STK_GHO
    );

    assertEq(
      emissionPerSecondBeforeStkGHO,
      proposal.AAVE_EMISSION_PER_SECOND_STK_GHO(),
      'emissions before not equal stkGHO'
    );

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfterStkGHO, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveSafetyModule.STK_GHO
    );

    assertEq(
      emissionPerSecondAfterStkGHO,
      proposal.AAVE_EMISSION_PER_SECOND_STK_GHO(),
      'emissions after not equal stkGHO'
    );
    assertApproxEqAbs(
      emissionPerSecondAfterStkGHO,
      emissionPerSecondBeforeStkGHO,
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
  }

  function test_checkRewards_stkGHO() public {
    address staker = 0x00907f9921424583e7ffBfEdf84F92B7B2Be4977;

    uint256 rewardsPerDay = 100e18;

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).approve(AaveSafetyModule.STK_GHO, 1e18);

    IStakeToken(AaveSafetyModule.STK_GHO).stake(staker, 1e18);

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_GHO).getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= rewardsPerDay);

    vm.stopPrank();
  }
}
