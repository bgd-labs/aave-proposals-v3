// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_MayFundingUpdate_20240603} from './AaveV3Ethereum_MayFundingUpdate_20240603.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @dev Test for AaveV3Ethereum_MayFundingUpdate_20240603
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240603_Multi_MayFundingUpdate/AaveV3Ethereum_MayFundingUpdate_20240603.t.sol -vv
 */
contract AaveV3Ethereum_MayFundingUpdate_20240603_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_MayFundingUpdate_20240603 internal proposal;
  address internal COLLECTOR = address(AaveV3Ethereum.COLLECTOR);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20186541);
    proposal = new AaveV3Ethereum_MayFundingUpdate_20240603();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_MayFundingUpdate_20240603', AaveV3Ethereum.POOL, address(proposal));

    uint256 allowanceAmount = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).allowance(
      COLLECTOR,
      proposal.FRONTIER_SAFE()
    );

    assertEq(allowanceAmount, proposal.FRONTIER_ALLOWANCE_AMOUNT());
  }

  function test_withdrawAndSwapForGho() public {
    uint256 collectorAdaiv2BalanceBefore = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAdaiv3BalanceBefore = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorLusdBalanceBefore = IERC20(AaveV3EthereumAssets.LUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorPyusdBalanceBefore = IERC20(AaveV3EthereumAssets.PYUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorUsdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorDpiBalanceBefore = IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorAdaiv2BalanceAfter = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAdaiv3BalanceAfter = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorLusdBalanceAfter = IERC20(AaveV3EthereumAssets.LUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorPyusdBalanceAfter = IERC20(AaveV3EthereumAssets.PYUSD_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorUsdcBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorDpiBalanceAfter = IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(
      COLLECTOR
    );

    /// DAI
    uint256 swapperDaiBalance = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      0x65c8b1B571e14F9C3046FF8c910Cf2316B468060
    );

    assertApproxEqAbs(collectorAdaiv2BalanceAfter, 1e18, 1000e18);
    assertApproxEqAbs(collectorAdaiv3BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(
      swapperDaiBalance,
      collectorAdaiv2BalanceBefore + collectorAdaiv3BalanceBefore,
      10e18
    );

    /// LUSD
    uint256 swapperLusdBalance = IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(
      0x625Fd2cC3C9b68cA48325ea1950A43bC244159aF
    );

    assertApproxEqAbs(collectorLusdBalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(swapperLusdBalance, collectorLusdBalanceBefore, 1e18);

    /// PYUSD
    uint256 swapperPyusdBalance = IERC20(AaveV3EthereumAssets.PYUSD_UNDERLYING).balanceOf(
      0x51aF1D6Efd7b5120B7c125d9de5e22F856C7BeC7
    );

    assertApproxEqAbs(collectorPyusdBalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(swapperPyusdBalance, collectorPyusdBalanceBefore, 1e18);

    /// USDC
    uint256 swapperUsdcBalance = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      0x5ACEB37251d6EAEFCFC458B458FA186742543cDe
    );

    assertApproxEqAbs(collectorUsdcBalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(swapperUsdcBalance, collectorUsdcBalanceBefore, 1e18);

    /// DPI
    uint256 swapperDpiBalance = IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(
      0x53d08983f3Cd86E710c9B18f7cE348503BEEa148
    );

    assertApproxEqAbs(collectorDpiBalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(swapperDpiBalance, collectorDpiBalanceBefore, 1e18);

    /// USDT
    uint256 swapperUsdtBalance = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      0xB60a3714f8c4dA11392d7c3FF6eEdA28250d401f
    );

    assertApproxEqAbs(swapperUsdtBalance, proposal.AETH_USDT_AMOUNT(), 1e18);
  }

  function test_unwrapLsts() public {
    uint256 collectorRethBalanceBefore = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      COLLECTOR
    );

    uint256 collectorWstethBalanceBefore = IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorRethBalanceAfter = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      COLLECTOR
    );

    uint256 collectorWstethBalanceAfter = IERC20(AaveV3EthereumAssets.wstETH_UNDERLYING).balanceOf(
      COLLECTOR
    );

    /// RETH
    uint256 swapperRethBalance = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      0x03E54fFcAab9FA199492b12dFCc4109a0Af9853a
    );

    assertApproxEqAbs(collectorRethBalanceAfter, 0, 1e18);
    assertApproxEqAbs(swapperRethBalance, collectorRethBalanceBefore, 1e18);

    /// WSTETH
    assertApproxEqAbs(
      collectorWstethBalanceAfter,
      collectorWstethBalanceBefore - proposal.WSTETH_AMOUNT(),
      1e16
    );
  }

  function test_swapEvents() public {
    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      proposal.GHO_USD_FEED(),
      1633441869011097825336963, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.LUSD_ORACLE,
      proposal.GHO_USD_FEED(),
      22360165219453072346756, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_ORACLE,
      proposal.GHO_USD_FEED(),
      93350311212, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      1945746375112, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV2EthereumAssets.DPI_ORACLE,
      proposal.GHO_USD_FEED(),
      137080139851167463608, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      500
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.GHO_USD_FEED(),
      1000000000000, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.rETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.rETH_ORACLE,
      AaveV3EthereumAssets.WETH_ORACLE,
      1883870013343165667402, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    // vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    // emit SwapRequested(
    //   proposal.MILKMAN(),
    //   AaveV3EthereumAssets.wstETH_UNDERLYING,
    //   AaveV3EthereumAssets.WETH_UNDERLYING,
    //   AaveV3EthereumAssets.wstETH_ORACLE,
    //   AaveV3EthereumAssets.WETH_ORACLE,
    //   175000000000000000000, // Hardcoded as dynamic
    //   address(AaveV3Ethereum.COLLECTOR),
    //   10
    // );

    // vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    // emit SwapRequested(
    //   proposal.MILKMAN(),
    //   AaveV3EthereumAssets.wstETH_UNDERLYING,
    //   AaveV3EthereumAssets.WETH_UNDERLYING,
    //   AaveV3EthereumAssets.wstETH_ORACLE,
    //   AaveV3EthereumAssets.WETH_ORACLE,
    //   175000000000000000000, // Hardcoded as dynamic
    //   address(AaveV3Ethereum.COLLECTOR),
    //   10
    // );

    executePayload(vm, address(proposal));
  }

  function test_wethMigration() public {
    uint256 collectorAwethv2BalanceBefore = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorAwethv3BalanceBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorAwethv2BalanceAfter = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorAwethv3BalanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorAwethv2BalanceAfter, 1e18, 1e18);

    assertApproxEqAbs(
      collectorAwethv3BalanceAfter,
      collectorAwethv2BalanceBefore + collectorAwethv3BalanceBefore,
      2e18
    );
  }

  function test_depositLink() public {
    uint256 collectorLinkBalanceBefore = IERC20(AaveV2EthereumAssets.LINK_UNDERLYING).balanceOf(
      COLLECTOR
    );

    uint256 collectorAlinkBalanceBefore = IERC20(AaveV3EthereumAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorLinkBalanceAfter = IERC20(AaveV2EthereumAssets.LINK_UNDERLYING).balanceOf(
      COLLECTOR
    );

    uint256 collectorAlinkBalanceAfter = IERC20(AaveV3EthereumAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorLinkBalanceAfter, 0);
    assertApproxEqAbs(
      collectorAlinkBalanceAfter,
      collectorAlinkBalanceBefore + collectorLinkBalanceBefore,
      3e18
    );
  }
}
