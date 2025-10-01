// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_ClaimOldStkAaveRewards_20250930, AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part1, AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part2} from './AaveV2Ethereum_ClaimOldStkAaveRewards_20250930.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';

import {IAaveIncentivesController} from './interfaces/IAaveIncentivesController.sol';

/**
 * @dev Test for AaveV2Ethereum_ClaimOldStkAaveRewards_20250930
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250930_AaveV2Ethereum_ClaimOldStkAaveRewards/AaveV2Ethereum_ClaimOldStkAaveRewards_20250930.t.sol -vv
 */
contract AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Test is ProtocolV2TestBase {
  AaveV2Ethereum_ClaimOldStkAaveRewards_20250930 internal proposal;
  AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part1 internal payload_part1;
  AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part2 internal payload_part2;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23460213);

    uint256 executionTime = block.timestamp + 5 days + 1 days + 1 days;
    payload_part1 = new AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part1(executionTime);
    payload_part2 = new AaveV2Ethereum_ClaimOldStkAaveRewards_20250930_Part2(payload_part1);
    proposal = AaveV2Ethereum_ClaimOldStkAaveRewards_20250930(payload_part1.PAYLOAD());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _execute();
  }

  function test_validateClaimRewards() public {
    uint256 unclaimedRewards = IAaveIncentivesController(
      AaveV2Ethereum.DEFAULT_INCENTIVES_CONTROLLER
    ).getUserUnclaimedRewards(address(AaveV2Ethereum.COLLECTOR));
    uint256 prevBalance = IERC20(AaveSafetyModule.STK_AAVE).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    _execute();

    uint256 afterBalance = IERC20(AaveSafetyModule.STK_AAVE).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    assertEq(afterBalance - prevBalance, unclaimedRewards);
  }

  function _execute() internal {
    vm.warp(block.timestamp + 5 days);
    executePayload(vm, address(payload_part1));

    vm.warp(payload_part1.EXECUTION_TIME());
    executePayload(vm, address(payload_part2));
  }
}
