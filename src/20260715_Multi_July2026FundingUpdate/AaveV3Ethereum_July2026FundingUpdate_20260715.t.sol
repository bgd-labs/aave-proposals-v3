// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IMainnetSwapSteward} from 'src/interfaces/IMainnetSwapSteward.sol';
import {AaveV3Ethereum_July2026FundingUpdate_20260715} from './AaveV3Ethereum_July2026FundingUpdate_20260715.sol';

/**
 * @dev Test for AaveV3Ethereum_July2026FundingUpdate_20260715
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260715_Multi_July2026FundingUpdate/AaveV3Ethereum_July2026FundingUpdate_20260715.t.sol -vv
 */
contract AaveV3Ethereum_July2026FundingUpdate_20260715_Test is ProtocolV3TestBase {
  AaveV3Ethereum_July2026FundingUpdate_20260715 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25545450);
    proposal = new AaveV3Ethereum_July2026FundingUpdate_20260715();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_July2026FundingUpdate_20260715',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](0);

    reserveConfigChangesTest(AaveV3Ethereum.POOL, address(proposal), updatedAssets);
  }

  function test_monad() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.ALC_SAFE
    );

    uint256 allowanceBeforeAhab = IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );

    assertEq(allowanceBefore, 0);
    assertEq(allowanceBeforeAhab, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.ALC_SAFE
    );

    uint256 allowanceAfterAhab = IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );

    assertEq(allowanceAfter, proposal.GHO_MONAD_ALLOWANCE());
    assertEq(allowanceAfterAhab, proposal.WBTC_MONAD_ALLOWANCE());
  }

  function test_stableVaults() public {
    uint256 allowanceBeforeGho = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.STABLE_VAULT_INCENTIVES_SAFE()
    );

    uint256 allowanceBeforeUsdc = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.STABLE_VAULT_INCENTIVES_SAFE()
    );

    uint256 allowanceBeforeUsdt = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.STABLE_VAULT_INCENTIVES_SAFE()
    );

    assertEq(allowanceBeforeGho, 0);
    assertEq(allowanceBeforeUsdc, 0);
    assertEq(allowanceBeforeUsdt, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfterGho = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.STABLE_VAULT_INCENTIVES_SAFE()
    );

    uint256 allowanceAfterUsdc = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.STABLE_VAULT_INCENTIVES_SAFE()
    );

    uint256 allowanceAfterUsdt = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.STABLE_VAULT_INCENTIVES_SAFE()
    );

    assertEq(allowanceAfterGho, proposal.STABLE_VAULT_GHO_ALLOWANCE());
    assertEq(allowanceAfterUsdc, proposal.STABLE_VAULT_USDC_ALLOWANCE());
    assertEq(allowanceAfterUsdt, proposal.STABLE_VAULT_USDT_ALLOWANCE());
  }

  function test_cancelMeritUsdcAllowance() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );
    assertGt(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );
    assertEq(allowanceAfter, 0);
  }

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

  function test_reimbursements() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.TOKEN_LOGIC()
    );

    assertGt(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.TOKEN_LOGIC()
    );

    assertEq(allowanceAfter, allowanceBefore + proposal.REIMBURSEMENTS_GHO_AMOUNT());
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

    uint256 budgetRlusdBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.RLUSD_UNDERLYING);

    uint256 budgetPyusdBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.PYUSD_UNDERLYING);

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

    uint256 budgetRlusdAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.RLUSD_UNDERLYING);

    uint256 budgetPyusdAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.PYUSD_UNDERLYING);

    assertEq(budgetRlusdAfter, budgetRlusdBefore + proposal.RLUSD_SWAP_BUDGET_AMOUNT());
    assertEq(budgetPyusdAfter, budgetPyusdBefore + proposal.PYUSD_SWAP_BUDGET_AMOUNT());
  }

  function test_swapPaths() public {
    IMainnetSwapSteward steward = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD);

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.RLUSD_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.RLUSD_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.RLUSD_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.PYUSD_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.PYUSD_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    assertFalse(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.PYUSD_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.RLUSD_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.RLUSD_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.RLUSD_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.PYUSD_UNDERLYING,
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.PYUSD_UNDERLYING,
        AaveV3EthereumAssets.AAVE_UNDERLYING
      )
    );

    assertTrue(
      steward.swapApprovedToken(
        AaveV3EthereumAssets.PYUSD_UNDERLYING,
        AaveV3EthereumAssets.WETH_UNDERLYING
      )
    );
  }
}
