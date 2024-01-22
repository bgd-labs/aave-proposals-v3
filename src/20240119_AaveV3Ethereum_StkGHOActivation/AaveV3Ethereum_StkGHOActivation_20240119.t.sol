// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IStakeToken} from './IStakeToken.sol';
import {AaveV3Ethereum_StkGHOActivation_20240119} from './AaveV3Ethereum_StkGHOActivation_20240119.sol';

/**
 * @dev Test for AaveV3Ethereum_StkGHOActivation_20240119
 * command: make test-contract filter=AaveV3Ethereum_StkGHOActivation_20240119
 */
contract AaveV3Ethereum_StkGHOActivation_20240119_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StkGHOActivation_20240119 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19042382);
    proposal = new AaveV3Ethereum_StkGHOActivation_20240119();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_StkGHOActivation_20240119', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_checkConfig() public {
    (uint128 emissionPerSecondBefore, , ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(
      AaveV3EthereumAssets.GHO_UNDERLYING
    );

    executePayload(vm, address(proposal));

    (
      uint128 emissionPerSecondAfter,
      uint128 lastUpdateTimestampAfter, // uint256 indexAfter

    ) = IStakeToken(AaveSafetyModule.STK_GHO).assets(AaveSafetyModule.STK_GHO);

    // NOTE index is still 0
    assertEq(emissionPerSecondBefore + emissionPerSecondAfter, proposal.AAVE_EMISSION_PER_SECOND());
    assertEq(lastUpdateTimestampAfter, block.timestamp);
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

    assertEq(
      allowanceAfter - allowanceBefore,
      proposal.AAVE_EMISSION_PER_SECOND() * proposal.DISTRIBUTION_DURATION()
    );
  }

  function test_checkRewards() public {
    address prankAddress = 0xF5Fb27b912D987B5b6e02A1B1BE0C1F0740E2c6f;

    uint256 confidenceMargin = 1e6; // margin of error due to rounding
    uint256 rewardsPerDay = 50e18;

    executePayload(vm, address(proposal));

    // impersonating address with AAVE balance
    vm.startPrank(prankAddress);
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).approve(AaveSafetyModule.STK_GHO, 1e18);

    IStakeToken(AaveSafetyModule.STK_GHO).stake(prankAddress, 1e18);

    vm.warp(block.timestamp + 1 days);

    uint256 rewardsBalance = IStakeToken(AaveSafetyModule.STK_GHO).getTotalRewardsBalance(
      prankAddress
    );

    assertTrue(
      rewardsBalance >= (rewardsPerDay - confidenceMargin) &&
        rewardsBalance <= (rewardsPerDay + confidenceMargin)
    );

    vm.stopPrank();
  }
}
