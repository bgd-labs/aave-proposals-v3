// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_StkAAVEEmissions_20250520} from './AaveV3Ethereum_StkAAVEEmissions_20250520.sol';

interface IStakeAave {
  function DISTRIBUTION_END() external view returns (uint256);
}

/**
 * @dev Test for AaveV3Ethereum_StkAAVEEmissions_20250520
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250520_AaveV3Ethereum_StkAAVEEmissions/AaveV3Ethereum_StkAAVEEmissions_20250520.t.sol -vv
 */
contract AaveV3Ethereum_StkAAVEEmissions_20250520_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StkAAVEEmissions_20250520 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22523454);
    proposal = new AaveV3Ethereum_StkAAVEEmissions_20250520();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_StkAAVEEmissions_20250520', AaveV3Ethereum.POOL, address(proposal));
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

  function test_checkDistributionEnd() public {
    uint256 endTimestampBefore = IStakeAave(AaveSafetyModule.STK_AAVE).DISTRIBUTION_END();

    executePayload(vm, address(proposal));

    uint256 endTimestampAfter = IStakeAave(AaveSafetyModule.STK_AAVE).DISTRIBUTION_END();

    assertEq(
      endTimestampAfter,
      endTimestampBefore,
      'New distribution duration has not been set correctly'
    );
  }

  function test_checkAllowance_stkAAVE() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE
    );

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE
    );

    assertGt(allowanceAfter, allowanceBefore);
    // With previous remaining allowance, this can be greater than or equal to
    assertGe(
      allowanceAfter,
      proposal.DISTRIBUTION_DURATION() *
        proposal.AAVE_EMISSION_PER_SECOND_STK_AAVE() +
        proposal.ALLOWANCE_MARGIN()
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
