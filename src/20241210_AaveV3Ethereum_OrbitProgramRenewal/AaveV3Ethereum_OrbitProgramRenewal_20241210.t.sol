// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OrbitProgramRenewal_20241210} from './AaveV3Ethereum_OrbitProgramRenewal_20241210.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {OrbitProgramRenewalData} from './AaveV3Ethereum_OrbitProgramRenewalData_20241210.sol';

/**
 * @dev Test for AaveV3Ethereum_OrbitProgramRenewal_20241210
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241210_AaveV3Ethereum_OrbitProgramRenewal/AaveV3Ethereum_OrbitProgramRenewal_20241210.t.sol -vv
 */
contract AaveV3Ethereum_OrbitProgramRenewal_20241210_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OrbitProgramRenewal_20241210 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21371374);
    proposal = new AaveV3Ethereum_OrbitProgramRenewal_20241210();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OrbitProgramRenewal_20241210',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_wholeProcess() public {
    uint256 maxDeltaStreamBalance = 0.001e18; // 0.1%

    uint256[] memory ghoBalancesBeforeUsers = new uint256[](4);
    address[] memory ghoPaymentAddresses = OrbitProgramRenewalData.getOrbitAddresses();
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      ghoBalancesBeforeUsers[i] = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        ghoPaymentAddresses[i]
      );
    }

    uint256 nextStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    // Direct transfers
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      assertEq(
        IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i] + OrbitProgramRenewalData.DIRECT_TRANSFER_AMOUNT,
        'GHO balance of Orbit recipient is not greater than before'
      );
    }

    vm.warp(block.timestamp + 80 days);

    // Stream transfers
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      uint256 finalBalanceToWithdraw = AaveV3Ethereum.COLLECTOR.balanceOf(
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
      AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextStreamId + i, finalBalanceToWithdraw);
      assertApproxEqRel(
        IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i] +
          OrbitProgramRenewalData.DIRECT_TRANSFER_AMOUNT +
          OrbitProgramRenewalData.STREAM_AMOUNT,
        maxDeltaStreamBalance,
        'GHO Stream final withdraw is not correct'
      );
    }
  }

  function test_directTransfer() public {
    uint256[] memory ghoBalancesBeforeUsers = new uint256[](4);
    address[] memory ghoPaymentAddresses = OrbitProgramRenewalData.getOrbitAddresses();
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      ghoBalancesBeforeUsers[i] = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        ghoPaymentAddresses[i]
      );
    }

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      assertEq(
        IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i] + OrbitProgramRenewalData.DIRECT_TRANSFER_AMOUNT,
        'GHO balance of Orbit recipient is not greater than before'
      );
    }
  }

  function test_streamBalance() public {
    address[] memory ghoPaymentAddresses = OrbitProgramRenewalData.getOrbitAddresses();

    uint256 nextStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 1 days);

    /// Their GHO balance has increased and call also withdraw from stream as it now exists
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      uint256 ghoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        ghoPaymentAddresses[i]
      );

      vm.prank(ghoPaymentAddresses[i]);
      AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextStreamId + i, 1);

      uint256 ghoBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        ghoPaymentAddresses[i]
      );

      assertEq(ghoBalanceAfter, ghoBalanceBefore + 1);
    }
  }

  function test_streamEndBalance() public {
    uint256 maxDeltaStreamBalance = 0.001e18; // 0.1%

    address[] memory ghoPaymentAddresses = OrbitProgramRenewalData.getOrbitAddresses();

    uint256 nextStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 80 days);

    /// Their GHO balance has increased and call also withdraw from stream as it now exists
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      uint256 finalBalanceToWithdraw = AaveV3Ethereum.COLLECTOR.balanceOf(
        nextStreamId + i,
        ghoPaymentAddresses[i]
      );

      assertApproxEqRel(
        finalBalanceToWithdraw,
        OrbitProgramRenewalData.STREAM_AMOUNT,
        maxDeltaStreamBalance
      );

      uint256 ghoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        ghoPaymentAddresses[i]
      );

      vm.prank(ghoPaymentAddresses[i]);
      AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextStreamId + i, finalBalanceToWithdraw);

      uint256 ghoBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
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
