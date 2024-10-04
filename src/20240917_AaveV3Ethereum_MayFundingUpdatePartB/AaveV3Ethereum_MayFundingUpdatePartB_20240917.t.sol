// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_MayFundingUpdatePartB_20240917} from './AaveV3Ethereum_MayFundingUpdatePartB_20240917.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3Ethereum_MayFundingUpdatePartB_20240917
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240917_AaveV3Ethereum_MayFundingUpdatePartB/AaveV3Ethereum_MayFundingUpdatePartB_20240917.t.sol -vv
 */
contract AaveV3Ethereum_MayFundingUpdatePartB_20240917_Test is ProtocolV3TestBase {
  AaveV3Ethereum_MayFundingUpdatePartB_20240917 internal proposal;

  address internal COLLECTOR = address(AaveV3Ethereum.COLLECTOR);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20880954);
    proposal = new AaveV3Ethereum_MayFundingUpdatePartB_20240917();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_MayFundingUpdatePartB_20240917',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_payout() public {
    uint256 balanceBefore500 = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.RECIPIENT_500()
    );
    uint256 balanceBefore1000 = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.RECIPIENT_1000()
    );
    uint256 balanceBeforeImmunefy = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.IMMUNEFI()
    );

    executePayload(vm, address(proposal));

    uint256 balanceAfter500 = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.RECIPIENT_500()
    );
    uint256 balanceAfter1000 = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.RECIPIENT_1000()
    );
    uint256 balanceAfterImmunefy = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.IMMUNEFI()
    );

    assertEq(balanceAfter500, balanceBefore500 + 500e18);
    assertEq(balanceAfter1000, balanceBefore1000 + 1000e18);
    assertEq(balanceAfterImmunefy, balanceBeforeImmunefy + 150e18);
  }

  function test_migration() public {
    /// USDT
    uint256 aUsdtV2Before = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(COLLECTOR);
    uint256 aUsdtV3Before = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(COLLECTOR);
    uint256 usdtBefore = IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).balanceOf(COLLECTOR);

    /// DAI
    uint256 aDaiV2Before = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(COLLECTOR);
    uint256 aDaiV3Before = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(COLLECTOR);
    uint256 daiBefore = IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(COLLECTOR);

    /// USDC
    uint256 aUsdcV2Before = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(COLLECTOR);
    uint256 aUsdcV3Before = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(COLLECTOR);
    uint256 usdcBefore = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(COLLECTOR);

    /// WETH
    uint256 aWethV2Before = IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(COLLECTOR);
    uint256 aWethV3Before = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(COLLECTOR);
    uint256 wethBefore = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(COLLECTOR);

    executePayload(vm, address(proposal));

    /// USDT
    /// note we re-use these variables to avoid stack too deep errors
    uint256 v3After = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(COLLECTOR);
    uint256 underlyingAfter = IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).balanceOf(COLLECTOR);
    verifyBalances(
      aUsdtV2Before,
      aUsdtV3Before,
      usdtBefore,
      v3After,
      underlyingAfter,
      200_000e6,
      0.05e18
    );

    // /// DAI
    v3After = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(COLLECTOR);
    underlyingAfter = IERC20(AaveV2EthereumAssets.DAI_UNDERLYING).balanceOf(COLLECTOR);
    verifyBalances(aDaiV2Before, aDaiV3Before, daiBefore, v3After, underlyingAfter, 1e18, 0.10e18);

    /// USDC
    v3After = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(COLLECTOR);
    underlyingAfter = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(COLLECTOR);
    verifyBalances(
      aUsdcV2Before,
      aUsdcV3Before,
      usdcBefore,
      v3After,
      underlyingAfter,
      1e6,
      0.10e18
    );

    /// WETH
    v3After = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(COLLECTOR);
    underlyingAfter = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(COLLECTOR);
    verifyBalances(
      aWethV2Before,
      aWethV3Before,
      wethBefore,
      v3After,
      underlyingAfter,
      1e18,
      0.02e18
    );
  }

  function verifyBalances(
    uint256 v2Before,
    uint256 v3Before,
    uint256 underlyingBefore,
    uint256 v3After,
    uint256 underlyingAfter,
    uint256 leaveBehind,
    uint256 errorMargin
  ) internal pure {
    /// verify underlying
    assertApproxEqRel(underlyingAfter, 0, errorMargin);

    /// verify v3 balance
    assertApproxEqRel(v3After, (v2Before - leaveBehind) + v3Before + underlyingBefore, errorMargin);
  }
}
