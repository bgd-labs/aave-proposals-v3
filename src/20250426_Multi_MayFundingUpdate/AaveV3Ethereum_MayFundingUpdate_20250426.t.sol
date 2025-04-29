// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_MayFundingUpdate_20250426} from './AaveV3Ethereum_MayFundingUpdate_20250426.sol';

/**
 * @dev Test for AaveV3Ethereum_MayFundingUpdate_20250426
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250426_Multi_MayFundingUpdate/AaveV3Ethereum_MayFundingUpdate_20250426.t.sol -vv
 */
contract AaveV3Ethereum_MayFundingUpdate_20250426_Test is ProtocolV3TestBase {
  AaveV3Ethereum_MayFundingUpdate_20250426 internal proposal;

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

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22369914);
    proposal = new AaveV3Ethereum_MayFundingUpdate_20250426();
  }

  function test_DepositAndTransfers() public {
    uint256 ethAmountBefore = address(AaveV3Ethereum.COLLECTOR).balance;
    uint256 wethBalanceBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    executePayload(vm, address(proposal));
    uint256 aaveAmountAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 ethAmountAfter = address(AaveV3Ethereum.COLLECTOR).balance;
    uint256 wethBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    assertEq(aaveAmountAfter, 0);
    assertEq(
      ethAmountAfter,
      ethAmountBefore - proposal.ETH_TRANSFER_AMOUNT() - proposal.ETH_DEPOSIT_AMOUNT()
    );
    assertApproxEqAbs(wethBalanceAfter, wethBalanceBefore + proposal.ETH_DEPOSIT_AMOUNT(), 100);
  }

  function test_Swaps() public {
    uint256 usdtAmountBefore = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 usdcAmountBefore = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.USDT_SWAP_AMOUNT(),
      address(AaveV3Ethereum.COLLECTOR),
      75
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.USDC_SWAP_AMOUNT(),
      address(AaveV3Ethereum.COLLECTOR),
      75
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      AaveV3EthereumAssets.USDS_ORACLE,
      2861611664172656320323082,
      address(AaveV3Ethereum.COLLECTOR),
      75
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.LUSD_ORACLE,
      AaveV3EthereumAssets.WETH_ORACLE,
      10425959241049955563153,
      address(AaveV3Ethereum.COLLECTOR),
      350
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.CVX_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      proposal.CVX_USD_ORACLE(),
      AaveV3EthereumAssets.WETH_ORACLE,
      6750896131895957468591,
      address(AaveV3Ethereum.COLLECTOR),
      200
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      proposal.FRAX_USD_ORACLE(),
      AaveV3EthereumAssets.WETH_ORACLE,
      6248759763460068743065,
      address(AaveV3Ethereum.COLLECTOR),
      350
    );

    executePayload(vm, address(proposal));

    uint256 usdtAmountAfter = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 usdcAmountAfter = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 daiAmountAfter = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 lusdAmountAfter = IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 cvxAmountAfter = IERC20(AaveV2EthereumAssets.CVX_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(usdtAmountAfter, usdtAmountBefore - proposal.USDT_SWAP_AMOUNT());
    assertEq(usdcAmountAfter, usdcAmountBefore - proposal.USDC_SWAP_AMOUNT());
    assertEq(daiAmountAfter, 0);
    assertEq(lusdAmountAfter, 0);
    assertEq(cvxAmountAfter, 0);
  }

  function test_approvals() public {
    executePayload(vm, address(proposal));

    uint256 maticAllowance = IERC20(proposal.MATIC_MAINNET()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AAVE_FINANCE_COMMITEE()
    );
    uint256 stmaticAllowance = IERC20(proposal.STMATIC_MAINNET()).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AAVE_FINANCE_COMMITEE()
    );
    uint256 usdtAllowance = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AAVE_FINANCE_COMMITEE()
    );
    uint256 usdcAllowance = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.AAVE_FINANCE_COMMITEE()
    );
    uint256 ghoAllowance = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_SAFE()
    );
    uint256 wethAllowance = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_SAFE()
    );

    assertEq(
      maticAllowance,
      IERC20(proposal.MATIC_MAINNET()).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    assertEq(
      stmaticAllowance,
      IERC20(proposal.STMATIC_MAINNET()).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    assertEq(usdtAllowance, proposal.USDT_BUYBACK_AMOUNT());
    assertEq(usdcAllowance, proposal.USDC_BUYBACK_AMOUNT());
    assertEq(ghoAllowance, proposal.GHO_ALLOWANCE_AMOUNT());
    assertEq(wethAllowance, proposal.WETH_ALLOWANCE_AMOUNT());
  }
}
