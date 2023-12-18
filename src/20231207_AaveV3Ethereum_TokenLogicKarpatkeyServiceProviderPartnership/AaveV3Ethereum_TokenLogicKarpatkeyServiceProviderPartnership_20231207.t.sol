// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207} from './AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207.sol';

/**
 * @dev Test for AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207
 * command: make test-contract filter=AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207
 */
contract AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18736059);
    proposal = new AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnership_20231207();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_execute() public {
    (, , , , , , uint256 streamToCancelRemaining, ) = AaveV3Ethereum.COLLECTOR.getStream(
      proposal.STREAM_TO_CANCEL()
    );

    assertGt(streamToCancelRemaining, 0);

    vm.startPrank(proposal.STREAM_TWO_RECEIVER());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      proposal.STREAM_TO_CANCEL(),
      7773680555555554162512 // what's available currently to withdraw
    );
    vm.stopPrank();

    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 nextCollectorStreamIDTwo = nextCollectorStreamID + 1;

    uint256 receiverOneBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.STREAM_ONE_RECEIVER()
    );
    uint256 receiverTwoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.STREAM_TWO_RECEIVER()
    );

    uint256 collectorBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 streamId = proposal.STREAM_TO_CANCEL();
    vm.expectRevert('stream does not exist');
    AaveV3Ethereum.COLLECTOR.getStream(streamId);

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
      assertEq(recipientGHO, proposal.STREAM_ONE_RECEIVER());
      assertEq(depositGHO, proposal.ACTUAL_AMOUNT_ONE());
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, proposal.STREAM_DURATION());
      assertEq(remainingBalanceGHO, proposal.ACTUAL_AMOUNT_ONE());
    }

    {
      (
        address senderGHO,
        address recipientGHO,
        uint256 depositGHO,
        address tokenAddressGHO,
        uint256 startTimeGHO,
        uint256 stopTimeGHO,
        uint256 remainingBalanceGHO,

      ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamIDTwo);

      assertEq(senderGHO, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientGHO, proposal.STREAM_TWO_RECEIVER());
      assertEq(depositGHO, proposal.ACTUAL_AMOUNT_TWO());
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, proposal.STREAM_DURATION());
      assertEq(remainingBalanceGHO, proposal.ACTUAL_AMOUNT_TWO());
    }

    // Can withdraw during stream
    vm.warp(block.timestamp + 30 days);

    vm.startPrank(proposal.STREAM_ONE_RECEIVER());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextCollectorStreamID,
      proposal.ACTUAL_AMOUNT_ONE() / 30 days
    );
    vm.stopPrank();

    assertGt(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.STREAM_ONE_RECEIVER()),
      receiverOneBalanceBefore
    );

    vm.startPrank(proposal.STREAM_TWO_RECEIVER());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextCollectorStreamIDTwo,
      proposal.ACTUAL_AMOUNT_TWO() / 30 days
    );
    vm.stopPrank();

    assertGt(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.STREAM_TWO_RECEIVER()),
      receiverTwoBalanceBefore
    );

    assertLt(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorBalanceBefore
    );

    // Can withdraw post stream all remaining funds
    vm.warp(block.timestamp + proposal.STREAM_DURATION());

    (, , , , , , uint256 remainingOne, ) = AaveV3Ethereum.COLLECTOR.getStream(
      nextCollectorStreamID
    );

    (, , , , , , uint256 remainingTwo, ) = AaveV3Ethereum.COLLECTOR.getStream(
      nextCollectorStreamIDTwo
    );

    vm.startPrank(proposal.STREAM_ONE_RECEIVER());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, remainingOne);
    vm.stopPrank();

    vm.startPrank(proposal.STREAM_TWO_RECEIVER());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamIDTwo, remainingTwo);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.STREAM_ONE_RECEIVER()),
      receiverOneBalanceBefore + proposal.ACTUAL_AMOUNT_ONE()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.STREAM_TWO_RECEIVER()),
      receiverTwoBalanceBefore + proposal.ACTUAL_AMOUNT_TWO()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorBalanceBefore - proposal.ACTUAL_AMOUNT_ONE() - proposal.ACTUAL_AMOUNT_TWO()
    );
  }
}
