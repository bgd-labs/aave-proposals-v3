// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104} from './AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104.sol';

/**
 * @dev Test for AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241104_AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance/AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104.t.sol -vv
 */
contract AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104_Test is
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
  event DepositedIntoLido(address indexed token, uint256 amount);

  AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21287749);
    proposal = new AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OnboardGHOAndMigrateStreamsToLidoInstance_20241104',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_swap() public {
    uint256 collectorAUsdtBalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAUsdcBalanceBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
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
      2000000000000, // Hardcoded as dynamic
      address(proposal),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      1000000000000, // Hardcoded as dynamic
      address(proposal),
      100
    );

    executePayload(vm, address(proposal));

    uint256 collectorAUsdtBalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAUsdcBalanceAfter = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAEthUsdtBalanceAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAEthUsdcBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(
      collectorAUsdtBalanceBefore,
      collectorAUsdtBalanceAfter + proposal.A_USDT_SWAP_AMOUNT(),
      1_000e6
    );
    assertApproxEqAbs(
      collectorAUsdcBalanceBefore,
      collectorAUsdcBalanceAfter + proposal.A_USDC_SWAP_AMOUNT(),
      600e6
    );
    assertApproxEqAbs(
      collectorAEthUsdtBalanceBefore,
      collectorAEthUsdtBalanceAfter + proposal.A_ETH_USDT_SWAP_AMOUNT(),
      1e6
    );
    assertApproxEqAbs(
      collectorAEthUsdcBalanceBefore,
      collectorAEthUsdcBalanceAfter + proposal.A_ETH_USDC_SWAP_AMOUNT(),
      1e6
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
        0xA866e48A6ef92e0191358Cb606C99e6187083567 // milkmanInstance contract
      ),
      proposal.A_USDT_SWAP_AMOUNT() + proposal.A_ETH_USDT_SWAP_AMOUNT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
        0x520A820040199C9f4b4420aE72aa9F8b91171262 // milkmanInstance contract
      ),
      proposal.A_USDC_SWAP_AMOUNT() + proposal.A_ETH_USDC_SWAP_AMOUNT()
    );
  }

  function test_initialFund() public {
    uint256 initialGhoFund = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(AaveV3EthereumAssets.GHO_UNDERLYING);

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3EthereumLido.COLLECTOR)),
      initialGhoFund - 1_000e18
    );
    assertEq(IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.COLLECTOR)), 1_000e18);
  }

  function test_agdAllowance() public {
    uint256 allowance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3EthereumLido.COLLECTOR),
      proposal.AGD_MULTISIG()
    );
    assertGt(allowance, 0);

    executePayload(vm, address(proposal));

    allowance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      address(AaveV3EthereumLido.COLLECTOR),
      proposal.AGD_MULTISIG()
    );
    assertEq(allowance, 0);
  }

  function test_deposit() public {
    executePayload(vm, address(proposal));

    uint256 amount = 1_000e18;

    (address aTokenAddress, , ) = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(AaveV3EthereumAssets.GHO_UNDERLYING);

    deal2(AaveV3EthereumAssets.GHO_UNDERLYING, address(proposal), amount);

    uint256 balanceCollectorBefore = IERC20(aTokenAddress).balanceOf(
      address(AaveV3EthereumLido.COLLECTOR)
    );

    assertEq(IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(proposal)), amount);

    vm.expectEmit();
    emit DepositedIntoLido(AaveV3EthereumAssets.GHO_UNDERLYING, amount);
    proposal.deposit(AaveV3EthereumAssets.GHO_UNDERLYING);

    assertEq(IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(proposal)), 0);
    assertGt(
      IERC20(aTokenAddress).balanceOf(address(AaveV3EthereumLido.COLLECTOR)),
      balanceCollectorBefore
    );
  }
}
