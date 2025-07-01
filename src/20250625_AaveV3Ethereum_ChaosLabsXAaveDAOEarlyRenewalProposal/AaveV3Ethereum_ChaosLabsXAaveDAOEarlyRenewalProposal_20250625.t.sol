// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import {AggregatorInterface} from 'aave-v3-origin/contracts/dependencies/chainlink/AggregatorInterface.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC20Metadata} from 'openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625} from './AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625.sol';

/**
 * @dev Test for AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250625_AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal/AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625.t.sol -vv
 */
contract AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22779766);
    proposal = new AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ChaosLabsXAaveDAOEarlyRenewalProposal_20250625',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_wholeProcessGHO() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%

    address ghoPaymentAddresses = proposal.CHAOS_LABS();
    uint256 ghoBalancesBeforeUsers = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      ghoPaymentAddresses
    );

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 385 days); // stream starting in 20 days or so

    uint256 aGHOInterest = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      ghoPaymentAddresses
    ) - ghoBalancesBeforeUsers;
    // Stream transfers
    uint256 finalBalanceToWithdraw = AaveV3EthereumLido.COLLECTOR.balanceOf(
      nextStreamId,
      ghoPaymentAddresses
    );

    assertApproxEqRel(
      finalBalanceToWithdraw,
      proposal.GHO_STREAM_AMOUNT(),
      maxDeltaStreamBalance,
      'GHO Stream final balance is not correct'
    );

    vm.prank(ghoPaymentAddresses);
    AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId, finalBalanceToWithdraw);
    assertApproxEqRel(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(ghoPaymentAddresses),
      ghoBalancesBeforeUsers + proposal.GHO_STREAM_AMOUNT() + aGHOInterest,
      maxDeltaStreamBalance,
      'GHO Stream final withdraw is not correct'
    );
  }

  function test_streamBalanceGHO() public {
    address ghoPaymentAddresses = proposal.CHAOS_LABS();

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(proposal.STREAM_START() + 1 days); // assuming the AIP isn't way behind schedule

    uint256 ghoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      ghoPaymentAddresses
    );

    vm.prank(ghoPaymentAddresses);
    AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId, 1);

    uint256 ghoBalanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      ghoPaymentAddresses
    );

    assertEq(ghoBalanceAfter, ghoBalanceBefore + 1);
  }

  function test_streamEndBalanceGHO() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%

    address ghoPaymentAddresses = proposal.CHAOS_LABS();

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 385 days);

    uint256 finalBalanceToWithdraw = AaveV3EthereumLido.COLLECTOR.balanceOf(
      nextStreamId,
      ghoPaymentAddresses
    );

    assertApproxEqRel(finalBalanceToWithdraw, proposal.GHO_STREAM_AMOUNT(), maxDeltaStreamBalance);

    uint256 ghoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      ghoPaymentAddresses
    );

    vm.prank(ghoPaymentAddresses);
    AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId, finalBalanceToWithdraw);

    uint256 ghoBalanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      ghoPaymentAddresses
    );

    assertApproxEqRel(
      ghoBalanceAfter,
      ghoBalanceBefore + proposal.GHO_STREAM_AMOUNT(),
      maxDeltaStreamBalance
    );
  }

  function test_wholeProcessAAVE() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%
    IStreamable reserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);

    address aavePaymentAddresses = proposal.CHAOS_LABS();
    uint256 aaveBalancesBeforeUsers = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      aavePaymentAddresses
    );

    uint256 nextStreamId = reserve.getNextStreamId();

    vm.expectRevert();
    reserve.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 385 days); // stream starting in 20 days or so

    // Stream transfers
    uint256 finalBalanceToWithdraw = reserve.balanceOf(nextStreamId, aavePaymentAddresses);

    assertApproxEqRel(
      finalBalanceToWithdraw,
      (proposal.AAVE_AMOUNT_IN_DOLLARS() *
        10 ** IERC20Metadata(AaveV3EthereumAssets.AAVE_UNDERLYING).decimals() *
        10 ** 14) / proposal.AAVE_PRICE(),
      maxDeltaStreamBalance,
      'AAVE Stream final balance is not correct'
    );

    vm.prank(aavePaymentAddresses);
    reserve.withdrawFromStream(nextStreamId, finalBalanceToWithdraw);
    assertApproxEqRel(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(aavePaymentAddresses),
      aaveBalancesBeforeUsers +
        (proposal.AAVE_AMOUNT_IN_DOLLARS() *
          10 ** IERC20Metadata(AaveV3EthereumAssets.AAVE_UNDERLYING).decimals() *
          10 ** 14) /
        proposal.AAVE_PRICE(),
      maxDeltaStreamBalance,
      'AAVE Stream final withdraw is not correct'
    );
  }

  function test_streamBalanceAAVE() public {
    address aavePaymentAddresses = proposal.CHAOS_LABS();
    IStreamable reserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);

    uint256 nextStreamId = reserve.getNextStreamId();

    vm.expectRevert();
    reserve.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(proposal.STREAM_START() + 1 days); // assuming the AIP isn't way behind schedule

    uint256 aaveBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      aavePaymentAddresses
    );

    vm.prank(aavePaymentAddresses);
    reserve.withdrawFromStream(nextStreamId, 1);

    uint256 aaveBalanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      aavePaymentAddresses
    );

    assertEq(aaveBalanceAfter, aaveBalanceBefore + 1);
  }

  function test_streamEndBalanceAAVE() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%
    IStreamable reserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);

    address aavePaymentAddresses = proposal.CHAOS_LABS();

    uint256 nextStreamId = reserve.getNextStreamId();

    vm.expectRevert();
    reserve.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 385 days);

    uint256 finalBalanceToWithdraw = reserve.balanceOf(nextStreamId, aavePaymentAddresses);

    assertApproxEqRel(
      finalBalanceToWithdraw,
      (proposal.AAVE_AMOUNT_IN_DOLLARS() *
        10 ** IERC20Metadata(AaveV3EthereumAssets.AAVE_UNDERLYING).decimals() *
        10 ** 14) / proposal.AAVE_PRICE(),
      maxDeltaStreamBalance
    );

    uint256 aaveBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      aavePaymentAddresses
    );

    vm.prank(aavePaymentAddresses);
    reserve.withdrawFromStream(nextStreamId, finalBalanceToWithdraw);

    uint256 aaveBalanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      aavePaymentAddresses
    );

    assertApproxEqRel(
      aaveBalanceAfter,
      aaveBalanceBefore +
        (proposal.AAVE_AMOUNT_IN_DOLLARS() *
          10 ** IERC20Metadata(AaveV3EthereumAssets.AAVE_UNDERLYING).decimals() *
          10 ** 14) /
        proposal.AAVE_PRICE(),
      maxDeltaStreamBalance
    );
  }
}
