// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103} from './AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103.sol';

/**
 * @dev Test for AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103
 * command: make test-contract filter=AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103
 */
contract AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103_Test is ProtocolV3TestBase {
  AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103 internal proposal;
  address internal collector = address(AaveV3Ethereum.COLLECTOR);
  address internal swapProxy = 0x29491c1E89dab8F90Af1D25dE6ebf284Ef367291;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18571429);
    proposal = AaveV3Ethereum_TreasuryManagementAddToRETHHolding_20231103(0xB08b75BaAC19FAcd43e643af10B35E5cA3527F5F);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 collectorWethBalanceBefore = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(collector);
    uint256 collectorAwethv2BalanceBefore = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(collector);
    uint256 collectorAwethv3BalanceBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(collector);
    uint256 expectedWeth = 
      collectorWethBalanceBefore + collectorAwethv2BalanceBefore + collectorAwethv3BalanceBefore - 100 ether;
    executePayload(vm, address(proposal));
    uint256 collectorWethBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(collector);
    uint256 swapProxyWethBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(swapProxy);
    uint256 collectorAwethv2BalanceAfter = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(collector);
    uint256 collectorAwethv3BalanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(collector);
    
    assertEq(collectorWethBalanceAfter, 0);
    assertEq(swapProxyWethBalanceAfter, expectedWeth);
    assertLe(collectorAwethv2BalanceAfter, 1e17);
    assertLe(collectorAwethv3BalanceAfter, 100 ether + 1e17);
  }
}
