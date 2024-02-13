// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209} from './AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209.sol';
import {OrbitProgramData} from './OrbitProgramData.sol';

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

  uint256 public constant TOTAL_GHO_WITHDRAWN = 20_000 ether;

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
    uint256 collectorGhoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorWethBalanceBefore = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 collectorDaiBalanceBefore = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 aUsdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256[] memory ethBalancesBeforeUsers = new uint256[](7);
    OrbitProgramData.GasUsage[] memory usage = OrbitProgramData.getGasUsageData();
    for (uint256 i = 0; i < usage.length; i++) {
      ethBalancesBeforeUsers[i] = usage[i].account.balance;
    }

    uint256[] memory ghoBalancesBeforeUsers = new uint256[](4);
    address[] memory ghoPaymentAddresses = OrbitProgramData.getOrbitAddresses();
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      ghoBalancesBeforeUsers[i] = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        ghoPaymentAddresses[i]
      );
    }

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

    uint256 nextStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

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

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorGhoBalanceBefore - TOTAL_GHO_WITHDRAWN,
      'GHO balance of Collector is not equal to previous minus to withdraw'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      collectorWethBalanceBefore - OrbitProgramData.TOTAL_WETH_REBATE,
      'WETH balance of Collector is not equal to previous minus to withdraw'
    );

    for (uint256 i = 0; i < usage.length; i++) {
      assertGt(
        usage[i].account.balance,
        ethBalancesBeforeUsers[i],
        'REBATE recipient balance is not greater than before'
      );
    }

    vm.warp(block.timestamp + 7 days);

    /// Their GHO balance has increased and call also withdraw from stream as it now exists
    for (uint256 i = 0; i < ghoPaymentAddresses.length; i++) {
      assertEq(
        IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i] + OrbitProgramData.RETRO_PAYMENT,
        'GHO balance of Orbit recipient is not greater than before'
      );

      vm.prank(ghoPaymentAddresses[i]);
      AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextStreamId + i, 1);
      assertEq(
        IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(ghoPaymentAddresses[i]),
        ghoBalancesBeforeUsers[i] + OrbitProgramData.RETRO_PAYMENT + 1
      );
    }
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
