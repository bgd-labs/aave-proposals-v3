// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_JulyFundingUpdate_20240729} from './AaveV3Ethereum_JulyFundingUpdate_20240729.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_JulyFundingUpdate_20240729
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240729_AaveV3Ethereum_JulyFundingUpdate/AaveV3Ethereum_JulyFundingUpdate_20240729.t.sol -vv
 */
contract AaveV3Ethereum_JulyFundingUpdate_20240729_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_JulyFundingUpdate_20240729 internal proposal;

  address internal COLLECTOR = address(AaveV3Ethereum.COLLECTOR);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20412888);
    proposal = new AaveV3Ethereum_JulyFundingUpdate_20240729();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_JulyFundingUpdate_20240729',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_allowances() public {
    executePayload(vm, address(proposal));

    uint256 ghoAllowanceAmount = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
      COLLECTOR,
      proposal.MERIT_SAFE()
    );

    uint256 wethAllowanceAmount = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).allowance(
      COLLECTOR,
      proposal.MERIT_SAFE()
    );

    assertEq(ghoAllowanceAmount, proposal.GHO_AMOUNT());
    assertEq(wethAllowanceAmount, proposal.WETH_AMOUNT());
  }

  function test_swapEvents() public {
    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.USDE_FEED(),
      proposal.GHO_USD_FEED(),
      86616685114734062556678, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.USDT_FEED(),
      proposal.GHO_USD_FEED(),
      500000000000, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.FRAX_FEED(),
      proposal.GHO_USD_FEED(),
      33890685242621442554591, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      150
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.DPI_FEED(),
      proposal.GHO_USD_FEED(),
      171583836859038867757, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      150
    );

    executePayload(vm, address(proposal));
  }

  function test_withdrawAndSwapForGho() public {
    uint256 collectorAusdev3BalanceBefore = IERC20(AaveV3EthereumAssets.USDe_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAusdtv2BalanceBefore = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAfraxv2BalanceBefore = IERC20(AaveV2EthereumAssets.FRAX_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAfraxv3BalanceBefore = IERC20(AaveV3EthereumAssets.FRAX_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAdpiv2BalanceBefore = IERC20(AaveV2EthereumAssets.DPI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorAusdev3BalanceAfter = IERC20(AaveV3EthereumAssets.USDe_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAusdtv2BalanceAfter = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAfraxv2BalanceAfter = IERC20(AaveV2EthereumAssets.FRAX_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAfraxv3BalanceAfter = IERC20(AaveV3EthereumAssets.FRAX_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAdpiv2BalanceAfter = IERC20(AaveV2EthereumAssets.DPI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    /// USDe
    uint256 swapperUsdeBalance = IERC20(AaveV3EthereumAssets.USDe_UNDERLYING).balanceOf(
      0xc7Bffe193c16Af579380f5a940A0DB10731Ba4d3
    );
    assertApproxEqAbs(collectorAusdev3BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(swapperUsdeBalance, collectorAusdev3BalanceBefore, 1e18);

    /// USDT
    uint256 swapperUsdtBalance = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      0x6c4b03Baa6465ec8878eDcA9b7F8f284656877a4
    );

    assertApproxEqAbs(collectorAusdtv2BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(swapperUsdtBalance, collectorAusdtv2BalanceBefore, 1e18);

    /// FRAX
    uint256 swapperFraxBalance = IERC20(AaveV3EthereumAssets.FRAX_UNDERLYING).balanceOf(
      0x534AB095A768D053f3E3f592f87ee932D6b3AbBa
    );

    assertApproxEqAbs(collectorAfraxv2BalanceAfter, 1e18, 1000e18);
    assertApproxEqAbs(collectorAfraxv3BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(
      swapperFraxBalance,
      collectorAfraxv2BalanceBefore + collectorAfraxv3BalanceBefore,
      2e18
    );

    /// DPI
    uint256 swapperDpiBalance = IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(
      0x31B7607AdAeBb069F7d0367080297095ADCbAE0A
    );

    assertApproxEqAbs(collectorAdpiv2BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(swapperDpiBalance, collectorAdpiv2BalanceBefore, 1e18);
  }
}
