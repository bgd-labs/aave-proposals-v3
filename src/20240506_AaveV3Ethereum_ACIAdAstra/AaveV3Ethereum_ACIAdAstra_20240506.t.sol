// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ACIAdAstra_20240506} from './AaveV3Ethereum_ACIAdAstra_20240506.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_ACIAdAstra_20240506
 * command: make test-contract filter=AaveV3Ethereum_ACIAdAstra_20240506
 */
contract AaveV3Ethereum_ACIAdAstra_20240506_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ACIAdAstra_20240506 internal proposal;

  address public constant ACI_MULTISIG = 0xac140648435d03f784879cd789130F22Ef588Fcd;
  uint256 public constant GHO_UPFRONT_AMOUNT = 16_440 ether;
  uint256 public constant GHO_STREAM_AMOUNT = 1_000_000 ether;
  uint256 public constant GHO_STREAM_DURATION = 365 days;
  uint256 public constant ACTUAL_STREAM_AMOUNT_GHO =
    (GHO_STREAM_AMOUNT / GHO_STREAM_DURATION) * GHO_STREAM_DURATION;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19809883);
    proposal = new AaveV3Ethereum_ACIAdAstra_20240506();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_ACIAdAstra_20240506', AaveV3Ethereum.POOL, address(proposal));
  }

  function testProposalExecution() public {
    uint256 nextCollectorStreamID = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    uint256 ACIGHOBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      ACI_MULTISIG
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
      assertEq(recipientGHO, ACI_MULTISIG);
      assertEq(depositGHO, ACTUAL_STREAM_AMOUNT_GHO);
      assertEq(tokenAddressGHO, AaveV3EthereumAssets.GHO_UNDERLYING);
      assertEq(stopTimeGHO - startTimeGHO, GHO_STREAM_DURATION);
      assertEq(remainingBalanceGHO, ACTUAL_STREAM_AMOUNT_GHO);
    }

    // checking if the ACI can withdraw from the stream

    vm.startPrank(ACI_MULTISIG);
    vm.warp(block.timestamp + GHO_STREAM_DURATION + 1 days);

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextCollectorStreamID, ACTUAL_STREAM_AMOUNT_GHO);
    uint256 nextACIGHOBalance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(ACI_MULTISIG);

    assertEq(
      ACIGHOBalanceBefore,
      nextACIGHOBalance - (ACTUAL_STREAM_AMOUNT_GHO + GHO_UPFRONT_AMOUNT)
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
