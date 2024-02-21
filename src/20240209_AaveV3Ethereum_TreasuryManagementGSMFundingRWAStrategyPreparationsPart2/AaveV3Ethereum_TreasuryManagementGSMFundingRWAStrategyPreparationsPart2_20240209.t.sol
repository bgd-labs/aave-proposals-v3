// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209} from './AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209.sol';

/**
 * @dev Test for AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209
 * command: make test-contract filter=AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209
 */
contract AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209_Test is
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

  AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209
    internal proposal;

  address public constant swapProxyDai = 0xa59c5fE2c0A09069bD1fD31a71031d9b8D3FaE93;
  address public constant swapProxyUsdc = 0x16b97c7a2870edCA71e4Ed837b3a0Ec93Af328E9;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19215132);
    proposal = new AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    uint256 collectorDaiBalanceBefore = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 aUsdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      AaveV3EthereumAssets.USDT_ORACLE,
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      address(proposal),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.USDC_TO_SWAP(),
      address(proposal),
      50
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0,
      'DAI balance of Collector is not zero'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(swapProxyDai),
      collectorDaiBalanceBefore,
      'DAI balance of proxy is not equal to Collector balance before'
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0,
      'USDC balance of Collector is not zero'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(swapProxyUsdc),
      proposal.USDC_TO_SWAP(),
      'USDC balance of proxy is not equal to USDC_TO_SWAP amount'
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      aUsdcBalanceBefore,
      'aUSDC balance of Collector is not greater than before'
    );
  }

  function test_depositsToV3() public {
    uint256 collectorAUsdtBalanceBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 toWithdraw = 1_000e6;

    deal(AaveV3EthereumAssets.USDT_UNDERLYING, address(proposal), toWithdraw);

    proposal.deposit(AaveV3EthereumAssets.USDT_UNDERLYING, toWithdraw);

    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorAUsdtBalanceBefore + toWithdraw,
      1
    );
  }
}
