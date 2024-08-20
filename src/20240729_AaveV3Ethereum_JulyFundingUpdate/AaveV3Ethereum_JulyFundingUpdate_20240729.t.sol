// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_JulyFundingUpdate_20240729} from './AaveV3Ethereum_JulyFundingUpdate_20240729.sol';

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/core/contracts/interfaces/IScaledBalanceToken.sol';

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
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20421735);
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

    uint256 wethAllowanceAmount = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).allowance(
      COLLECTOR,
      proposal.MERIT_SAFE()
    );

    assertEq(ghoAllowanceAmount, proposal.GHO_AMOUNT());
    assertEq(wethAllowanceAmount, proposal.WETH_AMOUNT());
  }

  function test_swapEventsAndPrices() public {
    uint256 expectedInUsde = 112014478259269445050414;
    uint256 expectedInUsdt = 499999999999;
    uint256 expectedInFrax = 31935428199756049088619;
    uint256 expectedInDpi = 133444159197713527567;

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.USDE_FEED(),
      proposal.GHO_USD_FEED(),
      expectedInUsde, // Hardcoded as dynamic
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
      expectedInUsdt, // Hardcoded as dynamic
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
      expectedInFrax, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      100
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.DPI_FEED(),
      proposal.GHO_USD_FEED(),
      expectedInDpi, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      500
    );

    executePayload(vm, address(proposal));

    _baseSwapTest(
      proposal.PRICE_CHECKER(),
      expectedInUsde, // DAI/USD ~ 1.0 exchange rate on  30/07/2024
      expectedInUsde,
      15e14, // 1e18 is 100%, 15e14 is 0.15%
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.USDE_FEED(),
      AaveV3EthereumAssets.GHO_ORACLE
    );

    _baseSwapTest(
      proposal.PRICE_CHECKER(),
      499999e18, // usdt is 6 decimals we get 18 out
      expectedInUsdt,
      3e14, // 1e18 is 100%, 3e14 is 0.03%
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.USDT_FEED(),
      AaveV3EthereumAssets.GHO_ORACLE
    );

    _baseSwapTest(
      proposal.PRICE_CHECKER(),
      expectedInFrax, // FRAX/USD ~ 1.0 exchange rate on  30/07/2024
      expectedInFrax,
      4e15, // 1e18 is 100%, 4e15 is 0.4%
      AaveV3EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.FRAX_FEED(),
      AaveV3EthereumAssets.GHO_ORACLE
    );

    _baseSwapTest(
      proposal.PRICE_CHECKER(),
      expectedInDpi * 90, // DPI/USD ~ 90 exchange rate on  30/07/2024
      expectedInDpi,
      20e14, // 1e18 is 100%, 20e14 is 0.20%
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      proposal.DPI_FEED(),
      AaveV3EthereumAssets.GHO_ORACLE
    );
  }

  function test_withdrawAndSwapForGho() public {
    uint256 collectorAusdev3BalanceBefore = IScaledBalanceToken(AaveV3EthereumAssets.USDe_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    uint256 collectorAusdtv2BalanceBefore = IScaledBalanceToken(AaveV2EthereumAssets.USDT_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    uint256 collectorAfraxv2BalanceBefore = IScaledBalanceToken(AaveV2EthereumAssets.FRAX_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    uint256 collectorAfraxv3BalanceBefore = IScaledBalanceToken(AaveV3EthereumAssets.FRAX_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    uint256 collectorAdpiv2BalanceBefore = IScaledBalanceToken(AaveV2EthereumAssets.DPI_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    executePayload(vm, address(proposal));

    uint256 collectorAusdev3BalanceAfter = IScaledBalanceToken(AaveV3EthereumAssets.USDe_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    uint256 collectorAusdtv2BalanceAfter = IScaledBalanceToken(AaveV2EthereumAssets.USDT_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    uint256 collectorAfraxv2BalanceAfter = IScaledBalanceToken(AaveV2EthereumAssets.FRAX_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    uint256 collectorAfraxv3BalanceAfter = IScaledBalanceToken(AaveV3EthereumAssets.FRAX_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    uint256 collectorAdpiv2BalanceAfter = IScaledBalanceToken(AaveV2EthereumAssets.DPI_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    /// USDe
    uint256 swapperUsdeBalance = IERC20(AaveV3EthereumAssets.USDe_UNDERLYING).balanceOf(
      0x6c4b03Baa6465ec8878eDcA9b7F8f284656877a4
    );
    assertApproxEqAbs(collectorAusdev3BalanceAfter, 1e18, 700e18);
    assertApproxEqAbs(swapperUsdeBalance, collectorAusdev3BalanceBefore, 1e18);

    /// USDT
    uint256 swapperUsdtBalance = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      0x534AB095A768D053f3E3f592f87ee932D6b3AbBa
    );

    assertApproxEqAbs(collectorAusdtv2BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(swapperUsdtBalance, collectorAusdtv2BalanceBefore, 1e18);

    /// FRAX
    uint256 swapperFraxBalance = IERC20(AaveV3EthereumAssets.FRAX_UNDERLYING).balanceOf(
      0x31B7607AdAeBb069F7d0367080297095ADCbAE0A
    );

    assertApproxEqAbs(collectorAfraxv2BalanceAfter, 1e18, 2200e18);
    assertApproxEqAbs(collectorAfraxv3BalanceAfter, 1e18, 600e18);
    assertApproxEqAbs(
      swapperFraxBalance,
      collectorAfraxv2BalanceBefore + collectorAfraxv3BalanceBefore,
      2e18
    );

    /// DPI
    uint256 swapperDpiBalance = IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(
      0xC0d8a993Cb1f4246491783a9C75289C52B7c4f4f
    );

    assertApproxEqAbs(collectorAdpiv2BalanceAfter, 1e18, 50e18);
    assertApproxEqAbs(swapperDpiBalance, collectorAdpiv2BalanceBefore, 50e18);
  }

  function test_swapPrices() public {}

  /// Basic test for swaps that checks the prices returned make sense.
  /// For example, if both oracles are the same base (USD or ETH), then
  /// getting prices from tradingview.com and using them as `expectedOut`
  /// should work with this test and the other parameters.
  ///
  /// Example: On August 3, 2024, I want to swap 3013 USDC for 1 WETH. If
  /// both oracles have the same base USD, then this is going to work. However,
  /// if for example USDC has base ETH, it's going to fail because:
  /// USDC/ETH = 1 / 3013, rather than USDC/USD = 1 / 1. If the opposite oracle
  /// is ETH/USD then it's going to be 3013 / 1. Sending expected out of 1 ETH
  /// will fail this test because the actual oracles are going to return 1/3013 ETH.
  ///
  /// This test will also ensure the oracles have the necessary functions or it will
  /// revert. For example, if the oracle does not have the `decimals()` function as
  /// some oracles do, then it will fail ahead of time.
  ///
  /// @param priceChecker The price checker used by Milkman
  /// @param expectedOut The amount we've manually checked we should be getting
  /// @param amountIn The amount of from token to be swapped
  /// @param maxDelta The maximum amount of difference in % between expectedOut and calculatedOut
  /// @param from The token to swap from
  /// @param to The token to swap to
  /// @param fromOracle The oracle of the token to swap from
  /// @param toOracle The oracle of the token to swap to
  function _baseSwapTest(
    address priceChecker,
    uint256 expectedOut,
    uint256 amountIn,
    uint256 maxDelta,
    address from,
    address to,
    address fromOracle,
    address toOracle
  ) internal {
    address calc = IPriceChecker(priceChecker).EXPECTED_OUT_CALCULATOR();
    uint256 outCalc = ICalculator(calc).getExpectedOut(
      amountIn,
      from,
      to,
      _encodeOracles(fromOracle, toOracle)
    );

    assertApproxEqRel(outCalc, expectedOut, maxDelta);
  }

  function _encodeOracles(
    address fromOracle,
    address toOracle
  ) internal pure returns (bytes memory) {
    address[] memory paths = new address[](2);
    paths[0] = fromOracle;
    paths[1] = toOracle;

    bool[] memory reverses = new bool[](2);
    reverses[1] = true;

    return abi.encode(paths, reverses);
  }
}

interface IPriceChecker {
  function EXPECTED_OUT_CALCULATOR() external returns (address);
}

interface ICalculator {
  function getExpectedOut(
    uint256 _amountIn,
    address _fromToken,
    address _toToken,
    bytes calldata _data
  ) external view returns (uint256);
}
