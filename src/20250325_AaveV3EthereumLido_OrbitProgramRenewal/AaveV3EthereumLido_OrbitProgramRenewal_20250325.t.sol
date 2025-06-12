// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OrbitProgramRenewal_20250325} from './AaveV3EthereumLido_OrbitProgramRenewal_20250325.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {OrbitProgramRenewalData} from './OrbitProgramRenewalData.sol';

/**
 * @dev Test for AaveV3EthereumLido_OrbitProgramRenewal_20250325
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250325_AaveV3EthereumLido_OrbitProgramRenewal/AaveV3EthereumLido_OrbitProgramRenewal_20250325.t.sol -vv
 */
contract AaveV3EthereumLido_OrbitProgramRenewal_20250325_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_OrbitProgramRenewal_20250325 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22124480);
    proposal = new AaveV3EthereumLido_OrbitProgramRenewal_20250325();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OrbitProgramRenewal_20250325',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_wholeProcess() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%

    uint256[] memory ghoBalancesBeforeUsers = new uint256[](4);
    address[] memory ghoPaymentAddresses = OrbitProgramRenewalData.getOrbitAddresses();
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      ghoBalancesBeforeUsers[i] = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
        ghoPaymentAddresses[i]
      );
    }

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 91 days);

    uint256[] memory aGHOInterest = new uint256[](4);
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      aGHOInterest[i] =
        IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(ghoPaymentAddresses[i]) -
        ghoBalancesBeforeUsers[i];
    }
    // Stream transfers
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      uint256 finalBalanceToWithdraw = AaveV3EthereumLido.COLLECTOR.balanceOf(
        nextStreamId + i,
        ghoPaymentAddresses[i]
      );

      assertApproxEqRel(
        finalBalanceToWithdraw,
        OrbitProgramRenewalData.STREAM_AMOUNT,
        maxDeltaStreamBalance,
        'GHO Stream final balance is not correct'
      );

      vm.prank(ghoPaymentAddresses[i]);
      AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId + i, finalBalanceToWithdraw);
      assertApproxEqRel(
        IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i] + OrbitProgramRenewalData.STREAM_AMOUNT + aGHOInterest[i],
        maxDeltaStreamBalance,
        'GHO Stream final withdraw is not correct'
      );
    }
  }

  function test_directTransfer() public {
    uint256[] memory ghoBalancesBeforeUsers = new uint256[](4);
    address[] memory ghoPaymentAddresses = OrbitProgramRenewalData.getOrbitAddresses();
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      ghoBalancesBeforeUsers[i] = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
        ghoPaymentAddresses[i]
      );
    }

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      assertEq(
        IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i],
        'GHO balance of Orbit recipient is not greater than before'
      );
    }
  }

  function test_streamBalance() public {
    address[] memory ghoPaymentAddresses = OrbitProgramRenewalData.getOrbitAddresses();

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 1 days);

    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      uint256 ghoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
        ghoPaymentAddresses[i]
      );

      vm.prank(ghoPaymentAddresses[i]);
      AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId + i, 1);

      uint256 ghoBalanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
        ghoPaymentAddresses[i]
      );

      assertEq(ghoBalanceAfter, ghoBalanceBefore + 1);
    }
  }

  function test_streamEndBalance() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%

    address[] memory ghoPaymentAddresses = OrbitProgramRenewalData.getOrbitAddresses();

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 91 days);

    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      uint256 finalBalanceToWithdraw = AaveV3EthereumLido.COLLECTOR.balanceOf(
        nextStreamId + i,
        ghoPaymentAddresses[i]
      );

      assertApproxEqRel(
        finalBalanceToWithdraw,
        OrbitProgramRenewalData.STREAM_AMOUNT,
        maxDeltaStreamBalance
      );

      uint256 ghoBalanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
        ghoPaymentAddresses[i]
      );

      vm.prank(ghoPaymentAddresses[i]);
      AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId + i, finalBalanceToWithdraw);

      uint256 ghoBalanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
        ghoPaymentAddresses[i]
      );

      assertApproxEqRel(
        ghoBalanceAfter,
        ghoBalanceBefore + OrbitProgramRenewalData.STREAM_AMOUNT,
        maxDeltaStreamBalance
      );
    }
  }
}
