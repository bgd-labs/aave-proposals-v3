// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_DecemberFundingUpdate_20251214} from './AaveV3Ethereum_DecemberFundingUpdate_20251214.sol';

interface IMainnetSwapSteward {
  function tokenBudget(address token) external view returns (uint256);
}

/**
 * @dev Test for AaveV3Ethereum_DecemberFundingUpdate_20251214
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251214_AaveV3Ethereum_DecemberFundingUpdate/AaveV3Ethereum_DecemberFundingUpdate_20251214.t.sol -vv
 */
contract AaveV3Ethereum_DecemberFundingUpdate_20251214_Test is ProtocolV3TestBase {
  AaveV3Ethereum_DecemberFundingUpdate_20251214 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24014400);
    proposal = new AaveV3Ethereum_DecemberFundingUpdate_20251214();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_DecemberFundingUpdate_20251214',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_ahab() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumLidoAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );

    assertApproxEqAbs(allowanceBefore, 0, 1 ether);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumLidoAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );

    assertEq(allowanceAfter, proposal.AHAB_WETH_AMOUNT());
  }

  function test_aaveApprovals() public {
    uint256 balanceStkAave = IERC20(AaveSafetyModule.STK_AAVE).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 allowanceAaveBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );

    uint256 allowanceStkAaveBefore = IERC20(AaveSafetyModule.STK_AAVE).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );

    assertEq(allowanceAaveBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );

    uint256 allowanceStkAaveAfter = IERC20(AaveSafetyModule.STK_AAVE).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE
    );

    assertEq(allowanceAfter, proposal.AFC_AAVE_AMOUNT());
    assertEq(allowanceStkAaveAfter, allowanceStkAaveBefore + balanceStkAave);
  }

  function test_ptApprovals() public {
    assertEq(
      IERC20(AaveV3EthereumAssets.PT_eUSDE_14AUG2025_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.PT_sUSDE_25SEP2025_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.PT_USDe_31JUL2025_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.PT_eUSDE_14AUG2025_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      proposal.PT_eUSDE_14AUG2025_AMOUNT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.PT_sUSDE_25SEP2025_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      proposal.PT_sUSDE_25SEP2025_AMOUNT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.PT_USDe_31JUL2025_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        MiscEthereum.AFC_SAFE
      ),
      proposal.PT_USDe_31JUL2025_AMOUNT()
    );

    vm.startPrank(MiscEthereum.AFC_SAFE);
    // forge-lint: disable-next-item(erc20-unchecked-transfer)
    IERC20(AaveV3EthereumAssets.PT_eUSDE_14AUG2025_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE,
      proposal.PT_eUSDE_14AUG2025_AMOUNT()
    );
    // forge-lint: disable-next-item(erc20-unchecked-transfer)
    IERC20(AaveV3EthereumAssets.PT_sUSDE_25SEP2025_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE,
      proposal.PT_sUSDE_25SEP2025_AMOUNT()
    );
    // forge-lint: disable-next-item(erc20-unchecked-transfer)
    IERC20(AaveV3EthereumAssets.PT_USDe_31JUL2025_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.AFC_SAFE,
      proposal.PT_USDe_31JUL2025_AMOUNT()
    );
    vm.stopPrank();
  }

  function test_ethDeposit() public {
    uint256 balanceEthBefore = address(AaveV3Ethereum.COLLECTOR).balance;
    uint256 balanceWethBefore = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertEq(address(AaveV3Ethereum.COLLECTOR).balance, 0);
    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceWethBefore + balanceEthBefore
    );
  }

  function test_merit() public {
    uint256 allowanceBefore = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );

    assertApproxEqAbs(allowanceBefore, 0, 1 ether);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      MiscEthereum.MERIT_AHAB_SAFE
    );

    assertEq(allowanceAfter, proposal.MERIT_GHO_AMOUNT());
  }

  function test_replenishSwapTokenBudget() public {
    uint256 budgetUsdcBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDC_UNDERLYING);
    uint256 budgetUsdtBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDT_UNDERLYING);
    uint256 budgetUsdsBefore = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDS_UNDERLYING);

    executePayload(vm, address(proposal));

    uint256 budgetUsdcAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDC_UNDERLYING);
    uint256 budgetUsdtAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDT_UNDERLYING);
    uint256 budgetUsdsAfter = IMainnetSwapSteward(AaveV3Ethereum.COLLECTOR_SWAP_STEWARD)
      .tokenBudget(AaveV3EthereumAssets.USDS_UNDERLYING);

    assertEq(budgetUsdcAfter, budgetUsdcBefore + proposal.USDC_SWAP_BUDGET_AMOUNT());
    assertEq(budgetUsdtAfter, budgetUsdtBefore + proposal.USDT_SWAP_BUDGET_AMOUNT());
    assertEq(budgetUsdsAfter, budgetUsdsBefore + proposal.USDS_SWAP_BUDGET_AMOUNT());
  }
}
