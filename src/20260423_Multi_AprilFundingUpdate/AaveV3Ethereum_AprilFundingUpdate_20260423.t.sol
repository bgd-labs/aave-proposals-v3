// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';
import {AaveV3Ethereum_AprilFundingUpdate_20260423} from './AaveV3Ethereum_AprilFundingUpdate_20260423.sol';

interface IMainnetSwapSteward {
  function priceOracle(address token) external view returns (address);
  function swapApprovedToken(address from, address to) external view returns (bool);
  function tokenBudget(address token) external view returns (uint256);
  function swap(address fromToken, address toToken, uint256 amount, uint256 slippage) external;
}

/**
 * @dev Test for AaveV3Ethereum_AprilFundingUpdate_20260423
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260423_Multi_AprilFundingUpdate/AaveV3Ethereum_AprilFundingUpdate_20260423.t.sol -vv
 */
contract AaveV3Ethereum_AprilFundingUpdate_20260423_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AprilFundingUpdate_20260423 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24944785);
    proposal = new AaveV3Ethereum_AprilFundingUpdate_20260423();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AprilFundingUpdate_20260423',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_swapPaths() public {
    IMainnetSwapSteward steward = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD);

    // wBTC

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.USDT_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    // cbBTC

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.USDT_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    // Others

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDC_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDT_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDe_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.AAVE_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.LINK_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.SNX_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.UNI_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.ONE_INCH_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    executePayload(vm, address(proposal));

    // wBTC

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.USDT_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.WBTC_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    // cbBTC

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.USDC_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.USDT_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.cbBTC_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    // Others

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDC_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDT_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDe_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.USDS_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.AAVE_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.LINK_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.SNX_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.UNI_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.ONE_INCH_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );
  }

  function test_swap_oracles() public {
    IMainnetSwapSteward steward = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD);

    deal(AaveV3EthereumAssets.WBTC_UNDERLYING, address(AaveV3Ethereum.COLLECTOR), 1e8);
    deal(AaveV3EthereumAssets.cbBTC_UNDERLYING, address(AaveV3Ethereum.COLLECTOR), 1e8);
    deal(AaveV3EthereumAssets.LINK_UNDERLYING, address(AaveV3Ethereum.COLLECTOR), 1_000 ether);

    // Reverts originally as not configured
    vm.expectRevert();
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    steward.swap(
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      1e8,
      100
    );

    vm.expectRevert();
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    steward.swap(
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      1e8,
      100
    );

    vm.expectRevert();
    vm.prank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    steward.swap(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      1_000 ether,
      100
    );

    assertEq(steward.priceOracle(AaveV3EthereumAssets.WBTC_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.cbBTC_UNDERLYING), address(0));
    assertEq(steward.priceOracle(AaveV3EthereumAssets.LINK_UNDERLYING), address(0));

    executePayload(vm, address(proposal));

    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.WBTC_UNDERLYING),
      AaveV3EthereumAssets.WBTC_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.LINK_UNDERLYING),
      AaveV3EthereumAssets.LINK_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.UNI_UNDERLYING),
      AaveV3EthereumAssets.UNI_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.SNX_UNDERLYING),
      AaveV3EthereumAssets.SNX_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.ONE_INCH_UNDERLYING),
      AaveV3EthereumAssets.ONE_INCH_ORACLE
    );
    assertEq(
      steward.priceOracle(AaveV3EthereumAssets.AAVE_UNDERLYING),
      AaveV3EthereumAssets.AAVE_ORACLE
    );

    // Swaps now pass

    vm.startPrank(GovernanceV3Ethereum.EXECUTOR_LVL_1);
    steward.swap(
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      1e8,
      100
    );

    steward.swap(
      AaveV3EthereumAssets.cbBTC_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      1e8,
      100
    );

    steward.swap(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      1_000 ether,
      100
    );
    vm.stopPrank();
  }

  function test_reimbursements() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.TOKEN_LOGIC()
    );

    uint256 allowanceBeforeLabs = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AAVE_LABS()
    );

    assertGt(allowanceBefore, 0);
    assertEq(allowanceBeforeLabs, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.TOKEN_LOGIC()
    );

    uint256 allowanceAfterLabs = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AAVE_LABS()
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.REIMBURSEMENTS_GHO_AMOUNT());
    assertEq(allowanceAfterLabs, allowanceBeforeLabs + proposal.AAVE_LABS_ALLOWANCE());
  }

  function test_replenishSwapTokenBudget() public {
    uint256 budgetWethBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.WETH_UNDERLYING);

    uint256 budgetUsdtBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDT_UNDERLYING);

    uint256 budgetUsdcBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDC_UNDERLYING);

    uint256 budgetUsdeBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDe_UNDERLYING);

    uint256 budgetUsdsBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDS_UNDERLYING);

    uint256 budgetDaiBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.DAI_UNDERLYING);

    uint256 budgetWbtcBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.WBTC_UNDERLYING);

    uint256 budgetCbbtcBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.cbBTC_UNDERLYING);

    uint256 budgetLinkBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.LINK_UNDERLYING);

    executePayload(vm, address(proposal));

    {
      uint256 budgetWethAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
        .tokenBudget(AaveV3EthereumAssets.WETH_UNDERLYING);

      uint256 budgetUsdtAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
        .tokenBudget(AaveV3EthereumAssets.USDT_UNDERLYING);

      uint256 budgetUsdcAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
        .tokenBudget(AaveV3EthereumAssets.USDC_UNDERLYING);

      assertEq(budgetWethAfter, budgetWethBefore + proposal.WETH_SWAP_BUDGET_AMOUNT());
      assertEq(budgetUsdtAfter, budgetUsdtBefore + proposal.USDT_SWAP_BUDGET_AMOUNT());
      assertEq(budgetUsdcAfter, budgetUsdcBefore + proposal.USDC_SWAP_BUDGET_AMOUNT());
    }

    {
      uint256 budgetUsdeAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
        .tokenBudget(AaveV3EthereumAssets.USDe_UNDERLYING);

      uint256 budgetUsdsAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
        .tokenBudget(AaveV3EthereumAssets.USDS_UNDERLYING);

      uint256 budgetDaiAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
        .tokenBudget(AaveV3EthereumAssets.DAI_UNDERLYING);

      assertEq(budgetUsdeAfter, budgetUsdeBefore + proposal.USDe_SWAP_BUDGET_AMOUNT());
      assertEq(budgetUsdsAfter, budgetUsdsBefore + proposal.USDS_SWAP_BUDGET_AMOUNT());
      assertEq(budgetDaiAfter, budgetDaiBefore + proposal.DAI_SWAP_BUDGET_AMOUNT());
    }

    uint256 budgetWbtcAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.WBTC_UNDERLYING);

    uint256 budgetCbbtcAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.cbBTC_UNDERLYING);

    uint256 budgetLinkAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.LINK_UNDERLYING);

    assertEq(budgetWbtcAfter, budgetWbtcBefore + proposal.WBTC_SWAP_BUDGET_AMOUNT());
    assertEq(budgetCbbtcAfter, budgetCbbtcBefore + proposal.CBBTC_SWAP_BUDGET_AMOUNT());
    assertEq(budgetLinkAfter, budgetLinkBefore + proposal.LINK_SWAP_BUDGET_AMOUNT());
  }

  function test_merit() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );

    assertEq(allowanceAfter, proposal.MERIT_ALLOWANCE());
  }

  function test_ahab() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );

    assertEq(allowanceAfter, proposal.AHAB_aEthWETH_ALLOWANCE());
  }

  function test_tydro() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      MiscEthereum.AFC_SAFE
    );

    assertEq(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      MiscEthereum.ECOSYSTEM_RESERVE,
      MiscEthereum.AFC_SAFE
    );

    assertEq(allowanceAfter, proposal.TYDRO_ALLOWANCE());
  }

  function test_stream_cancel() public {
    uint256 streamId = proposal.OLD_STREAM();
    IStreamable(MiscEthereum.ECOSYSTEM_RESERVE).getStream(streamId);

    executePayload(vm, address(proposal));

    vm.expectRevert();
    IStreamable(MiscEthereum.ECOSYSTEM_RESERVE).getStream(streamId);
  }

  function test_bugBounty() public {
    uint256 balanceCollectorBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    // Validate the Collector has enough GHO tokens
    assertGe(balanceCollectorBefore, proposal.BUGBOUNTY_AMOUNT() + proposal.BUGBOUNTY_FEE());

    uint256 balanceBeforeRecipient = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.BUGBOUNTY_RECEIVER()
    );

    uint256 balanceBeforeImmunefi = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.IMMUNEFI()
    );

    executePayload(vm, address(proposal));

    uint256 balanceAfterRecipient = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.BUGBOUNTY_RECEIVER()
    );

    uint256 balanceAfterImmunefi = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.IMMUNEFI()
    );

    assertEq(balanceAfterRecipient, balanceBeforeRecipient + proposal.BUGBOUNTY_AMOUNT());
    assertEq(balanceAfterImmunefi, balanceBeforeImmunefi + proposal.BUGBOUNTY_FEE());

    uint256 balanceCollectorAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(
      balanceCollectorAfter,
      balanceCollectorBefore - proposal.BUGBOUNTY_AMOUNT() - proposal.BUGBOUNTY_FEE()
    );
  }
}
