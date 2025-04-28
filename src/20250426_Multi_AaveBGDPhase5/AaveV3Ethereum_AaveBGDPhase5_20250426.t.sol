// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AaveBGDPhase5_20250426} from './AaveV3Ethereum_AaveBGDPhase5_20250426.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveBGDPhase5_20250426
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250426_Multi_AaveBGDPhase5/AaveV3Ethereum_AaveBGDPhase5_20250426.t.sol -vv
 */
contract AaveV3Ethereum_AaveBGDPhase5_20250426_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveBGDPhase5_20250426 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22365609);
    proposal = new AaveV3Ethereum_AaveBGDPhase5_20250426();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.evm_version = 'cancun'
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_AaveBGDPhase5_20250426', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_upfrontAmounts() public {
    address receiverAddress = proposal.BGD_RECEIVER();
    uint256 aUsdtBalanceBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      receiverAddress
    );
    uint256 aaveBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      receiverAddress
    );

    executePayload(vm, address(proposal));

    uint256 aUsdtBalanceAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      receiverAddress
    );
    uint256 aaveBalanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      receiverAddress
    );

    assertApproxEqAbs(aUsdtBalanceAfter - aUsdtBalanceBefore, 1_150_000e6, 1);
    assertEq(aaveBalanceAfter - aaveBalanceBefore, 2_000e18);
  }

  function test_streamAmounts() public {
    address receiverAddress = proposal.BGD_RECEIVER();
    IStreamable ecosystemReserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);

    uint256 streamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 streamIdAave = ecosystemReserve.getNextStreamId();

    uint256 streamsDuration = proposal.STOP_TIME() - block.timestamp;
    uint256 aGHOStreamed = (1_150_000e18 / streamsDuration) * streamsDuration;
    uint256 AAVEStreamed = (2000e18 / streamsDuration) * streamsDuration;

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

    assertApproxEqAbs(aGhoBalanceAfter, aGhoBalanceBefore + aGHOStreamed, 1);
    assertEq(aaveBalanceAfter, aaveBalanceBefore + AAVEStreamed);
  }
}
