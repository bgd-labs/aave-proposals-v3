// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123} from './AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123
 * command: make test-contract filter=AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123
 */
contract AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123 internal proposal;
  address internal collector = address(AaveV3Ethereum.COLLECTOR);
  address internal swapProxy = 0xD1Fe23ADd41021E473f558B6D465c447a89f1759;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18636345);

    // collector has no weth, lets give it some
    vm.deal(collector, 1 ether);
    vm.prank(collector);
    payable(AaveV3EthereumAssets.WETH_UNDERLYING).call{value: 1 ether}("");

    proposal = new AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 collectorWethBalanceBefore = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(collector);

    executePayload(vm, address(proposal));

    uint256 collectorWethBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(collector);
    uint256 swapProxyWethBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(swapProxy);
    
    assertEq(collectorWethBalanceAfter, 0);
    assertEq(swapProxyWethBalanceAfter, collectorWethBalanceBefore);
  }
}
