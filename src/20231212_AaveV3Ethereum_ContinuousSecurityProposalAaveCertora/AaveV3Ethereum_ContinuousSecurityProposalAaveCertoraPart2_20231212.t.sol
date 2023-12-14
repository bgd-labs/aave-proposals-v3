// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets, ICollector} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212} from './AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {BaseCertoraTest} from './BaseCertoraTest.t.sol';

/**
 * @dev Test for AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212
 * command: make test-contract filter=AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212
 */
contract AaveV3Ethereum_ContinuousSecurityProposalAaveCertoraPart2_20231212_Test is
  ProtocolV3TestBase,
  BaseCertoraTest
{
  address public constant CERTORA_TREASURY = 0x0F11640BF66e2D9352d9c41434A5C6E597c5e4c8;
  uint256 public constant AAVE_STREAM_AMOUNT = 5_200 ether;
  uint256 public constant STREAM_DURATION = 270 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_AAVE =
    (AAVE_STREAM_AMOUNT / STREAM_DURATION) * STREAM_DURATION;

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 nextReserveStreamIDAAVE = ICollector(MiscEthereum.ECOSYSTEM_RESERVE).getNextStreamId();
    uint256 CERTORAAAVEBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      CERTORA_TREASURY
    );

    uint256 ReserveAAVEBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      MiscEthereum.ECOSYSTEM_RESERVE
    );

    execute();
    // Checking if the streams have been created properly
    // scoping to avoid the "stack too deep" error
    {
      (
        address senderAAVE,
        address recipientAAVE,
        uint256 depositAAVE,
        address tokenAddressAAVE,
        uint256 startTimeAAVE,
        uint256 stopTimeAAVE,
        uint256 remainingBalanceAAVE,

      ) = ICollector(MiscEthereum.ECOSYSTEM_RESERVE).getStream(nextReserveStreamIDAAVE);
      assertEq(senderAAVE, MiscEthereum.ECOSYSTEM_RESERVE);
      assertEq(recipientAAVE, CERTORA_TREASURY);
      assertEq(depositAAVE, ACTUAL_STREAM_AMOUNT_AAVE);
      assertEq(tokenAddressAAVE, AaveV3EthereumAssets.AAVE_UNDERLYING);
      assertEq(stopTimeAAVE - startTimeAAVE, STREAM_DURATION);
      assertEq(remainingBalanceAAVE, ACTUAL_STREAM_AMOUNT_AAVE);
    }
    vm.startPrank(CERTORA_TREASURY);
    vm.warp(block.timestamp + STREAM_DURATION + 1 days);

    ICollector(MiscEthereum.ECOSYSTEM_RESERVE).withdrawFromStream(
      nextReserveStreamIDAAVE,
      ACTUAL_STREAM_AMOUNT_AAVE
    );
    uint256 nextCERTORAAAVEBalance = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      CERTORA_TREASURY
    );

    assertEq(CERTORAAAVEBalanceBefore, nextCERTORAAAVEBalance - ACTUAL_STREAM_AMOUNT_AAVE);

    // Check Collector balance after stream withdrawal

    uint256 ReserveAAVEBalanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      MiscEthereum.ECOSYSTEM_RESERVE
    );

    assertEq(ReserveAAVEBalanceAfter, ReserveAAVEBalanceBefore - ACTUAL_STREAM_AMOUNT_AAVE);

    vm.stopPrank();
  }
}
