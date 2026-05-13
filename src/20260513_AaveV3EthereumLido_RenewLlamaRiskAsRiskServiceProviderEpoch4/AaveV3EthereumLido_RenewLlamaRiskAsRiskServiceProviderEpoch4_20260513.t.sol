// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513} from './AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513.sol';

/**
 * @dev Test for AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260513_AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4/AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513.t.sol -vv
 */
contract AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513_Test is
  ProtocolV3TestBase
{
  uint256 internal constant MAX_DELTA_STREAM_BALANCE = 0.00001e18;

  AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25088434);
    proposal = new AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_RenewLlamaRiskAsRiskServiceProviderEpoch4_20260513',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_previousStreamCanceled() public {
    uint256 streamId = proposal.PREVIOUS_STREAM();
    AaveV3EthereumLido.COLLECTOR.getStream(streamId);

    executePayload(vm, address(proposal));

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(streamId);
  }

  function test_bulkTransfer() public {
    uint256 balanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      proposal.LLAMA_RISK()
    );

    executePayload(vm, address(proposal));

    uint256 balanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      proposal.LLAMA_RISK()
    );

    assertGe(balanceAfter - balanceBefore, proposal.BULK_AMOUNT());
  }

  function test_ghoStreamCreated() public {
    address receiver = proposal.LLAMA_RISK();
    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    (
      address sender,
      address streamReceiver,
      uint256 deposit,
      address tokenAddress,
      uint256 startTime,
      uint256 stopTime,
      ,

    ) = AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    assertEq(sender, address(AaveV3EthereumLido.COLLECTOR));
    assertEq(streamReceiver, receiver);
    assertEq(tokenAddress, AaveV3EthereumLidoAssets.GHO_A_TOKEN);
    assertEq(stopTime - startTime, proposal.STREAM_DURATION());
    assertApproxEqRel(deposit, proposal.GHO_STREAM_AMOUNT(), MAX_DELTA_STREAM_BALANCE);
  }

  function test_ghoStreamPartialWithdraw() public {
    address receiver = proposal.LLAMA_RISK();
    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 1 days);

    uint256 balanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(receiver);

    vm.prank(receiver);
    AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId, 1);

    uint256 balanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(receiver);
    assertEq(balanceAfter, balanceBefore + 1);
  }

  function test_ghoStreamEndBalance() public {
    address receiver = proposal.LLAMA_RISK();
    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + proposal.STREAM_DURATION());

    uint256 streamable = AaveV3EthereumLido.COLLECTOR.balanceOf(nextStreamId, receiver);
    assertApproxEqRel(streamable, proposal.GHO_STREAM_AMOUNT(), MAX_DELTA_STREAM_BALANCE);

    uint256 balanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(receiver);

    vm.prank(receiver);
    AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId, streamable);

    uint256 balanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(receiver);
    assertApproxEqRel(
      balanceAfter,
      balanceBefore + proposal.GHO_STREAM_AMOUNT(),
      MAX_DELTA_STREAM_BALANCE
    );
  }

  function test_aaveStreamCreated() public {
    IStreamable reserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);
    address receiver = proposal.LLAMA_RISK();
    uint256 nextStreamId = reserve.getNextStreamId();
    uint256 expectedAmount = (proposal.AAVE_STREAM_AMOUNT() / proposal.STREAM_DURATION()) *
      proposal.STREAM_DURATION();

    vm.expectRevert();
    reserve.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    (
      address sender,
      address streamReceiver,
      uint256 deposit,
      address tokenAddress,
      uint256 startTime,
      uint256 stopTime,
      ,

    ) = reserve.getStream(nextStreamId);

    assertEq(sender, MiscEthereum.ECOSYSTEM_RESERVE);
    assertEq(streamReceiver, receiver);
    assertEq(tokenAddress, AaveV3EthereumAssets.AAVE_UNDERLYING);
    assertEq(stopTime - startTime, proposal.STREAM_DURATION());
    assertEq(deposit, expectedAmount);
  }

  function test_aaveStreamPartialWithdraw() public {
    IStreamable reserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);
    address receiver = proposal.LLAMA_RISK();
    uint256 nextStreamId = reserve.getNextStreamId();

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 1 days);

    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(receiver);

    vm.prank(receiver);
    reserve.withdrawFromStream(nextStreamId, 1);

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(receiver);
    assertEq(balanceAfter, balanceBefore + 1);
  }

  function test_aaveStreamEndBalance() public {
    IStreamable reserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);
    address receiver = proposal.LLAMA_RISK();
    uint256 nextStreamId = reserve.getNextStreamId();
    uint256 expectedAmount = (proposal.AAVE_STREAM_AMOUNT() / proposal.STREAM_DURATION()) *
      proposal.STREAM_DURATION();

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + proposal.STREAM_DURATION());

    uint256 streamable = reserve.balanceOf(nextStreamId, receiver);
    assertEq(streamable, expectedAmount);

    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(receiver);

    vm.prank(receiver);
    reserve.withdrawFromStream(nextStreamId, streamable);

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(receiver);
    assertEq(balanceAfter, balanceBefore + expectedAmount);
  }
}
