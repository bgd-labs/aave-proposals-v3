// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901} from './AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901.sol';

/**
 * @dev Test for AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260901_AaveV3Ethereum_SafetyModuleAllowanceUpdate/AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901.t.sol -vv
 */
contract AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25880238);
    proposal = new AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SafetyModuleAllowanceUpdate_20260901',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_stkAaveAllowanceUpdated() public {
    uint256 emissionPerDay = 150 ether;
    (uint128 emissionPerSecond, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );
    assertEq(
      uint256(emissionPerSecond),
      emissionPerDay / 1 days,
      'stkAAVE emission should be 150 AAVE per day per the forum post'
    );

    uint256 allowanceBefore = _allowanceOf(AaveSafetyModule.STK_AAVE);

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 expected = allowanceBefore +
      50_500 ether +
      uint256(emissionPerSecond) *
      (block.timestamp - 1_787_791_523 + 90 days);
    assertEq(
      _allowanceOf(AaveSafetyModule.STK_AAVE),
      expected,
      'stkAAVE allowance should cover the backlog plus 90 days of emissions'
    );
  }

  function test_sunsetModuleAllowancesUpdated() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      _allowanceOf(AaveSafetyModule.STK_ABPT),
      1_250 ether,
      'stkABPT v1 allowance should be 1250 AAVE'
    );
    assertEq(
      _allowanceOf(AaveSafetyModule.STK_GHO),
      1_200 ether,
      'stkGHO allowance should be 1200 AAVE'
    );
    assertEq(
      _allowanceOf(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2),
      2_500 ether,
      'stkAAVEwstETHBPTv2 allowance should be 2500 AAVE'
    );
  }

  function test_stkAaveClaimSucceedsAfterUpdate() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    address staker = makeAddr('staker');
    uint256 stakeAmount = 1_000 ether;
    deal(AaveV3EthereumAssets.AAVE_UNDERLYING, staker, stakeAmount);

    vm.startPrank(staker);
    IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).approve(AaveSafetyModule.STK_AAVE, stakeAmount);
    IStakeToken(AaveSafetyModule.STK_AAVE).stake(staker, stakeAmount);
    vm.warp(block.timestamp + 30 days);

    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(staker);
    IStakeToken(AaveSafetyModule.STK_AAVE).claimRewards(staker, type(uint256).max);
    assertGt(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(staker),
      balanceBefore,
      'staker should be able to claim rewards after the allowance top-up'
    );
    vm.stopPrank();
  }

  function _allowanceOf(address module) internal view returns (uint256) {
    return
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
        MiscEthereum.ECOSYSTEM_RESERVE,
        module
      );
  }
}
