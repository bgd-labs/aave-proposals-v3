// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import 'forge-std/StdUtils.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_V4ALServiceProviderProposal_20240614} from './AaveV3Ethereum_V4ALServiceProviderProposal_20240614.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_V4ALServiceProviderProposal_20240614
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240614_AaveV3Ethereum_V4ALServiceProviderProposal/AaveV3Ethereum_V4ALServiceProviderProposal_20240614.t.sol -vv
 */
contract AaveV3Ethereum_V4ALServiceProviderProposal_20240614_Test is ProtocolV3TestBase {
  AaveV3Ethereum_V4ALServiceProviderProposal_20240614 internal proposal;

  address public constant AAVE_LABS = 0x1c037b3C22240048807cC9d7111be5d455F640bd;
  uint256 public constant GHO_UPFRONT_AMOUNT = 3_000_000 ether;
  uint256 public constant GHO_STREAM_AMOUNT = 9_000_000 ether;
  uint256 public constant GHO_STREAM_DURATION = 365 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (GHO_STREAM_AMOUNT / GHO_STREAM_DURATION) * GHO_STREAM_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20092863);
    proposal = new AaveV3Ethereum_V4ALServiceProviderProposal_20240614();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_V4ALServiceProviderProposal_20240614',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function testProposalExecution() public {
    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 ALGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);
    uint256 CollectorV3GHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    // Check balances directly after proposal execution (upfront payment distributed to Aave Labs)
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS),
      ALGHOBalanceBefore + GHO_UPFRONT_AMOUNT
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      CollectorV3GHOBalanceBefore - GHO_UPFRONT_AMOUNT
    );

    // Checking if the streams have been created properly
    // Scoping to avoid "stack too deep" error
    {
      (
        address senderGHO,
        address recipientGHO,
        uint256 depositGHO,
        address tokenAddressGHO,
        uint256 startTimeGHO,
        uint256 stopTimeGHO,
        uint256 remainingBalanceGHO,

      ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

      assertEq(senderGHO, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientGHO, AAVE_LABS);
      assertEq(depositGHO, ACTUAL_STREAM_AMOUNT_GHO);
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, GHO_STREAM_DURATION);
      assertEq(remainingBalanceGHO, ACTUAL_STREAM_AMOUNT_GHO);
    }

    // Checking if Aave Labs can withdraw from the stream
    vm.startPrank(AAVE_LABS);
    vm.warp(block.timestamp + GHO_STREAM_DURATION);

    // Currently Collector has less funds than stream amount
    assertLe(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      ACTUAL_STREAM_AMOUNT_GHO
    );

    // Partial withdrawal of Collector's remaining balance
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextCollectorStreamID,
      CollectorV3GHOBalanceBefore - GHO_UPFRONT_AMOUNT
    );
    uint256 nextALGHOBalance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);

    // Aave Labs received the entirety of Collector's balance
    assertEq(ALGHOBalanceBefore, nextALGHOBalance - CollectorV3GHOBalanceBefore);

    // Check Collector balance after stream withdrawal
    uint256 CollectorV3GHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(CollectorV3GHOBalanceAfter, 0);

    vm.stopPrank();
  }

  // Test giving V2 Collector more funds and full withdrawing
  function testProposalExecutionPrankFunds() public {
    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 ALGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);

    // Giving the Collector enough funds to cover the stream
    deal(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      address(AaveV3Ethereum.COLLECTOR),
      GHO_UPFRONT_AMOUNT + GHO_STREAM_AMOUNT
    );

    uint256 CollectorV3GHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    // Check balances directly after proposal execution (upfront payment distributed to Aave Labs)
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS),
      ALGHOBalanceBefore + GHO_UPFRONT_AMOUNT
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      CollectorV3GHOBalanceBefore - GHO_UPFRONT_AMOUNT
    );

    // Checking if the streams have been created properly
    // Scoping to avoid "stack too deep" error
    {
      (
        address senderGHO,
        address recipientGHO,
        uint256 depositGHO,
        address tokenAddressGHO,
        uint256 startTimeGHO,
        uint256 stopTimeGHO,
        uint256 remainingBalanceGHO,

      ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

      assertEq(senderGHO, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientGHO, AAVE_LABS);
      assertEq(depositGHO, ACTUAL_STREAM_AMOUNT_GHO);
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, GHO_STREAM_DURATION);
      assertEq(remainingBalanceGHO, ACTUAL_STREAM_AMOUNT_GHO);
    }

    // Checking if Aave Labs can withdraw from the stream
    vm.startPrank(AAVE_LABS);
    vm.warp(block.timestamp + GHO_STREAM_DURATION);

    assertGe(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      ACTUAL_STREAM_AMOUNT_GHO
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, ACTUAL_STREAM_AMOUNT_GHO);
    uint256 nextALGHOBalance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);

    assertEq(
      ALGHOBalanceBefore,
      nextALGHOBalance - (ACTUAL_STREAM_AMOUNT_GHO + GHO_UPFRONT_AMOUNT)
    );

    // Check Collector balance after stream withdrawal
    uint256 CollectorV3GHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(
      CollectorV3GHOBalanceAfter,
      CollectorV3GHOBalanceBefore - (ACTUAL_STREAM_AMOUNT_GHO + GHO_UPFRONT_AMOUNT)
    );

    vm.stopPrank();
  }

  // Test showing V2 Collector currently doesn't have enough funds
  function testProposalExecutionFailureFunding() public {
    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 ALGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);

    uint256 CollectorV3GHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    // Check balances directly after proposal execution (upfront payment distributed to Aave Labs)
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS),
      ALGHOBalanceBefore + GHO_UPFRONT_AMOUNT
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      CollectorV3GHOBalanceBefore - GHO_UPFRONT_AMOUNT
    );

    // Checking if the streams have been created properly
    // Scoping to avoid "stack too deep" error
    {
      (
        address senderGHO,
        address recipientGHO,
        uint256 depositGHO,
        address tokenAddressGHO,
        uint256 startTimeGHO,
        uint256 stopTimeGHO,
        uint256 remainingBalanceGHO,

      ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

      assertEq(senderGHO, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientGHO, AAVE_LABS);
      assertEq(depositGHO, ACTUAL_STREAM_AMOUNT_GHO);
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, GHO_STREAM_DURATION);
      assertEq(remainingBalanceGHO, ACTUAL_STREAM_AMOUNT_GHO);
    }

    // Checking if Aave Labs can withdraw from the stream
    vm.startPrank(AAVE_LABS);
    vm.warp(block.timestamp + GHO_STREAM_DURATION);

    assertLe(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      ACTUAL_STREAM_AMOUNT_GHO
    );

    vm.expectRevert(stdError.arithmeticError);
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, ACTUAL_STREAM_AMOUNT_GHO);

    vm.stopPrank();
  }

  function testProposalExecutionFuzzWithdrawalAmounts(
    uint256 withdrawalAmount,
    uint256 waitPeriod
  ) public {
    waitPeriod = bound(waitPeriod, 1, GHO_STREAM_DURATION);
    withdrawalAmount = bound(
      withdrawalAmount,
      1,
      waitPeriod * (ACTUAL_STREAM_AMOUNT_GHO / GHO_STREAM_DURATION)
    );

    // Giving the Collector enough funds to cover the stream
    deal(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      address(AaveV3Ethereum.COLLECTOR),
      GHO_UPFRONT_AMOUNT + GHO_STREAM_AMOUNT
    );

    assertGe(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      ACTUAL_STREAM_AMOUNT_GHO
    );

    uint256 ALGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);
    uint256 CollectorV3GHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    executePayload(vm, address(proposal));

    // Check balances directly after proposal execution (upfront payment distributed to Aave Labs)
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS),
      ALGHOBalanceBefore + GHO_UPFRONT_AMOUNT
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      CollectorV3GHOBalanceBefore - GHO_UPFRONT_AMOUNT
    );

    vm.startPrank(AAVE_LABS);
    vm.warp(block.timestamp + waitPeriod);

    // Withdraw fuzzed amount from stream
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, withdrawalAmount);

    uint256 ALGHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);
    uint256 CollectorV3GHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(ALGHOBalanceAfter - ALGHOBalanceBefore, withdrawalAmount + GHO_UPFRONT_AMOUNT);
    assertEq(
      CollectorV3GHOBalanceAfter,
      CollectorV3GHOBalanceBefore - (withdrawalAmount + GHO_UPFRONT_AMOUNT)
    );

    vm.stopPrank();
  }
}
