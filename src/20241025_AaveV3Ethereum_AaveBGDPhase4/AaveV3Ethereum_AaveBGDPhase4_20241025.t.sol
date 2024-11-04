// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum_AaveBGDPhase4_20241025} from './AaveV3Ethereum_AaveBGDPhase4_20241025.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveBGDPhase4_20241025
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241025_AaveV3Ethereum_AaveBGDPhase4/AaveV3Ethereum_AaveBGDPhase4_20241025.t.sol -vv
 */
contract AaveV3Ethereum_AaveBGDPhase4_20241025_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveBGDPhase4_20241025 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21043153);
    proposal = new AaveV3Ethereum_AaveBGDPhase4_20241025();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_AaveBGDPhase4_20241025', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_upfrontAmounts() public {
    address receiverAddress = proposal.BGD_RECEIVER();
    uint256 aUsdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      receiverAddress
    );
    uint256 aaveBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      receiverAddress
    );

    executePayload(vm, address(proposal));

    uint256 aUsdcBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      receiverAddress
    );
    uint256 aaveBalanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      receiverAddress
    );

    assertEq(aUsdcBalanceAfter - aUsdcBalanceBefore, 1_150_000e6);
    assertEq(aaveBalanceAfter - aaveBalanceBefore, 2_500e18);
  }

  function test_streamAmounts() public {
    address receiverAddress = proposal.BGD_RECEIVER();
    IStreamable reserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);

    uint256 streamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 streamId_reserve = reserve.getNextStreamId();

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 7 days);
    vm.startPrank(receiverAddress);

    uint256 aUsdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      receiverAddress
    );
    uint256 aaveBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      receiverAddress
    );

    // withdraw 10 wei from stream
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(streamId, 10);
    reserve.withdrawFromStream(streamId_reserve, 10);

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(receiverAddress),
      (aUsdcBalanceBefore + 10)
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(receiverAddress),
      (aaveBalanceBefore + 10)
    );

    vm.warp(proposal.STOP_TIME());

    aUsdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(receiverAddress);
    aaveBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(receiverAddress);

    // withdraw all remaining amount from stream
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      streamId,
      AaveV3Ethereum.COLLECTOR.balanceOf(streamId, receiverAddress)
    );
    reserve.withdrawFromStream(
      streamId_reserve,
      reserve.balanceOf(streamId_reserve, receiverAddress)
    );

    uint256 aUsdcBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      receiverAddress
    );
    uint256 aaveBalanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      receiverAddress
    );

    assertApproxEqAbs(aUsdcBalanceAfter, aUsdcBalanceBefore + 1_150_000e6, 15e6);
    assertApproxEqAbs(aaveBalanceAfter, aaveBalanceBefore + 2_500e18, 1e18);
  }
}
