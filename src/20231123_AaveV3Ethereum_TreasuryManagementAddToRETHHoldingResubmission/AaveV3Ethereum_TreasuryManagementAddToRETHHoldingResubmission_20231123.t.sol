// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import {AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123} from './AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123.sol';

/**
 * @dev Test for AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123
 * command: make test-contract filter=AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123
 */
contract AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123_Test is
  ProtocolV3TestBase
{
  event SwapRequested(
    address milkman,
    address indexed fromToken,
    address indexed toToken,
    address fromOracle,
    address toOracle,
    uint256 amount,
    address indexed recipient,
    uint256 slippage
  );

  AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123 internal proposal;
  address internal collector = address(AaveV3Ethereum.COLLECTOR);
  address internal swapProxy = 0x7cf1595c4737Ae797eb2c66C874b423fc5919D55;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18720858);

    proposal = new AaveV3Ethereum_TreasuryManagementAddToRETHHoldingResubmission_20231123();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 collectorWethBalanceBefore = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      collector
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.rETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_ORACLE,
      proposal.RETH_ORACLE(),
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    executePayload(vm, address(proposal));

    uint256 collectorWethBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      collector
    );
    uint256 swapProxyWethBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      swapProxy
    );

    assertEq(collectorWethBalanceAfter, 0);
    assertEq(swapProxyWethBalanceAfter, collectorWethBalanceBefore);
  }
}
