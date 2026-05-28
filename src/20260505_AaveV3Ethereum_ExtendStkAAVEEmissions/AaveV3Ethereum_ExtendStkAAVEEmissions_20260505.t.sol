// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum_ExtendStkAAVEEmissions_20260505} from './AaveV3Ethereum_ExtendStkAAVEEmissions_20260505.sol';

/**
 * @dev Test for AaveV3Ethereum_ExtendStkAAVEEmissions_20260505
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260505_AaveV3Ethereum_ExtendStkAAVEEmissions/AaveV3Ethereum_ExtendStkAAVEEmissions_20260505.t.sol -vv
 */
contract AaveV3Ethereum_ExtendStkAAVEEmissions_20260505_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ExtendStkAAVEEmissions_20260505 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25030100);
    proposal = new AaveV3Ethereum_ExtendStkAAVEEmissions_20260505();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ExtendStkAAVEEmissions_20260505',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBefore, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    assertGt(emissionPerSecondBefore, 0, 'unexpected stkAAVE emission rate before');

    executePayload(vm, address(proposal));

    (uint128 emissionPerSecondAfter, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    assertEq(
      emissionPerSecondAfter,
      emissionPerSecondBefore,
      'unexpected stkAAVE emission rate after'
    );
  }

  function test_checkAllowance() public {
    (uint128 stkAaveEmissionPerSecond, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );

    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE
    );

    uint256 expectedAllowance = allowanceBefore + (uint256(stkAaveEmissionPerSecond) * 90 days);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_AAVE
    );

    assertEq(allowanceAfter, expectedAllowance, 'unexpected stkAAVE allowance after');
  }

  function test_checkRewards_stkAAVE() public {
    (uint128 emissionPerSecond, , ) = IStakeToken(AaveSafetyModule.STK_AAVE).assets(
      AaveSafetyModule.STK_AAVE
    );
    uint256 dailyEmissions = uint256(emissionPerSecond) * 1 days;

    address staker = makeAddr('staker');
    deal(AaveV3EthereumAssets.AAVE_UNDERLYING, staker, 1 ether);

    executePayload(vm, address(proposal));

    vm.startPrank(staker);
    IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).approve(AaveSafetyModule.STK_AAVE, 1 ether);
    IStakeToken(AaveSafetyModule.STK_AAVE).stake(staker, 1 ether);
    vm.stopPrank();

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_AAVE).getTotalRewardsBalance(staker);

    assertTrue(
      rewardsBalance > 0 && rewardsBalance <= dailyEmissions,
      'stkAAVE rewards out of range'
    );
  }
}
