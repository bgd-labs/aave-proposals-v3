// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV2EthereumAssets, ICollector} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum_AaveBGDPhase3_20240325} from './AaveV3Ethereum_AaveBGDPhase3_20240325.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveBGDPhase3_20240325
 * command: make test-contract filter=AaveV3Ethereum_AaveBGDPhase3_20240325
 */
contract AaveV3Ethereum_AaveBGDPhase3_20240325_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveBGDPhase3_20240325 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19511164);
    proposal = new AaveV3Ethereum_AaveBGDPhase3_20240325();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_AaveBGDPhase3_20240325', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_validateUpfrontBalances() public {
    uint256 balanceBeforeAave = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 balanceBeforeAUsdt = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 balanceBeforeAUsdc = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(proposal.BGD_RECIPIENT()),
      balanceBeforeAave + proposal.SCOPE_1_AAVE_UPFRONT() + proposal.SCOPE_2_AAVE_UPFRONT()
    );
    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(proposal.BGD_RECIPIENT()),
      balanceBeforeAUsdt + proposal.SCOPE_1_AUSDT_UPFRONT(),
      1
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(proposal.BGD_RECIPIENT()),
      balanceBeforeAUsdc + proposal.SCOPE_2_AUSDC_UPFRONT(),
      1
    );
  }

  function test_validateStreamsConfig() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 currentCollectorStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId() - 1;
    uint256 currentEcoReserveStreamId = ICollector(MiscEthereum.ECOSYSTEM_RESERVE)
      .getNextStreamId() - 1;

    _validateScope1AaveStreamConfig(currentEcoReserveStreamId - 1);
    _validateScope1GhoStreamConfig(currentCollectorStreamId - 1);

    _validateScope2AaveStreamConfig(currentEcoReserveStreamId);
    _validateScope2AUsdcStreamConfig(currentCollectorStreamId);
  }

  function test_withdrawFromStream() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 currentCollectorStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId() - 1;
    uint256 currentEcoReserveStreamId = ICollector(MiscEthereum.ECOSYSTEM_RESERVE)
      .getNextStreamId() - 1;

    uint256 timeWarp = 120 days + 1;
    vm.warp(block.timestamp + timeWarp);

    _validateScope1AaveStreamWithdrawal(currentEcoReserveStreamId - 1, timeWarp);
    _validateScope1GhoStreamWithdrawal(currentCollectorStreamId - 1, timeWarp);

    _validateScope2AaveStreamWithdrawal(currentEcoReserveStreamId);
    _validateScope2AUsdcStreamWithdrawal(currentCollectorStreamId);
  }

  function _validateScope1AaveStreamConfig(uint256 streamId) internal {
    (
      address sender,
      address recipient,
      uint256 amount,
      address token,
      uint256 startTime,
      uint256 endTime,
      uint256 toClaim,

    ) = ICollector(MiscEthereum.ECOSYSTEM_RESERVE).getStream(streamId);

    assertEq(sender, address(MiscEthereum.ECOSYSTEM_RESERVE));
    assertEq(recipient, proposal.BGD_RECIPIENT());
    assertEq(amount, proposal.ACTUAL_SCOPE_1_AAVE_STREAM());
    assertEq(token, AaveV3EthereumAssets.AAVE_UNDERLYING);
    assertEq(endTime - startTime, proposal.SCOPE_1_STREAM_DURATION());
    assertEq(toClaim, proposal.ACTUAL_SCOPE_1_AAVE_STREAM());
  }

  function _validateScope1GhoStreamConfig(uint256 streamId) internal {
    (
      address sender,
      address recipient,
      uint256 amount,
      address token,
      uint256 startTime,
      uint256 endTime,
      uint256 toClaim,

    ) = AaveV3Ethereum.COLLECTOR.getStream(streamId);

    assertEq(sender, address(AaveV3Ethereum.COLLECTOR));
    assertEq(recipient, proposal.BGD_RECIPIENT());
    assertEq(amount, proposal.ACTUAL_SCOPE_1_GHO_STREAM());
    assertEq(token, AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(endTime - startTime, proposal.SCOPE_1_STREAM_DURATION());
    assertEq(toClaim, proposal.ACTUAL_SCOPE_1_GHO_STREAM());
  }

  function _validateScope2AaveStreamConfig(uint256 streamId) internal {
    (
      address sender,
      address recipient,
      uint256 amount,
      address token,
      uint256 startTime,
      uint256 endTime,
      uint256 toClaim,

    ) = ICollector(MiscEthereum.ECOSYSTEM_RESERVE).getStream(streamId);

    assertEq(sender, address(MiscEthereum.ECOSYSTEM_RESERVE));
    assertEq(recipient, proposal.BGD_RECIPIENT());
    assertEq(amount, proposal.SCOPE_2_AAVE_STREAM());
    assertEq(token, AaveV3EthereumAssets.AAVE_UNDERLYING);
    assertEq(endTime - startTime, proposal.SCOPE_2_STREAM_DURATION());
    assertEq(toClaim, proposal.SCOPE_2_AAVE_STREAM());
  }

  function _validateScope2AUsdcStreamConfig(uint256 streamId) internal {
    (
      address sender,
      address recipient,
      uint256 amount,
      address token,
      uint256 startTime,
      uint256 endTime,
      uint256 toClaim,

    ) = AaveV3Ethereum.COLLECTOR.getStream(streamId);

    assertEq(sender, address(AaveV3Ethereum.COLLECTOR));
    assertEq(recipient, proposal.BGD_RECIPIENT());
    assertEq(amount, proposal.SCOPE_2_AUSDC_STREAM());
    assertEq(token, AaveV3EthereumAssets.USDC_A_TOKEN);
    assertEq(endTime - startTime, proposal.SCOPE_2_STREAM_DURATION());
    assertEq(toClaim, proposal.SCOPE_2_AUSDC_STREAM());
  }

  function _validateScope1AaveStreamWithdrawal(uint256 streamId, uint256 timeWarp) internal {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    vm.startPrank(proposal.BGD_RECIPIENT());
    uint256 streamSpeed = proposal.ACTUAL_SCOPE_1_AAVE_STREAM() /
      proposal.SCOPE_1_STREAM_DURATION();
    uint256 accrued = streamSpeed * timeWarp;

    ICollector(MiscEthereum.ECOSYSTEM_RESERVE).withdrawFromStream(streamId, accrued);

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    assertEq(balanceAfter, balanceBefore + accrued);
    vm.stopPrank();
  }

  function _validateScope1GhoStreamWithdrawal(uint256 streamId, uint256 timeWarp) internal {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    vm.startPrank(proposal.BGD_RECIPIENT());
    uint256 streamSpeed = proposal.ACTUAL_SCOPE_1_GHO_STREAM() / proposal.SCOPE_1_STREAM_DURATION();
    uint256 accrued = streamSpeed * timeWarp;

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(streamId, accrued);

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    assertEq(balanceAfter, balanceBefore + accrued);
    vm.stopPrank();
  }

  function _validateScope2AaveStreamWithdrawal(uint256 streamId) internal {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    vm.startPrank(proposal.BGD_RECIPIENT());
    ICollector(MiscEthereum.ECOSYSTEM_RESERVE).withdrawFromStream(
      streamId,
      proposal.SCOPE_2_AAVE_STREAM()
    );

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    assertEq(balanceAfter, balanceBefore + proposal.SCOPE_2_AAVE_STREAM());
    vm.stopPrank();
  }

  function _validateScope2AUsdcStreamWithdrawal(uint256 streamId) internal {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );

    vm.startPrank(proposal.BGD_RECIPIENT());
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(streamId, proposal.SCOPE_2_AUSDC_STREAM());

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    assertEq(balanceAfter, balanceBefore + proposal.SCOPE_2_AUSDC_STREAM());
    vm.stopPrank();
  }
}
