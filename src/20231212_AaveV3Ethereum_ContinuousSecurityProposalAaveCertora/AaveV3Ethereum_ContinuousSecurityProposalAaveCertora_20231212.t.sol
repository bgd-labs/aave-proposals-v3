// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets, ICollector} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212} from './AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212
 * command: make test-contract filter=AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212
 */
contract AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212 internal proposal;

  address public constant CERTORA_TREASURY = 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8;
  uint256 public constant GHO_STREAM_AMOUNT = 1_000_000 ether;
  uint256 public constant AAVE_STREAM_AMOUNT = 5_200 ether;
  uint256 public constant STREAM_DURATION = 270 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (GHO_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;
  uint256 public constant ACTUAL_STREAM_AMOUNT_AAVE =
    (AAVE_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18778078);
    proposal = new AaveV3Ethereum_ContinuousSecurityProposalAaveCertora_20231212();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 nextCollectorStreamIDGHO = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 nextReserveStreamIDAAVE = ICollector(MiscEthereum.ECOSYSTEM_RESERVE).getNextStreamId();
    uint256 CERTORAGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      CERTORA_TREASURY
    );
    uint256 CERTORAAAVEBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      CERTORA_TREASURY
    );

    uint256 CollectorV3GHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 ReserveAAVEBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      address(MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER)
    );

    executePayload(vm, address(proposal));
    // Checking if the streams have been created properly
    // scoping to avoid the "stack too deep" error
    {
      (
        address senderGHO,
        address recipientGHO,
        uint256 depositGHO,
        address tokenAddressGHO,
        uint256 startTimeGHO,
        uint256 stopTimeGHO,
        uint256 remainingBalanceGHO,

      ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamIDGHO);
      assertEq(senderGHO, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientGHO, CERTORA_TREASURY);
      assertEq(depositGHO, ACTUAL_STREAM_AMOUNT_GHO);
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, STREAM_DURATION);
      assertEq(remainingBalanceGHO, ACTUAL_STREAM_AMOUNT_GHO);
    }
    {
      (
        address senderAAVE,
        address recipientAAVE,
        uint256 depositAAVE,
        address tokenAddressAAVE,
        uint256 startTimeAAVE,
        uint256 stopTimeAAVE,
        uint256 remainingBalanceAAVE,

      ) = ICollector(address(MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER)).getStream(
          nextReserveStreamIDAAVE
        );
      assertEq(senderAAVE, address(MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER));
      assertEq(recipientAAVE, CERTORA_TREASURY);
      assertEq(depositAAVE, ACTUAL_STREAM_AMOUNT_AAVE);
      assertEq(tokenAddressAAVE, AaveV3EthereumAssets.AAVE_UNDERLYING);
      assertEq(stopTimeAAVE - startTimeAAVE, STREAM_DURATION);
      assertEq(remainingBalanceAAVE, ACTUAL_STREAM_AMOUNT_AAVE);
    }
    vm.startPrank(CERTORA_TREASURY);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);

    // GHO stream

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamIDGHO, ACTUAL_STREAM_AMOUNT_GHO);
    uint256 nextCERTORAGHOBalance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      CERTORA_TREASURY
    );

    assertEq(CERTORAGHOBalanceBefore, nextCERTORAGHOBalance - ACTUAL_STREAM_AMOUNT_GHO);

    // Check Collector balance after stream withdrawal

    uint256 CollectorV3GHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(CollectorV3GHOBalanceAfter, CollectorV3GHOBalanceBefore - ACTUAL_STREAM_AMOUNT_GHO);

    // AAVE stream

    MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER.withdrawFromStream(
      address(MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER),
      nextReserveStreamIDAAVE,
      ACTUAL_STREAM_AMOUNT_AAVE
    );
    uint256 nextCERTORAAAVEBalance = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      CERTORA_TREASURY
    );

    assertEq(CERTORAAAVEBalanceBefore, nextCERTORAAAVEBalance - ACTUAL_STREAM_AMOUNT_AAVE);

    // Check Collector balance after stream withdrawal

    uint256 ReserveAAVEBalanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      address(MiscEthereum.AAVE_ECOSYSTEM_RESERVE_CONTROLLER)
    );

    assertEq(ReserveAAVEBalanceAfter, ReserveAAVEBalanceBefore - ACTUAL_STREAM_AMOUNT_AAVE);

    vm.stopPrank();
  }
}
