// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224} from './AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224.sol';

/**
 * @dev Test for AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260224_AaveV3Ethereum_ReduceSafetyModuleEmissions/AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224.t.sol -vv
 */
contract AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24670048);
    proposal = new AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ReduceSafetyModuleEmissions_20260224',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_stkBPT_emissionsZero() public {
    (uint128 emissionBefore, , ) = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).assets(
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );
    assertGt(emissionBefore, 0, 'stkBPT emission should be > 0 before');

    executePayload(vm, address(proposal));

    (uint128 emissionAfter, , ) = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).assets(
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );
    assertEq(emissionAfter, 0, 'stkBPT emission should be 0 after');
  }

  function test_stkBPT_cooldownZero() public {
    uint256 cooldownBefore = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getCooldownSeconds();
    assertGt(cooldownBefore, 0, 'stkBPT cooldown should be > 0 before');

    executePayload(vm, address(proposal));

    uint256 cooldownAfter = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getCooldownSeconds();
    assertEq(cooldownAfter, 0, 'stkBPT cooldown should be 0 after');
  }

  function test_stkBPT_slashingDisabled() public {
    uint256 slashBefore = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getMaxSlashablePercentage();
    assertGt(slashBefore, 0, 'stkBPT slashing should be > 0 before');

    executePayload(vm, address(proposal));

    uint256 slashAfter = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getMaxSlashablePercentage();
    assertEq(slashAfter, 0, 'stkBPT slashing should be 0 after');
  }

  function test_stkAAVE_emissionsReduced() public {
    (uint128 emissionBefore, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );
    assertGt(
      emissionBefore,
      proposal.STK_AAVE_EMISSION_PER_SECOND(),
      'stkAAVE emission should be higher before'
    );

    executePayload(vm, address(proposal));

    (uint128 emissionAfter, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );
    assertEq(
      emissionAfter,
      proposal.STK_AAVE_EMISSION_PER_SECOND(),
      'stkAAVE emission mismatch after'
    );
  }

  function test_stkAAVE_cooldownReduced() public {
    uint256 cooldownBefore = IStakeToken(AaveSafetyModule.STK_AAVE).getCooldownSeconds();
    assertGt(
      cooldownBefore,
      proposal.STK_AAVE_COOLDOWN_SECONDS(),
      'stkAAVE cooldown should be higher before'
    );

    executePayload(vm, address(proposal));

    uint256 cooldownAfter = IStakeToken(AaveSafetyModule.STK_AAVE).getCooldownSeconds();
    assertEq(
      cooldownAfter,
      proposal.STK_AAVE_COOLDOWN_SECONDS(),
      'stkAAVE cooldown should be 2 days after'
    );
  }

  function test_stkBPT_rewardsDoNotAccrue() public {
    address staker = makeAddr('bptStaker');
    address bptToken = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).STAKED_TOKEN();
    deal(bptToken, staker, 1 ether);

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(bptToken).approve(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2, 1 ether);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).stake(staker, 1 ether);
    vm.stopPrank();

    vm.warp(block.timestamp + 30 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getTotalRewardsBalance(staker);
    assertEq(rewardsBalance, 0, 'stkBPT rewards should be 0 after emissions disabled');
  }

  function test_stkBPT_fullWithdrawalFlow() public {
    address staker = makeAddr('bptWithdrawer');
    address bptToken = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).STAKED_TOKEN();
    uint256 stakeAmount = 1 ether;
    deal(bptToken, staker, stakeAmount);

    vm.startPrank(staker);
    IERC20(bptToken).approve(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2, stakeAmount);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).stake(staker, stakeAmount);
    vm.stopPrank();

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).cooldown();
    uint256 stkBPTBalance = IERC20(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).balanceOf(staker);
    uint256 bptBalanceBefore = IERC20(bptToken).balanceOf(staker);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).redeem(staker, stkBPTBalance);
    uint256 bptBalanceAfter = IERC20(bptToken).balanceOf(staker);
    assertEq(bptBalanceAfter, bptBalanceBefore + stakeAmount, 'stkBPT full withdrawal failed');
    assertEq(
      IERC20(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).balanceOf(staker),
      0,
      'stkBpt balance is not zero'
    );
    vm.stopPrank();
  }

  function test_stkAAVE_rewardsAccrue() public {
    address staker = makeAddr('staker');
    deal(AaveV3EthereumAssets.AAVE_UNDERLYING, staker, 1 ether);

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).approve(AaveSafetyModule.STK_AAVE, 1 ether);
    IStakeToken(AaveSafetyModule.STK_AAVE).stake(staker, 1 ether);
    vm.stopPrank();

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= 220e18, 'stkAAVE rewards out of range');
  }
}
