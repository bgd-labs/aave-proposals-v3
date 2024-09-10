// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OrbitProgramRenewalQ32024_20240905} from './AaveV3Ethereum_OrbitProgramRenewalQ32024_20240905.sol';

import {OrbitProgramData} from './OrbitProgramData.sol';
/**
 * @dev Test for AaveV3Ethereum_OrbitProgramRenewalQ32024_20240905
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240905_AaveV3Ethereum_OrbitProgramRenewalQ32024/AaveV3Ethereum_OrbitProgramRenewalQ32024_20240905.t.sol -vv
 */
contract AaveV3Ethereum_OrbitProgramRenewalQ32024_20240905_Test is ProtocolV3TestBase {
  AaveV3Ethereum_OrbitProgramRenewalQ32024_20240905 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20685166);
    proposal = new AaveV3Ethereum_OrbitProgramRenewalQ32024_20240905();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 collectorWethBalanceBefore = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256[] memory ethBalancesBeforeUsers = new uint256[](3);
    OrbitProgramData.GasUsage[] memory usage = OrbitProgramData.getGasUsageData();
    for (uint256 i = 0; i < usage.length; i++) {
      ethBalancesBeforeUsers[i] = usage[i].account.balance;
    }

    uint256[] memory ghoBalancesBeforeUsers = new uint256[](4);
    address[] memory ghoPaymentAddresses = OrbitProgramData.getOrbitAddresses();
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      ghoBalancesBeforeUsers[i] = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        ghoPaymentAddresses[i]
      );
    }

    uint256 nextStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorWethBalanceBefore - OrbitProgramData.TOTAL_WETH_REBATE,
      'WETH balance of Collector is not equal to previous minus to withdraw'
    );

    for (uint256 i = 0; i < usage.length; i++) {
      assertGt(
        usage[i].account.balance,
        ethBalancesBeforeUsers[i],
        'REBATE recipient balance is not greater than before'
      );
    }

    vm.warp(block.timestamp + 7 days);

    /// Their GHO balance has increased and call also withdraw from stream as it now exists
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      assertEq(
        IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i] + OrbitProgramData.OVERDUE_AMOUNT,
        'GHO balance of Orbit recipient is not greater than before'
      );

      vm.prank(ghoPaymentAddresses[i]);
      AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextStreamId + i, 1);
      assertEq(
        IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i] + OrbitProgramData.OVERDUE_AMOUNT + 1
      );
    }
  }
}
