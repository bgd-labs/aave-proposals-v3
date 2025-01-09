// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_karpatkeyGhoGrowth_20241231} from './AaveV3Ethereum_karpatkeyGhoGrowth_20241231.sol';

/**
 * @dev Test for AaveV3Ethereum_karpatkeyGhoGrowth_20241231
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241231_AaveV3Ethereum_karpatkeyGhoGrowth/AaveV3Ethereum_karpatkeyGhoGrowth_20241231.t.sol -vv
 */
contract AaveV3Ethereum_karpatkeyGhoGrowth_20241231_Test is ProtocolV3TestBase {
  AaveV3Ethereum_karpatkeyGhoGrowth_20241231 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21524445);
    proposal = new AaveV3Ethereum_karpatkeyGhoGrowth_20241231();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_karpatkeyGhoGrowth_20241231',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_stream() public {
    uint256 backDatedAmount = (proposal.ACTUAL_STREAM_AMOUNT() *
      (block.timestamp - proposal.STREAM_START_TIME())) / proposal.STREAM_DURATION();

    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();

    executePayload(vm, address(proposal));

    (
      address sender,
      address recipient,
      uint256 deposit,
      address tokenAddress,
      uint256 startTime,
      uint256 stopTime,
      uint256 remainingBalance,

    ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

    assertEq(sender, address(AaveV3Ethereum.COLLECTOR));
    assertEq(recipient, proposal.KARPATKEY_SAFE());
    assertEq(deposit, proposal.ACTUAL_STREAM_AMOUNT() - backDatedAmount);
    assertEq(tokenAddress, AaveV3EthereumLidoAssets.GHO_A_TOKEN);
    assertEq(startTime, block.timestamp);
    assertEq(stopTime, proposal.STREAM_START_TIME() + proposal.STREAM_DURATION());
    assertEq(remainingBalance, proposal.ACTUAL_STREAM_AMOUNT() - backDatedAmount);

    // Can withdraw during stream
    vm.warp(block.timestamp + 30 days);

    uint256 collectorGhoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 receiverGhoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      proposal.KARPATKEY_SAFE()
    );

    vm.startPrank(proposal.KARPATKEY_SAFE());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextCollectorStreamID,
      proposal.ACTUAL_STREAM_AMOUNT() / 9
    );
    vm.stopPrank();

    assertGt(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(proposal.KARPATKEY_SAFE()),
      receiverGhoBalanceBefore
    );

    assertLt(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorGhoBalanceBefore
    );

    // Can withdraw post stream all remaining funds
    vm.warp(block.timestamp + proposal.STREAM_DURATION());

    (, , , , , , uint256 remaining, ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

    vm.startPrank(proposal.KARPATKEY_SAFE());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, remaining);
    vm.stopPrank();

    assertEq(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(proposal.KARPATKEY_SAFE()),
      receiverGhoBalanceBefore + proposal.ACTUAL_STREAM_AMOUNT() - backDatedAmount
    );
  }
}
