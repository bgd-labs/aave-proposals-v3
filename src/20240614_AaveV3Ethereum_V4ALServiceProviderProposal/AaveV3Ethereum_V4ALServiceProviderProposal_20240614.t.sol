// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_V4ALServiceProviderProposal_20240614} from './AaveV3Ethereum_V4ALServiceProviderProposal_20240614.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_V4ALServiceProviderProposal_20240614
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240614_AaveV3Ethereum_V4ALServiceProviderProposal/AaveV3Ethereum_V4ALServiceProviderProposal_20240614.t.sol -vv
 */
contract AaveV3Ethereum_V4ALServiceProviderProposal_20240614_Test is ProtocolV3TestBase {
  AaveV3Ethereum_V4ALServiceProviderProposal_20240614 internal proposal;

  // TODO: Determine appropriate Aave Labs address
  address public constant AAVE_LABS = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  uint256 public constant GHO_UPFRONT_AMOUNT = 3_000_000 ether;
  uint256 public constant GHO_STREAM_AMOUNT = 9_000_000 ether;
  uint256 public constant GHO_STREAM_DURATION = 365 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (GHO_STREAM_AMOUNT / GHO_STREAM_DURATION) * GHO_STREAM_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20092863);
    proposal = new AaveV3Ethereum_V4ALServiceProviderProposal_20240614();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_V4ALServiceProviderProposal_20240614',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function testProposalExecution() public {
    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 ALGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);

    // TODO: V2 Collector doesn't have enough funds, so need to get funds
    vm.prank(0x1a88Df1cFe15Af22B3c4c783D4e6F7F9e0C1885d);
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      3_000_000 ether
    );

    uint256 CollectorV3GHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
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

      ) = AaveV3Ethereum.COLLECTOR.getStream(nextCollectorStreamID);

      assertEq(senderGHO, address(AaveV3Ethereum.COLLECTOR));
      assertEq(recipientGHO, AAVE_LABS);
      assertEq(depositGHO, ACTUAL_STREAM_AMOUNT_GHO);
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, GHO_STREAM_DURATION);
      assertEq(remainingBalanceGHO, ACTUAL_STREAM_AMOUNT_GHO);
    }

    // checking if Aave Labs can withdraw from the stream

    vm.startPrank(AAVE_LABS);
    vm.warp(block.timestamp + GHO_STREAM_DURATION + 1 days);

    assertGe(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      ACTUAL_STREAM_AMOUNT_GHO
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, ACTUAL_STREAM_AMOUNT_GHO);
    uint256 nextALGHOBalance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(AAVE_LABS);

    assertEq(
      ALGHOBalanceBefore,
      nextALGHOBalance - (ACTUAL_STREAM_AMOUNT_GHO + GHO_UPFRONT_AMOUNT)
    );

    // Check Collector balance after stream withdrawal

    uint256 CollectorV3GHOBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(
      CollectorV3GHOBalanceAfter,
      CollectorV3GHOBalanceBefore - (ACTUAL_STREAM_AMOUNT_GHO + GHO_UPFRONT_AMOUNT)
    );

    vm.stopPrank();
  }
}
