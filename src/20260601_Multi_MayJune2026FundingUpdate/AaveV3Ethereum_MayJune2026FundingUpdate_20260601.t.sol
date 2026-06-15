// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IWithGuardian} from 'solidity-utils/contracts/access-control/UpgradeableOwnableWithGuardian.sol';

import {IMainnetSwapSteward} from 'src/interfaces/IMainnetSwapSteward.sol';

import {AaveV3Ethereum_MayJune2026FundingUpdate_20260601} from './AaveV3Ethereum_MayJune2026FundingUpdate_20260601.sol';

/**
 * @dev Test for AaveV3Ethereum_MayJune2026FundingUpdate_20260601
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260601_Multi_MayJune2026FundingUpdate/AaveV3Ethereum_MayJune2026FundingUpdate_20260601.t.sol -vv
 */
contract AaveV3Ethereum_MayJune2026FundingUpdate_20260601_Test is ProtocolV3TestBase {
  AaveV3Ethereum_MayJune2026FundingUpdate_20260601 internal proposal;

  uint256 internal constant EXPECTED_TOTAL_GHO_PAYMENTS = 9_350 ether; // 9350 GHO, 18 decimals

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25274433);
    proposal = new AaveV3Ethereum_MayJune2026FundingUpdate_20260601();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_MayJune2026FundingUpdate_20260601',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  /**
   * @dev The collector's ETH balance is wrapped to WETH and deposited into the V3 pool,
   *      increasing the collector's aWETH holdings by the wrapped amount.
   */
  function test_depositETH() public {
    uint256 collectorEthBalanceBefore = address(AaveV3Ethereum.COLLECTOR).balance;
    assertGt(collectorEthBalanceBefore, 0, 'collector should hold ETH to deposit');

    uint256 aWethBalanceBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    // All of the collector's ETH has been wrapped and deposited.
    assertEq(address(AaveV3Ethereum.COLLECTOR).balance, 0);

    uint256 aWethBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    // aTokens are minted ~1:1 with the deposited underlying.
    assertApproxEqAbs(
      aWethBalanceAfter,
      aWethBalanceBefore + collectorEthBalanceBefore,
      1,
      'aWETH not minted for the deposited ETH'
    );
  }

  /// ----------------------------------------------------------------------------
  /// Approvals
  /// ----------------------------------------------------------------------------

  function test_ahabAGhoAllowance() public {
    IERC20 token = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN);
    address spender = MiscEthereum.AHAB_SAFE;
    address collector = address(AaveV3Ethereum.COLLECTOR);
    uint256 allowance = proposal.AHAB_SAFE_A_GHO_ALLOWANCE();

    assertEq(token.allowance(collector, spender), 0, 'unexpected allowance before');

    executePayload(vm, address(proposal));

    assertEq(token.allowance(collector, spender), allowance, 'allowance not set');

    // Verify that funds can be pulled by the spender now.
    // Using a partial transfer because the collector does not have enough funds at the current block.
    uint256 spenderBalanceBefore = token.balanceOf(spender);
    uint256 transferAmount = allowance / 2;
    vm.prank(spender);
    token.transferFrom(collector, spender, transferAmount);

    assertApproxEqAbs(
      token.allowance(collector, spender),
      allowance - transferAmount,
      1,
      'allowance did not decrease'
    );
    assertApproxEqAbs(
      token.balanceOf(spender),
      spenderBalanceBefore + transferAmount,
      1,
      'spender did not receive tokens'
    );
  }

  function test_swapStewardWethTokenBudgetIncrease() public {
    _assertStewardTokenBudgetIncrease(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      proposal.SWAP_STEWARD_WETH_ALLOWANCE()
    );
  }

  function test_swapStewardUsdtTokenBudgetIncrease() public {
    _assertStewardTokenBudgetIncrease(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      proposal.SWAP_STEWARD_USDT_ALLOWANCE()
    );
  }

  function test_swapStewardUsdcTokenBudgetIncrease() public {
    _assertStewardTokenBudgetIncrease(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      proposal.SWAP_STEWARD_USDC_ALLOWANCE()
    );
  }

  function test_swapStewardUsdeTokenBudgetIncrease() public {
    _assertStewardTokenBudgetIncrease(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      proposal.SWAP_STEWARD_USDe_ALLOWANCE()
    );
  }

  function test_swapStewardUsdsTokenBudgetIncrease() public {
    _assertStewardTokenBudgetIncrease(
      AaveV3EthereumAssets.USDS_UNDERLYING,
      proposal.SWAP_STEWARD_USDS_ALLOWANCE()
    );
  }

  function test_swapStewardDaiTokenBudgetIncrease() public {
    _assertStewardTokenBudgetIncrease(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      proposal.SWAP_STEWARD_DAI_ALLOWANCE()
    );
  }

  /// ----------------------------------------------------------------------------
  /// Payments
  /// ----------------------------------------------------------------------------

  function test_tokenLogicAGhoPayment() public {
    address aGho = AaveV3EthereumLidoAssets.GHO_A_TOKEN;
    uint256 amount = proposal.TOKENLOGIC_A_GHO_PAYMENT_AMOUNT();

    uint256 receiverBefore = IERC20(aGho).balanceOf(proposal.TOKENLOGIC());

    executePayload(vm, address(proposal));

    // aGHO is a rebasing aToken, allow 1 wei of scaled-balance rounding.
    assertApproxEqAbs(
      IERC20(aGho).balanceOf(proposal.TOKENLOGIC()),
      receiverBefore + amount,
      1,
      'receiver balance mismatch'
    );
  }

  function test_aaveLabsAGhoPayment() public {
    address aGho = AaveV3EthereumLidoAssets.GHO_A_TOKEN;
    uint256 amount = proposal.AAVE_LABS_A_GHO_PAYMENT_AMOUNT();

    uint256 receiverBefore = IERC20(aGho).balanceOf(proposal.AAVE_LABS());

    executePayload(vm, address(proposal));

    // aGHO is a rebasing aToken, allow 1 wei of scaled-balance rounding.
    assertApproxEqAbs(
      IERC20(aGho).balanceOf(proposal.AAVE_LABS()),
      receiverBefore + amount,
      1,
      'receiver balance mismatch'
    );
  }

  function test_collectorTotalAGhoPayment() public {
    address collector = address(AaveV3Ethereum.COLLECTOR);
    address aGho = AaveV3EthereumLidoAssets.GHO_A_TOKEN;
    uint256 totalPayment = proposal.TOKENLOGIC_A_GHO_PAYMENT_AMOUNT() +
      proposal.AAVE_LABS_A_GHO_PAYMENT_AMOUNT();

    uint256 collectorBefore = IERC20(aGho).balanceOf(collector);

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(aGho).balanceOf(collector),
      collectorBefore - totalPayment,
      1,
      'collector aGHO did not drop by the payment amount'
    );
  }

  function test_securityResearcherGhoPayment() public {
    address receiver = proposal.SECURITY_RESEARCHER();
    uint256 amount = proposal.SECURITY_RESEARCHER_GHO_PAYMENT_AMOUNT();
    address gho = AaveV3EthereumAssets.GHO_UNDERLYING;

    uint256 receiverBefore = IERC20(gho).balanceOf(receiver);

    executePayload(vm, address(proposal));

    assertEq(IERC20(gho).balanceOf(receiver), receiverBefore + amount, 'receiver balance mismatch');
  }

  function test_immunefiGhoPayment() public {
    address receiver = proposal.IMMUNEFI();
    uint256 amount = proposal.IMMUNEFI_GHO_PAYMENT_AMOUNT();
    address gho = AaveV3EthereumAssets.GHO_UNDERLYING;

    uint256 receiverBefore = IERC20(gho).balanceOf(receiver);

    executePayload(vm, address(proposal));

    assertEq(IERC20(gho).balanceOf(receiver), receiverBefore + amount, 'receiver balance mismatch');
  }

  function test_aaveV4BountySherlockGhoPayment() public {
    address receiver = proposal.AAVE_V4_BOUNTY_SHERLOCK();
    uint256 amount = proposal.AAVE_V4_BOUNTY_SHERLOCK_GHO_PAYMENT_AMOUNT();
    address gho = AaveV3EthereumAssets.GHO_UNDERLYING;

    uint256 receiverBefore = IERC20(gho).balanceOf(receiver);

    executePayload(vm, address(proposal));

    assertEq(IERC20(gho).balanceOf(receiver), receiverBefore + amount, 'receiver balance mismatch');
  }

  function test_collectorTotalGhoPayments() public {
    address collector = address(AaveV3Ethereum.COLLECTOR);
    address gho = AaveV3EthereumAssets.GHO_UNDERLYING;
    uint256 totalWithdrawn = proposal.SECURITY_RESEARCHER_GHO_PAYMENT_AMOUNT() +
      proposal.IMMUNEFI_GHO_PAYMENT_AMOUNT() +
      proposal.AAVE_V4_BOUNTY_SHERLOCK_GHO_PAYMENT_AMOUNT();

    assertEq(totalWithdrawn, EXPECTED_TOTAL_GHO_PAYMENTS, 'total GHO payments mismatch');

    uint256 collectorGhoBefore = IERC20(gho).balanceOf(collector);

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(gho).balanceOf(collector),
      collectorGhoBefore - totalWithdrawn,
      'GHO balance mismatch: the collector should have transferred out GHO payments'
    );
  }

  function _assertStewardTokenBudgetIncrease(address token, uint256 amount) internal {
    IMainnetSwapSteward steward = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD);

    uint256 tokenBudgetBefore = steward.tokenBudget(token);

    executePayload(vm, address(proposal));

    assertEq(steward.tokenBudget(token), tokenBudgetBefore + amount, 'budget not increased');
  }
}
