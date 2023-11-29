// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GauntletAaveRenewal2023_20231128} from './AaveV3Ethereum_GauntletAaveRenewal2023_20231128.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @dev Test for AaveV3Ethereum_GauntletAaveRenewal2023_20231128
 * command: make test-contract filter=AaveV3Ethereum_GauntletAaveRenewal2023_20231128
 */
contract AaveV3Ethereum_GauntletAaveRenewal2023_20231128_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GauntletAaveRenewal2023_20231128 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18679448);
    proposal = new AaveV3Ethereum_GauntletAaveRenewal2023_20231128();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GauntletAaveRenewal2023_20231128',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  /**
   * @dev executes tests specific for the payment proposal
   */
  function test_proposalPayments() public {
    // check insolvency refund
    // check each stream
    // check can claim at a known time
    // check can claim after a year
    uint256 USDT_STREAM_ID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 GHO_STREAM_ID = USDT_STREAM_ID + 1;

    uint256 GauntletAUSDTBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.GAUNTLET_STREAMING_BENEFICIARY()
    );

    uint256 GauntletGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.GAUNTLET_STREAMING_BENEFICIARY()
    );

    uint256 InsolvencyAUSDTBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.GAUNTLET_INSOLVENCY_REFUND()
    );

    // Set approx time of proposal submission
    executePayload(vm, address(proposal));

    uint256 InsolvencyAUSDTBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.GAUNTLET_INSOLVENCY_REFUND()
    );

    // Check insolvency refund amount
    assertEq(
      InsolvencyAUSDTBalanceAfter - InsolvencyAUSDTBalanceBefore,
      proposal.INSOLVENCY_REFUND_AMOUNT_USDT()
    );

    // Approximate end time for sanity checks
    // Sat Dec 14 2024 08:00:00 GMT+0000
    uint256 approxEnd = 1734163200;

    // Check GHO stream
    {
      (
        address senderGHO,
        address recipientGHO,
        uint256 depositGHO,
        address tokenAddressGHO,
        uint256 startTimeGHO,
        uint256 stopTimeGHO,
        uint256 remainingBalanceGHO,

      ) = AaveV3Ethereum.COLLECTOR.getStream(GHO_STREAM_ID);

      assertEq(senderGHO, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientGHO, proposal.GAUNTLET_STREAMING_BENEFICIARY());
      assertEq(depositGHO, proposal.ACTUAL_GAUNTLET_STREAM_AMOUNT_GHO());
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, proposal.STREAM_DURATION());
      assertEq(remainingBalanceGHO, proposal.ACTUAL_GAUNTLET_STREAM_AMOUNT_GHO());

      assertApproxEqAbs(stopTimeGHO, approxEnd, 31 days);
    }

    // Check aUSDT stream
    {
      (
        address senderAUSDT,
        address recipientAUSDT,
        uint256 depositAUSDT,
        address tokenAddressAUSDT,
        uint256 startTimeAUSDT,
        uint256 stopTimeAUSDT,
        uint256 remainingBalanceAUSDT,

      ) = AaveV3Ethereum.COLLECTOR.getStream(USDT_STREAM_ID);

      assertEq(senderAUSDT, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientAUSDT, proposal.GAUNTLET_STREAMING_BENEFICIARY());
      assertEq(depositAUSDT, proposal.ACTUAL_GAUNTLET_STREAM_AMOUNT_USDT());
      assertEq(tokenAddressAUSDT, AaveV2EthereumAssets.USDT_A_TOKEN);
      assertEq(stopTimeAUSDT - startTimeAUSDT, proposal.STREAM_DURATION());
      assertEq(remainingBalanceAUSDT, proposal.ACTUAL_GAUNTLET_STREAM_AMOUNT_USDT());

      assertApproxEqAbs(stopTimeAUSDT, approxEnd, 31 days);
    }

    // Check withdrawing from stream
    vm.startPrank(proposal.GAUNTLET_STREAMING_BENEFICIARY());
    vm.warp(block.timestamp + 366 days);

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      GHO_STREAM_ID,
      proposal.ACTUAL_GAUNTLET_STREAM_AMOUNT_GHO()
    );
    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      USDT_STREAM_ID,
      proposal.ACTUAL_GAUNTLET_STREAM_AMOUNT_USDT()
    );

    uint256 GauntletGHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.GAUNTLET_STREAMING_BENEFICIARY()
    );
    uint256 GauntletAUSDTBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      proposal.GAUNTLET_STREAMING_BENEFICIARY()
    );

    uint256 GauntletGHOBalanceChange = GauntletGHOBalanceAfter - GauntletGHOBalanceBefore;
    uint256 GauntletAUSDTBalanceChange = GauntletAUSDTBalanceAfter - GauntletAUSDTBalanceBefore;

    console.log('Gauntlet GHO Balance Change           ', GauntletGHOBalanceChange);
    console.log('Gauntlet aUSDT Balance Change         ', GauntletAUSDTBalanceChange);
    console.log(
      'Insolvency Refund aUSDT Balance Change',
      InsolvencyAUSDTBalanceAfter - InsolvencyAUSDTBalanceBefore
    );

    console.log(
      'GHO Remaining in Collector            ',
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    console.log(
      'aUSDT Remaining in Collector          ',
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );

    assertEq(GauntletGHOBalanceChange, proposal.ACTUAL_GAUNTLET_STREAM_AMOUNT_GHO());
    assertEq(GauntletAUSDTBalanceChange, proposal.ACTUAL_GAUNTLET_STREAM_AMOUNT_USDT());
  }
}
