// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {IStakeToken} from './IStakeToken.sol';
import {AaveV3Ethereum_AmendSafetyModuleEmissions_20240229} from './AaveV3Ethereum_AmendSafetyModuleEmissions_20240229.sol';

/**
 * @dev Test for AaveV3Ethereum_AmendSafetyModuleEmissions_20240229
 * command: make test-contract filter=AaveV3Ethereum_AmendSafetyModuleEmissions_20240229
 */
contract AaveV3Ethereum_AmendSafetyModuleEmissions_20240229_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AmendSafetyModuleEmissions_20240229 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19334472);
    proposal = new AaveV3Ethereum_AmendSafetyModuleEmissions_20240229();
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBeforeStkGHO, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveSafetyModule.STK_GHO
    );

    (uint128 emissionPerSecondBeforeStkAAVE, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    (uint128 emissionPerSecondBeforeStkABPT, , ) = IStakeToken(
      AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
    ).assets(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2);

    assertEq(
      emissionPerSecondBeforeStkGHO,
      proposal.AAVE_EMISSION_PER_SECOND_STK_GHO() / 2,
      'emissions before not equal stkGHO'
    );
    assertEq(
      emissionPerSecondBeforeStkAAVE,
      uint128(385e18) / 1 days,
      'emissions before not equal stkAAVE'
    );
    assertEq(
      emissionPerSecondBeforeStkABPT,
      uint128(385e18) / 1 days,
      'emissions before not equal stkABPT'
    );

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfterStkGHO, uint128 lastUpdateTimestampAfterStkGHO, ) = IStakeToken(
      AaveSafetyModule.STK_GHO
    ).assets(AaveSafetyModule.STK_GHO);

    assertEq(
      emissionPerSecondAfterStkGHO,
      proposal.AAVE_EMISSION_PER_SECOND_STK_GHO(),
      'emissions after not equal stkGHO'
    );
    assertEq(lastUpdateTimestampAfterStkGHO, block.timestamp);
    assertApproxEqAbs(
      emissionPerSecondAfterStkGHO,
      emissionPerSecondBeforeStkGHO * 2,
      1,
      'stkGHO emissions not double previous'
    );

    (
      uint128 emissionPerSecondAfterStkAAVE,
      uint128 lastUpdateTimestampAfterStkAAVE,

    ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(AaveSafetyModule.STK_AAVE);

    assertEq(
      emissionPerSecondAfterStkAAVE,
      proposal.AAVE_EMISSION_PER_SECOND_STK_AAVE(),
      'emissions after not equal stkAAVE'
    );
    assertEq(lastUpdateTimestampAfterStkAAVE, block.timestamp);
    assertLt(emissionPerSecondAfterStkAAVE, emissionPerSecondBeforeStkAAVE);

    (
      uint128 emissionPerSecondAfterStkABPT,
      uint128 lastUpdateTimestampAfterStkABPT,

    ) = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).assets(
        AaveSafetyModule.STK_AAVE_WSTETH_BPTV2
      );

    assertEq(
      emissionPerSecondAfterStkABPT,
      proposal.AAVE_EMISSION_PER_SECOND_STK_ABPT(),
      'emissions after not equal stkABPT'
    );
    assertEq(lastUpdateTimestampAfterStkABPT, block.timestamp);
    assertLt(emissionPerSecondAfterStkABPT, emissionPerSecondBeforeStkABPT);
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
    address staker = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;

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

  function test_checkRewards_stkAAVE() public {
    address staker = 0xCaefcFCb4960c5473024B74da2dB4De8D854e804;

    uint256 rewardsPerDay = 350e18;

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).approve(AaveSafetyModule.STK_AAVE, 1e18);

    IStakeToken(AaveSafetyModule.STK_AAVE).stake(staker, 1e18);

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= rewardsPerDay);

    vm.stopPrank();
  }

  function test_checkRewards_stkABPT() public {
    address abpt = 0x3de27EFa2F1AA663Ae5D458857e731c129069F29;
    address staker = 0xce88686553686DA562CE7Cea497CE749DA109f9F;

    uint256 rewardsPerDay = 350e18;

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(abpt).approve(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2, 1e18);

    IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2).stake(staker, 1e18);

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE_WSTETH_BPTV2)
      .getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= rewardsPerDay);

    vm.stopPrank();
  }
}
