// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/console.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IStakeToken} from './IStakeToken.sol';
import {StkGHO_Activation_20240118} from './StkGHO_Activation_20240118.sol';

/**
 * @dev Test for StkGHO_Activation_20240118
 * command: make test-contract filter=StkGHO_Activation_20240118
 */
contract StkGHO_Activation_20240118_Test is ProtocolV3TestBase {
  StkGHO_Activation_20240118 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19040576);

    proposal = new StkGHO_Activation_20240118();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    (uint128 emissionPerSecondBefore, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );

    GovV3Helpers.executePayload(vm, address(proposal));
    (
      uint128 emissionPerSecondAfter,
      uint128 lastUpdateTimestampAfter, // uint256 indexAfter

    ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(AaveSafetyModule.STK_GHO);

    // NOTE index is still 0
    assertEq(emissionPerSecondBefore + emissionPerSecondAfter, proposal.AAVE_EMISSION_PER_SECOND());
    assertEq(lastUpdateTimestampAfter, block.timestamp);
  }

  function test_ecosystemCorrectAllowance() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_GHO
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      AaveSafetyModule.STK_GHO
    );

    assertEq(
      allowanceAfter - allowanceBefore,
      proposal.AAVE_EMISSION_PER_SECOND() * proposal.DISTRIBUTION_DURATION()
    );
  }

  function test_emission() public {
    address prankAddress = 0xF5Fb27b912D987B5b6e02A1B1BE0C1F0740E2c6f;

    uint256 confidenceMargin = 1e6; // margin of error due to rounding
    uint256 rewardsPerDay = 50e18;

    GovV3Helpers.executePayload(vm, address(proposal));

    // impersonating address with AAVE balance
    vm.prank(prankAddress);
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).approve(AaveSafetyModule.STK_GHO, 1e18);

    vm.prank(prankAddress);
    IStakeToken(AaveSafetyModule.STK_GHO).stake(prankAddress, 1e18);

    vm.warp(block.timestamp + 1 days);

    vm.prank(prankAddress);
    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_GHO).getTotalRewardsBalance(
      prankAddress
    );

    assertTrue(
      rewardsBalance >= (rewardsPerDay - confidenceMargin) &&
        rewardsBalance <= (rewardsPerDay + confidenceMargin)
    );
  }
}
