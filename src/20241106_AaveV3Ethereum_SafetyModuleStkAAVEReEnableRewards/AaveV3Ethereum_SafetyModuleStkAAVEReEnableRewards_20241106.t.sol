// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106} from './AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106.sol';

/**
 * @dev Test for AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241106_AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards/AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106.t.sol -vv
 */
contract AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21128772);
    proposal = new AaveV3Ethereum_SafetyModuleStkAAVEReEnableRewards_20241106();
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBeforeStkAAVE, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    assertEq(
      emissionPerSecondBeforeStkAAVE,
      proposal.AAVE_EMISSION_PER_SECOND_STK_AAVE(),
      'emissions before not equal stkAAVE'
    );

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfterStkAAVE, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    assertEq(
      emissionPerSecondAfterStkAAVE,
      proposal.AAVE_EMISSION_PER_SECOND_STK_AAVE(),
      'emissions after not equal stkAAVE'
    );
    assertApproxEqAbs(
      emissionPerSecondAfterStkAAVE,
      emissionPerSecondBeforeStkAAVE,
      1,
      'stkAAVE emissions not same as previous'
    );
  }

  function test_checkRewards_stkAAVE() public {
    address staker = 0x5a801a9418D036fD453078c3ADCB761fdc5Ae695;
    uint256 rewardsPerDay = proposal.AAVE_EMISSION_PER_SECOND_STK_AAVE();

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).approve(AaveSafetyModule.STK_AAVE, 1e18);

    IStakeToken(AaveSafetyModule.STK_AAVE).stake(staker, 1e18);

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(staker);

    assertTrue(rewardsBalance > 0 && rewardsBalance <= rewardsPerDay);

    vm.stopPrank();
  }
}
