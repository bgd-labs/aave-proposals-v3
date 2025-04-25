// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

import {AaveV3Ethereum_LowerStkABPTEmissions_20250423} from './AaveV3Ethereum_LowerStkABPTEmissions_20250423.sol';

/**
 * @dev Test for AaveV3Ethereum_LowerStkABPTEmissions_20250423
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250423_AaveV3Ethereum_LowerStkABPTEmissions/AaveV3Ethereum_LowerStkABPTEmissions_20250423.t.sol -vv
 */
contract AaveV3Ethereum_LowerStkABPTEmissions_20250423_Test is ProtocolV3TestBase {
  AaveV3Ethereum_LowerStkABPTEmissions_20250423 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22331915);
    proposal = new AaveV3Ethereum_LowerStkABPTEmissions_20250423();
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBeforeStkBPT, , ) = IStakeToken(
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    ).assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(
      emissionPerSecondBeforeStkBPT,
      proposal.CURRENT_AAVE_EMISSION_PER_SECOND_STK_BPT(),
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
  }

  function test_checkDistributionEnd() public {
    uint256 endTimestampBefore = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertGt(
      endTimestampBefore,
      block.timestamp,
      'New distribution duration is lower than current timestamp'
    );

    executePayload(vm, address(proposal));

    uint256 endTimestampAfter = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .distributionEnd();

    assertEq(endTimestampBefore, endTimestampAfter, 'New distribution duration differs');
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

    // New allowance is less than before
    assertLt(allowanceAfter, allowanceBefore);
  }

  function test_checkRewards_stkBPT() public {
    address stakedToken = 0x3de27EFa2F1AA663Ae5D458857e731c129069F29;
    address staker = 0xce88686553686DA562CE7Cea497CE749DA109f9F;
    uint256 rewardsPerDay = 240e18;

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
