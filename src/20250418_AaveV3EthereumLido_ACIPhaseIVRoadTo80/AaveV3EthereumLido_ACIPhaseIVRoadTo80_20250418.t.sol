// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_ACIPhaseIVRoadTo80_20250418} from './AaveV3EthereumLido_ACIPhaseIVRoadTo80_20250418.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @dev Test for AaveV3EthereumLido_ACIPhaseIVRoadTo80_20250418
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250418_AaveV3EthereumLido_ACIPhaseIVRoadTo80/AaveV3EthereumLido_ACIPhaseIVRoadTo80_20250418.t.sol -vv
 */
contract AaveV3EthereumLido_ACIPhaseIVRoadTo80_20250418_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_ACIPhaseIVRoadTo80_20250418 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22348667);
    proposal = new AaveV3EthereumLido_ACIPhaseIVRoadTo80_20250418();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_ACIPhaseIVRoadTo80_20250418',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_wholeProcess() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%

    address ghoPaymentAddresses = proposal.ACI();
    uint256 ghoBalancesBeforeUsers = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      ghoPaymentAddresses
    );

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 365 days);

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
      proposal.STREAM_AMOUNT(),
      maxDeltaStreamBalance,
      'GHO Stream final balance is not correct'
    );

    vm.prank(ghoPaymentAddresses);
    AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId, finalBalanceToWithdraw);
    assertApproxEqRel(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(ghoPaymentAddresses),
      ghoBalancesBeforeUsers + proposal.STREAM_AMOUNT() + aGHOInterest,
      maxDeltaStreamBalance,
      'GHO Stream final withdraw is not correct'
    );
  }

  function test_streamBalance() public {
    address ghoPaymentAddresses = proposal.ACI();

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 1 days);

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

  function test_streamEndBalance() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%

    address ghoPaymentAddresses = proposal.ACI();

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 365 days);

    uint256 finalBalanceToWithdraw = AaveV3EthereumLido.COLLECTOR.balanceOf(
      nextStreamId,
      ghoPaymentAddresses
    );

    assertApproxEqRel(finalBalanceToWithdraw, proposal.STREAM_AMOUNT(), maxDeltaStreamBalance);

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
      ghoBalanceBefore + proposal.STREAM_AMOUNT(),
      maxDeltaStreamBalance
    );
  }
}
