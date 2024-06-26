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
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20012345);
    proposal = new AaveV3Ethereum_MayFundingUpdate_20240603();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_MayFundingUpdate_20240603', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_withdrawAndSwapForGho() public {}

  function test_swapEvents() public {
    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      proposal.GHO_USD_FEED(),
      1001250220152543287535240, // Hardcoded as dynamic
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
      17592092283387856321514, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_ORACLE,
      proposal.GHO_USD_FEED(),
      68311679124, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      918606768913, // Hardcoded as dynamic
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
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.GHO_USD_FEED(),
      1000000000001, // Hardcoded as dynamic
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

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.wstETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.wstETH_ORACLE,
      AaveV3EthereumAssets.WETH_ORACLE,
      350000000000000000000, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

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
