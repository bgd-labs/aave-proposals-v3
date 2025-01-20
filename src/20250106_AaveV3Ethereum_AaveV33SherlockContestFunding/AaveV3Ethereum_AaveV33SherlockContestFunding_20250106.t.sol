// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AaveV33SherlockContestFunding_20250106} from './AaveV3Ethereum_AaveV33SherlockContestFunding_20250106.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveV33SherlockContestFunding_20250106
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250106_AaveV3Ethereum_AaveV33SherlockContestFunding/AaveV3Ethereum_AaveV33SherlockContestFunding_20250106.t.sol -vv
 */
contract AaveV3Ethereum_AaveV33SherlockContestFunding_20250106_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveV33SherlockContestFunding_20250106 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21566088);
    proposal = new AaveV3Ethereum_AaveV33SherlockContestFunding_20250106();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AaveV33SherlockContestFunding_20250106',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_consistentBalances() public {
    uint256 collectorAUSDCBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 bgdUSDCBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 sherlockUSDCBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      proposal.SHERLOCK_RECIPIENT()
    );

    executePayload(vm, address(proposal));

    uint256 collectorAUSDCBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 bgdUSDCBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      proposal.BGD_RECIPIENT()
    );
    uint256 sherlockUSDCBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      proposal.SHERLOCK_RECIPIENT()
    );

    uint256 totalAmount = proposal.BGD_USDC_AMOUNT() + proposal.SHERLOCK_USDC_AMOUNT();

    assertApproxEqAbs(collectorAUSDCBalanceAfter, collectorAUSDCBalanceBefore - totalAmount, 1); // due to interest accrued

    assertEq(bgdUSDCBalanceAfter, bgdUSDCBalanceBefore + proposal.BGD_USDC_AMOUNT());
    assertEq(sherlockUSDCBalanceAfter, sherlockUSDCBalanceBefore + proposal.SHERLOCK_USDC_AMOUNT());
  }
}
