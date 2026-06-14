// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522} from './AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522.sol';

/**
 * @dev Test for AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260522_AaveV3Ethereum_StkAAVEEmissionsUpdate/AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522.t.sol -vv
 */
contract AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25152670);
    proposal = new AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_StkAAVEEmissionsUpdate_20260522',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
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

  function test_stkAAVE_rewardsAccrue() public {
    address staker = makeAddr('staker');
    deal(AaveV3EthereumAssets.AAVE_UNDERLYING, staker, 1 ether);

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecond, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );
    uint256 dailyEmissions = uint256(emissionPerSecond) * 1 days;

    vm.startPrank(staker);
    IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).approve(AaveSafetyModule.STK_AAVE, 1 ether);
    IStakeToken(AaveSafetyModule.STK_AAVE).stake(staker, 1 ether);
    vm.stopPrank();

    skip(1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(staker);

    // 0 < rewardsBalance <= dailyEmissions
    assertGt(rewardsBalance, 0, 'stkAAVE rewards should be greater than 0');
    assertLe(rewardsBalance, dailyEmissions, 'stkAAVE rewards should not exceed daily emissions');
  }

  function test_stkAAVE_rewardsAccrueBeforeAndAfterUpdate() public {
    address staker = makeAddr('staker');
    deal(AaveV3EthereumAssets.AAVE_UNDERLYING, staker, 1 ether);

    vm.startPrank(staker);
    IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).approve(AaveSafetyModule.STK_AAVE, 1 ether);
    IStakeToken(AaveSafetyModule.STK_AAVE).stake(staker, 1 ether);
    vm.stopPrank();

    // Accrual over 1 day BEFORE the update.
    uint256 rewardsStart = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(staker);
    skip(1 days);
    uint256 accruedBefore = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(staker) -
      rewardsStart;

    executePayload(vm, address(proposal));

    // Accrual over 1 day AFTER the update.
    uint256 rewardsAfterUpdate = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(
      staker
    );
    skip(1 days);
    uint256 accruedAfter = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(staker) -
      rewardsAfterUpdate;

    assertGt(accruedBefore, 0, 'stkAAVE rewards should accrue before update');
    assertGt(accruedAfter, 0, 'stkAAVE rewards should accrue after update');
    assertLt(accruedAfter, accruedBefore, 'stkAAVE accrued rewards should be lower after update');
  }
}
