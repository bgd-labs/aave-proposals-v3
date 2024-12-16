// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209} from './AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209.sol';

/**
 * @dev Test for AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241209_AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV/AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209.t.sol -vv
 */
contract AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209_Test is
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

  AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21415862);
    proposal = new AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_AaveLiquidityCommitteeFundingPhaseV_20241209',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_aclAllowance() public {
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(AaveV3EthereumAssets.GHO_UNDERLYING);
    uint256 alcAllowanceBefore = IERC20(aTokenAddress).allowance(
      address(AaveV3EthereumLido.COLLECTOR),
      proposal.ALC_SAFE()
    );

    executePayload(vm, address(proposal));

    uint256 alcAllowanceAfter = IERC20(aTokenAddress).allowance(
      address(AaveV3EthereumLido.COLLECTOR),
      proposal.ALC_SAFE()
    );

    assertEq(alcAllowanceAfter, alcAllowanceBefore + proposal.ALC_ALLOWANCE());
  }

  function test_swap() public {
    uint256 collectorAEthUsdtBalanceBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAEthUsdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.A_ETH_USDT_WITHDRAW_AMOUNT(),
      address(AaveV3EthereumLido.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.A_ETH_USDC_WITHDRAW_AMOUNT(),
      address(AaveV3EthereumLido.COLLECTOR),
      100
    );

    executePayload(vm, address(proposal));

    uint256 collectorAEthUsdtBalanceAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAEthUsdcBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(
      collectorAEthUsdtBalanceBefore,
      collectorAEthUsdtBalanceAfter + proposal.A_ETH_USDT_WITHDRAW_AMOUNT(),
      1e6
    );
    assertApproxEqAbs(
      collectorAEthUsdcBalanceBefore,
      collectorAEthUsdcBalanceAfter + proposal.A_ETH_USDC_WITHDRAW_AMOUNT(),
      1e6
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
        0x61De0d8d9D49Ec452dd325c1AB746BF113957c98 // milkmanInstance contract
      ),
      proposal.A_ETH_USDT_WITHDRAW_AMOUNT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
        0x778cD71c0bcc862A633Dd683e85A4a6536469738 // milkmanInstance contract
      ),
      proposal.A_ETH_USDC_WITHDRAW_AMOUNT()
    );
  }

  function test_deposit() public {
    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(AaveV3EthereumAssets.GHO_UNDERLYING);

    uint256 collectorGhoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );
    uint256 collectorAGhoBalanceBefore = IERC20(aTokenAddress).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 collectorGhoBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );
    uint256 collectorAGhoBalanceAfter = IERC20(aTokenAddress).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );

    assertEq(collectorGhoBalanceBefore - collectorGhoBalanceAfter, proposal.DEPOSIT_AMOUNT());
    assertEq(collectorAGhoBalanceAfter - collectorAGhoBalanceBefore, proposal.DEPOSIT_AMOUNT());
  }
}
