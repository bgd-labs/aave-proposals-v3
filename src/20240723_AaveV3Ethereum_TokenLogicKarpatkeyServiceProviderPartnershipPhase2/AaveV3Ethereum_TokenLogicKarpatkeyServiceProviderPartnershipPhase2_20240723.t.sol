// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723} from './AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723.sol';

/**
 * @dev Test for AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240723_AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2/AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723.t.sol -vv
 */
contract AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20370107);
    proposal = new AaveV3Ethereum_TokenLogicKarpatkeyServiceProviderPartnershipPhase2_20240723();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_execute() public {
    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 nextCollectorStreamIDTwo = nextCollectorStreamID + 1;

    uint256 receiverOneBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.KARPATKEY_RECEIVER()
    );
    uint256 receiverTwoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.TOKENLOGIC_RECEIVER()
    );

    uint256 collectorBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 backdatedAmount = (proposal.ACTUAL_AMOUNT() / proposal.STREAM_DURATION()) *
      (block.timestamp - proposal.ORIGINAL_STARTDATE());

    executePayload(vm, address(proposal));

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
      assertEq(recipientGHO, proposal.KARPATKEY_RECEIVER());
      assertEq(depositGHO + backdatedAmount, proposal.ACTUAL_AMOUNT());
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(
        stopTimeGHO - startTimeGHO,
        proposal.STREAM_DURATION() + proposal.ORIGINAL_STARTDATE() - block.timestamp
      );
      assertEq(remainingBalanceGHO + backdatedAmount, proposal.ACTUAL_AMOUNT());
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
      assertEq(recipientGHO, proposal.TOKENLOGIC_RECEIVER());
      assertEq(depositGHO + backdatedAmount, proposal.ACTUAL_AMOUNT());
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(
        stopTimeGHO - startTimeGHO,
        proposal.STREAM_DURATION() + proposal.ORIGINAL_STARTDATE() - block.timestamp
      );
      assertEq(remainingBalanceGHO + backdatedAmount, proposal.ACTUAL_AMOUNT());
    }

    // Can withdraw during stream
    vm.warp(block.timestamp + 30 days);

    vm.startPrank(proposal.KARPATKEY_RECEIVER());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextCollectorStreamID,
      proposal.ACTUAL_AMOUNT() / 30 days
    );
    vm.stopPrank();

    assertGt(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.KARPATKEY_RECEIVER()),
      receiverOneBalanceBefore
    );

    vm.startPrank(proposal.TOKENLOGIC_RECEIVER());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextCollectorStreamIDTwo,
      proposal.ACTUAL_AMOUNT() / 30 days
    );
    vm.stopPrank();

    assertGt(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.TOKENLOGIC_RECEIVER()),
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

    vm.startPrank(proposal.KARPATKEY_RECEIVER());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, remainingOne);
    vm.stopPrank();

    vm.startPrank(proposal.TOKENLOGIC_RECEIVER());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamIDTwo, remainingTwo);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.KARPATKEY_RECEIVER()),
      receiverOneBalanceBefore + proposal.ACTUAL_AMOUNT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.TOKENLOGIC_RECEIVER()),
      receiverTwoBalanceBefore + proposal.ACTUAL_AMOUNT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorBalanceBefore - proposal.ACTUAL_AMOUNT() - proposal.ACTUAL_AMOUNT()
    );
  }
}
