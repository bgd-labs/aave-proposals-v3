// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import {AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest_20260407} from './AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest_20260407.sol';

/**
 * @dev Test for AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest_20260407
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260407_AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest/AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest_20260407.t.sol -vv
 */
contract AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest_20260407_Test is
  ProtocolV3TestBase
{
  AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest_20260407 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24828043);
    proposal = new AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest_20260407();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_AaveWillWinFrameworkPrimaryFundingRequest_20260407',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_upfrontAmount() public {
    address source = address(AaveV3EthereumLido.COLLECTOR);
    IERC20 token = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN);
    address receiver = proposal.AAVE_LABS();
    uint256 amount = proposal.UPFRONT_AGHO_AMOUNT();

    uint256 allowanceBefore = token.allowance({owner: source, spender: receiver});
    assertEq(allowanceBefore, 0); // allowance is not overwritten

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = token.allowance({owner: source, spender: receiver});
    assertEq(allowanceAfter - allowanceBefore, amount);

    // assuming treasury has been supplemented with the respective amount
    _seedGhoOnLidoInstance(amount);
    uint256 balanceBefore = token.balanceOf(receiver);
    vm.prank(receiver);
    assertTrue(token.transferFrom(source, receiver, amount));
    uint256 balanceAfter = token.balanceOf(receiver);

    assertApproxEqAbs(balanceAfter - balanceBefore, amount, 1);
  }

  function test_stream_one() public {
    _testStream({
      source: IStreamable(address(AaveV3EthereumLido.COLLECTOR)),
      token: IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      receiver: proposal.AAVE_LABS(),
      exactAmount: proposal.STREAM_ONE_AGHO_AMOUNT(),
      duration: proposal.STREAM_ONE_AGHO_DURATION(),
      streamIncrement: 0
    });
  }

  function test_stream_two() public {
    _testStream({
      source: IStreamable(address(AaveV3EthereumLido.COLLECTOR)),
      token: IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      receiver: proposal.AAVE_LABS(),
      exactAmount: proposal.STREAM_TWO_AGHO_AMOUNT(),
      duration: proposal.STREAM_TWO_AGHO_DURATION(),
      streamIncrement: 1
    });
  }

  function test_stream_aave() public {
    _testStream({
      source: IStreamable(MiscEthereum.ECOSYSTEM_RESERVE),
      token: IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING),
      receiver: proposal.AAVE_LABS(),
      exactAmount: proposal.STREAM_AAVE_AMOUNT(),
      duration: proposal.STREAM_AAVE_DURATION(),
      streamIncrement: 0
    });
  }

  function _testStream(
    IStreamable source,
    IERC20 token,
    address receiver,
    uint256 exactAmount,
    uint256 duration,
    uint256 streamIncrement
  ) internal {
    uint256 streamId = source.getNextStreamId() + streamIncrement;
    uint256 streamedAmount = (exactAmount / duration) * duration;

    executePayload(vm, address(proposal));

    IStreamable.Stream memory stream;
    (
      stream.sender,
      stream.recipient,
      stream.deposit,
      stream.tokenAddress,
      stream.startTime,
      stream.stopTime,
      stream.remainingBalance,
      stream.ratePerSecond
    ) = source.getStream(streamId);

    assertEq(stream.sender, address(source));
    assertEq(stream.recipient, receiver);
    assertEq(stream.deposit, streamedAmount);
    assertEq(stream.tokenAddress, address(token));
    assertEq(stream.startTime, vm.getBlockTimestamp());
    assertEq(stream.stopTime, vm.getBlockTimestamp() + duration);
    assertEq(stream.remainingBalance, streamedAmount);
    assertEq(stream.ratePerSecond, streamedAmount / duration);

    skip(duration + 1);

    uint256 streamBalance = source.balanceOf(streamId, receiver);
    assertApproxEqAbs(streamBalance, streamedAmount, 1);

    // assuming treasury has been supplemented with the respective amount
    _seedGhoOnLidoInstance(streamedAmount);

    uint256 balanceBefore = token.balanceOf(receiver);
    vm.prank(receiver);
    source.withdrawFromStream(streamId, streamBalance);
    uint256 balanceAfter = token.balanceOf(receiver);

    assertApproxEqAbs(balanceAfter, balanceBefore + streamedAmount, 1);
  }

  function _seedGhoOnLidoInstance(uint256 amount) internal {
    deal2(AaveV3EthereumLidoAssets.GHO_UNDERLYING, address(this), amount);
    IERC20(AaveV3EthereumLidoAssets.GHO_UNDERLYING).approve(
      address(AaveV3EthereumLido.POOL),
      amount
    );
    AaveV3EthereumLido.POOL.supply(
      AaveV3EthereumLidoAssets.GHO_UNDERLYING,
      amount,
      address(AaveV3EthereumLido.COLLECTOR),
      0
    );
  }
}
