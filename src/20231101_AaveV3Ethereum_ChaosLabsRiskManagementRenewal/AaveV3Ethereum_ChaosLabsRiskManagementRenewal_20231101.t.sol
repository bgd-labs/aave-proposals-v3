// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ChaosLabsRiskManagementRenewal_20231101} from './AaveV3Ethereum_ChaosLabsRiskManagementRenewal_20231101.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_ChaosLabsRiskManagementRenewal_20231101
 * command: make test-contract filter=AaveV3Ethereum_ChaosLabsRiskManagementRenewal_20231101
 */
contract AaveV3Ethereum_ChaosLabsRiskManagementRenewal_20231101_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ChaosLabsRiskManagementRenewal_20231101 internal proposal;

  address public constant CHAOS_LABS_TREASURY = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;
  uint256 public constant STREAM_AMOUNT_GHO = 800_000 ether;
  uint256 public constant STREAM_AMOUNT_AUSDT = 800_000e6;
  uint256 public constant STREAM_DURATION = 365 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (STREAM_AMOUNT_GHO / STREAM_DURATION) * STREAM_DURATION;
  uint256 public constant ACTUAL_STREAM_AMOUNT_AUSDT =
    (STREAM_AMOUNT_AUSDT / STREAM_DURATION) * STREAM_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18479493);
    proposal = new AaveV3Ethereum_ChaosLabsRiskManagementRenewal_20231101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ChaosLabsRiskManagementRenewal_20231101',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function testProposalExecution() public {
    uint256 GHOCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 AUSDTCollectorStreamID = GHOCollectorStreamID + 1;

    uint256 ChaosGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      CHAOS_LABS_TREASURY
    );
    uint256 ChaosAUSDTBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      CHAOS_LABS_TREASURY
    );

    executePayload(vm, address(proposal));

    {
      (
        address senderGHO,
        address recipientGHO,
        uint256 depositGHO,
        address tokenAddressGHO,
        uint256 startTimeGHO,
        uint256 stopTimeGHO,
        uint256 remainingBalanceGHO,

      ) = AaveV3Ethereum.COLLECTOR.getStream(GHOCollectorStreamID);

      assertEq(senderGHO, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientGHO, CHAOS_LABS_TREASURY);
      assertEq(depositGHO, ACTUAL_STREAM_AMOUNT_GHO);
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, STREAM_DURATION);
      assertEq(remainingBalanceGHO, ACTUAL_STREAM_AMOUNT_GHO);
    }

    {
      (
        address senderAUSDT,
        address recipientAUSDT,
        uint256 depositAUSDT,
        address tokenAddressAUSDT,
        uint256 startTimeAUSDT,
        uint256 stopTimeAUSDT,
        uint256 remainingBalanceAUSDT,

      ) = AaveV3Ethereum.COLLECTOR.getStream(AUSDTCollectorStreamID);

      assertEq(senderAUSDT, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientAUSDT, CHAOS_LABS_TREASURY);
      assertEq(depositAUSDT, ACTUAL_STREAM_AMOUNT_AUSDT);
      assertEq(tokenAddressAUSDT, AaveV2EthereumAssets.USDT_A_TOKEN);
      assertEq(stopTimeAUSDT - startTimeAUSDT, STREAM_DURATION);
      assertEq(remainingBalanceAUSDT, ACTUAL_STREAM_AMOUNT_AUSDT);
    }

    // checking if Chaos can withdraw from the stream

    vm.startPrank(CHAOS_LABS_TREASURY);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(GHOCollectorStreamID, ACTUAL_STREAM_AMOUNT_GHO);
    uint256 ChaosGHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      CHAOS_LABS_TREASURY
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(AUSDTCollectorStreamID, ACTUAL_STREAM_AMOUNT_AUSDT);
    uint256 ChaosAUSDTBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      CHAOS_LABS_TREASURY
    );

    assertEq(ChaosGHOBalanceBefore, ChaosGHOBalanceAfter - ACTUAL_STREAM_AMOUNT_GHO);
    assertEq(ChaosAUSDTBalanceBefore, ChaosAUSDTBalanceAfter - ACTUAL_STREAM_AMOUNT_AUSDT);

    vm.stopPrank();
  }
}
