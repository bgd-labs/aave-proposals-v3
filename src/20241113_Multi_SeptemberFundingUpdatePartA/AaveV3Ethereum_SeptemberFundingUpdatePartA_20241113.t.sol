// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113} from './AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113.sol';

/**
 * @dev Test for AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113.t.sol -vv
 */
contract AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21262170);
    proposal = new AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_withdrawUsdcAndSwapForGho() public {
    uint256 collectorAUsdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 collectorAUsdcBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(
      collectorAUsdcBalanceAfter,
      collectorAUsdcBalanceBefore - proposal.USDC_A_AMOUNT() - 1,
      1,
      'Collector balance after swap'
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
        0xA866e48A6ef92e0191358Cb606C99e6187083567 // milkmanInstance contract
      ),
      proposal.USDC_A_AMOUNT(),
      6_000e6
    );
  }

  function test_withdrawUsdtAndSwapForGho() public {
    uint256 collectorAUsdtBalanceBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 collectorAUsdtBalanceAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertApproxEqAbs(
      collectorAUsdtBalanceAfter,
      collectorAUsdtBalanceBefore - proposal.USDT_A_AMOUNT() - 1,
      1,
      'Collector balance after swap'
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
        0x520A820040199C9f4b4420aE72aa9F8b91171262 // milkmanInstance contract
      ),
      proposal.USDT_A_AMOUNT(),
      3_500e6
    );
  }

  function test_withdrawDaiAndSwapForGho() public {
    uint256 collectorDaiBalanceBefore = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorADaiBalanceBefore = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 collectorAEthDaiBalanceBefore = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 collectorDaiBalanceAfter = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorADaiBalanceAfter = IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 collectorAEthDaiBalanceAfter = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(collectorDaiBalanceAfter, 0, 'Collector v3 underlying balance after swap');
    assertApproxEqAbs(collectorADaiBalanceAfter, 1e18, 80_000e18);
    assertApproxEqAbs(
      collectorAEthDaiBalanceAfter,
      collectorAEthDaiBalanceBefore - proposal.DAI_A_AMOUNT(),
      50_000e18
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
        0x6F828AF1D84C996DF4be14Ce178DcFC0cb3A4EEf // milkmanInstance contract
      ),
      collectorDaiBalanceBefore + collectorADaiBalanceBefore + proposal.DAI_A_AMOUNT() - 1e18,
      1e18
    );
  }

  function test_withdrawLusdAndSwapForGho() public {
    executePayload(vm, address(proposal));

    uint256 collectorLusdBalanceAfter = IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorALusdBalanceAfter = IERC20(AaveV2EthereumAssets.LUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertEq(collectorLusdBalanceAfter, 0, 'Collector v3 underlying balance after swap');
    assertEq(
      collectorALusdBalanceAfter,
      27626783961961316333562, // dynamic calculated because can't withdraw all due lack of liquidity
      'Collector v2 a token balance after swap'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(
        0xD9d89a3979347934a70D78E1Da8eb5D1f0863ED6 // milkmanInstance contract
      ),
      76843009601435302316637, // dynamic calculated because can't withdraw all due lack of liquidity
      'Swapper balance after swap'
    );
  }

  function test_withdrawFraxAndSwapForGho() public {
    uint256 collectorFraxBalanceBefore = IERC20(AaveV3EthereumAssets.FRAX_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAFraxBalanceBefore = IERC20(AaveV2EthereumAssets.FRAX_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    uint256 collectorFraxBalanceAfter = IERC20(AaveV3EthereumAssets.FRAX_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 collectorAFraxBalanceAfter = IERC20(AaveV2EthereumAssets.FRAX_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    assertEq(collectorFraxBalanceAfter, 0, 'Collector v3 underlying balance after swap');
    assertApproxEqAbs(collectorAFraxBalanceAfter, 1e18, 900e18);
    assertEq(
      IERC20(AaveV3EthereumAssets.FRAX_UNDERLYING).balanceOf(
        0xfBdaD08dF908C30956AdB380cdC33074A4F37Ee4 // milkmanInstance contract
      ),
      collectorFraxBalanceBefore + collectorAFraxBalanceBefore - 1e18,
      'Swapper balance after swap'
    );
  }

  function test_swapEvents() public {
    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      1255824963385, // Hardcoded as dynamic
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
      1253318999591, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      50
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      proposal.GHO_USD_FEED(),
      1362327582832050751435002, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.LUSD_ORACLE,
      proposal.GHO_USD_FEED(),
      76843009601435302316637, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      300
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.FRAX_ORACLE,
      proposal.GHO_USD_FEED(),
      5725614971954349972007, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      500
    );

    executePayload(vm, address(proposal));
  }

  function test_gasRebate() public {
    uint256 balanceKpkBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      proposal.KARPATKEY()
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(proposal.KARPATKEY()),
      balanceKpkBefore + proposal.GAS_REBATE_AMOUNT()
    );
  }

  function test_meritAllowance() public {
    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_SAFE()
      ),
      proposal.GHO_ALLOWANCE()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
        address(AaveV3Ethereum.COLLECTOR),
        proposal.MERIT_SAFE()
      ),
      proposal.WETH_A_ALLOWANCE()
    );

    uint256 ghoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.MERIT_SAFE()
    );
    uint256 wethBalanceBefore = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      proposal.MERIT_SAFE()
    );

    vm.startPrank(proposal.MERIT_SAFE());
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_SAFE(),
      proposal.GHO_ALLOWANCE()
    );
    IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).transferFrom(
      address(AaveV3Ethereum.COLLECTOR),
      proposal.MERIT_SAFE(),
      proposal.WETH_A_ALLOWANCE()
    );
    vm.stopPrank();

    uint256 ghoBalanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.MERIT_SAFE()
    );
    uint256 wethBalanceAfter = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      proposal.MERIT_SAFE()
    );

    assertEq(ghoBalanceAfter, ghoBalanceBefore + proposal.GHO_ALLOWANCE());
    assertEq(wethBalanceAfter, wethBalanceBefore + proposal.WETH_A_ALLOWANCE());
  }

  function test_isTokensRescuedV2() external {
    uint256 sUSDCollectorInitialBalance = IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 sUSDTransferred = IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(
      proposal.DEBT_SWAP_ADAPTER()
    );
    uint256 USDCTransferred = IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
      proposal.DEBT_SWAP_ADAPTER()
    );

    executePayload(vm, address(proposal));

    // AaveV2Ethereum current
    assertEq(
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(proposal.DEBT_SWAP_ADAPTER()),
      0,
      'Unexpected sUSD_UNDERLYING remaining'
    );
    assertEq(
      sUSDCollectorInitialBalance + sUSDTransferred,
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected sUSD_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(proposal.DEBT_SWAP_ADAPTER()),
      0,
      'Unexpected USDC_UNDERLYING remaining'
    );
    assertEq(
      USDCTransferred,
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected USDC_UNDERLYING final treasury balance'
    );
  }

  function test_isTokensRescuedV3() external {
    uint256 crvUSDCollectorInitialBalance = IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING)
      .balanceOf(address(AaveV3Ethereum.COLLECTOR));
    uint256 GHOCollectorInitialBalance = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 rETHCollectorInitialBalance = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 WBTCCollectorInitialBalance = IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    uint256 USDTTransferred = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      proposal.DEBT_SWAP_ADAPTER_V3()
    );
    uint256 crvUSDTransferred = IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(
      proposal.DEBT_SWAP_ADAPTER_V3()
    );
    uint256 GHOTransferred = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.REPAY_WITH_COLLATERAL_ADAPTER()
    );
    uint256 rETHTransferred = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      proposal.REPAY_WITH_COLLATERAL_ADAPTER()
    );
    uint256 WBTCTransferred = IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
      proposal.REPAY_WITH_COLLATERAL_ADAPTER()
    );

    executePayload(vm, address(proposal));

    // AaveV3Ethereum current
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(proposal.DEBT_SWAP_ADAPTER_V3()),
      0,
      'Unexpected USDT_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(proposal.DEBT_SWAP_ADAPTER_V3()),
      0,
      'Unexpected crvUSD_UNDERLYING remaining'
    );
    assertEq(
      crvUSDCollectorInitialBalance + crvUSDTransferred,
      IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected crvUSD_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        proposal.REPAY_WITH_COLLATERAL_ADAPTER()
      ),
      0,
      'Unexpected GHO_UNDERLYING remaining'
    );
    assertEq(
      GHOCollectorInitialBalance + GHOTransferred,
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected GHO_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
        proposal.REPAY_WITH_COLLATERAL_ADAPTER()
      ),
      0,
      'Unexpected rETH_UNDERLYING remaining'
    );
    assertEq(
      rETHCollectorInitialBalance + rETHTransferred,
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected rETH_UNDERLYING final treasury balance'
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
        proposal.REPAY_WITH_COLLATERAL_ADAPTER()
      ),
      0,
      'Unexpected WBTC_UNDERLYING remaining'
    );
    assertEq(
      WBTCCollectorInitialBalance + WBTCTransferred,
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected WBTC_UNDERLYING final treasury balance'
    );
    assertEq(
      USDTTransferred,
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      'Unexpected USDT_UNDERLYING final treasury balance'
    );
  }
}
