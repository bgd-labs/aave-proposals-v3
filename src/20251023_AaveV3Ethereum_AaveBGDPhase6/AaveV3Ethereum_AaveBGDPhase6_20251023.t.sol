// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {AaveV3Ethereum_AaveBGDPhase6_20251023} from './AaveV3Ethereum_AaveBGDPhase6_20251023.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveBGDPhase6_20251023
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251023_AaveV3Ethereum_AaveBGDPhase6/AaveV3Ethereum_AaveBGDPhase6_20251023.t.sol -vv
 */
contract AaveV3Ethereum_AaveBGDPhase6_20251023_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveBGDPhase6_20251023 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23696816);
    proposal = new AaveV3Ethereum_AaveBGDPhase6_20251023();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_AaveBGDPhase6_20251023', AaveV3Ethereum.POOL, address(proposal));
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

    assertApproxEqAbs(aUsdcBalanceAfter - aUsdcBalanceBefore, 1_320_000e6, 1);
    assertEq(aaveBalanceAfter - aaveBalanceBefore, 1_800e18);
  }

  function test_streamAmounts() public {
    address receiverAddress = proposal.BGD_RECEIVER();
    IStreamable ecosystemReserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);

    uint256 streamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 streamIdAave = ecosystemReserve.getNextStreamId();

    uint256 streamsDuration = proposal.STOP_TIME() - block.timestamp;
    uint256 aGhoStreamed = (880_000e6 / streamsDuration) * streamsDuration;
    uint256 AAVEStreamed = (1_200e18 / streamsDuration) * streamsDuration;

    executePayload(vm, address(proposal));

    // Warping after end of stream
    vm.warp(proposal.STOP_TIME() + 1);
    vm.startPrank(receiverAddress);

    uint256 aGhoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      receiverAddress
    );
    uint256 aaveBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      receiverAddress
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      streamId,
      AaveV3Ethereum.COLLECTOR.balanceOf(streamId, receiverAddress)
    );
    ecosystemReserve.withdrawFromStream(
      streamIdAave,
      ecosystemReserve.balanceOf(streamIdAave, receiverAddress)
    );

    uint256 aGhoBalanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      receiverAddress
    );
    uint256 aaveBalanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      receiverAddress
    );

    assertApproxEqAbs(aGhoBalanceAfter, aGhoBalanceBefore + aGhoStreamed, 1);
    assertEq(aaveBalanceAfter, aaveBalanceBefore + AAVEStreamed);
  }
}
