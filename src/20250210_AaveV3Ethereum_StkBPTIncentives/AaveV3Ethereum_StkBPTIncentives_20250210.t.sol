// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

import {AaveV3Ethereum_StkBPTIncentives_20250210} from './AaveV3Ethereum_StkBPTIncentives_20250210.sol';

/**
 * @dev Test for AaveV3Ethereum_StkBPTIncentives_20250210
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250210_AaveV3Ethereum_StkBPTIncentives/AaveV3Ethereum_StkBPTIncentives_20250210.t.sol -vv
 */
contract AaveV3Ethereum_StkBPTIncentives_20250210_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StkBPTIncentives_20250210 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21818007);
    proposal = new AaveV3Ethereum_StkBPTIncentives_20250210();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_StkBPTIncentives_20250210', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBeforeStkBPT, , ) = IStakeToken(
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    ).assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(
      emissionPerSecondBeforeStkBPT,
      proposal.AAVE_EMISSION_PER_SECOND_STK_BPT(),
      'emissions before not equal stkBPT'
    );

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfterStkBPT, , ) = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(
      emissionPerSecondAfterStkBPT,
      proposal.AAVE_EMISSION_PER_SECOND_STK_BPT(),
      'emissions after not equal stkBPT'
    );
    assertApproxEqAbs(
      emissionPerSecondAfterStkBPT,
      emissionPerSecondBeforeStkBPT,
      1,
      'stkBPT emissions not same as previous'
    );
  }

  function test_checkDistributionEnd() public {
    uint256 endTimestampBefore = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertLt(
      endTimestampBefore,
      block.timestamp + proposal.DISTRIBUTION_DURATION(),
      'New distribution duration is lower than previously configured'
    );

    executePayload(vm, address(proposal));

    uint256 endTimestampAfter = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertEq(
      endTimestampAfter,
      block.timestamp + proposal.DISTRIBUTION_DURATION(),
      'New distribution duration has not been set correctly'
    );
  }

  function test_checkAllowance() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    );

    assertGt(allowanceAfter, allowanceBefore);
    // With previous remaining allowance, this can be greater than or equal to
    assertGe(
      allowanceAfter,
      proposal.DISTRIBUTION_DURATION() * proposal.AAVE_EMISSION_PER_SECOND_STK_BPT()
    );
  }

  function test_checkRewards_stkBPT() public {
    address stakedToken = 0x3de27EFa2F1AA663Ae5D458857e731c129069F29;
    address staker = 0xC1233286aCdb6bed1A1C902d3ed01960Aaf34e0D;
    uint256 rewardsPerDay = 360e18;

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(stakedToken).approve(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2, 1 ether);
    IERC20(stakedToken).balanceOf(staker);
    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).stake(staker, 1 ether);
    vm.stopPrank();

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= rewardsPerDay);

    vm.stopPrank();
  }
}
