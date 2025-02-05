// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_FebruaryFundingUpdate_20250120} from './AaveV3Ethereum_FebruaryFundingUpdate_20250120.sol';

/**
 * @dev Test for AaveV3Ethereum_FebruaryFundingUpdate_20250120
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250120_Multi_FebruaryFundingUpdate/AaveV3Ethereum_FebruaryFundingUpdate_20250120.t.sol -vv
 */
contract AaveV3Ethereum_FebruaryFundingUpdate_20250120_Test is ProtocolV3TestBase {
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

  AaveV3Ethereum_FebruaryFundingUpdate_20250120 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21667725);
    proposal = new AaveV3Ethereum_FebruaryFundingUpdate_20250120();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_FebruaryFundingUpdate_20250120',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_transfers() public {
    uint256 balanceMeritBefore = IERC20(proposal.FLUID()).balanceOf(proposal.MERIT_SAFE());
    uint256 balanceUSDCAciBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      proposal.ACI_SAFE()
    );
    uint256 balanceWETHAciBefore = IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(
      proposal.ACI_SAFE()
    );
    uint256 balancePYUSDAciBefore = IERC20(AaveV3EthereumAssets.PYUSD_UNDERLYING).balanceOf(
      proposal.ACI_SAFE()
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(proposal.FLUID()).balanceOf(proposal.MERIT_SAFE()),
      balanceMeritBefore + proposal.FLUID_AMOUNT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(proposal.ACI_SAFE()),
      balanceUSDCAciBefore + proposal.USDC_ACI_REIMBURSEMENT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING).balanceOf(proposal.ACI_SAFE()),
      balanceWETHAciBefore + proposal.ETH_ACI_REIMBURSEMENT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.PYUSD_UNDERLYING).balanceOf(proposal.ACI_SAFE()),
      balancePYUSDAciBefore + proposal.PYUSD_ACI_REIMBURSEMENT()
    );
  }

  function test_transfersALC() public {
    uint256 balanceBalBefore = IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );
    uint256 balanceCrvBefore = IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(
      proposal.ALC_SAFE()
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      1 ether
    );
    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      10 ether
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.BAL_UNDERLYING).balanceOf(proposal.ALC_SAFE()),
      balanceBalBefore
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.CRV_UNDERLYING).balanceOf(proposal.ALC_SAFE()),
      balanceCrvBefore
    );
  }

  function test_migrations() public {
    uint256 balanceBeforeAWethV3 = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeAWbtcV3 = IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeALinkV3 = IERC20(AaveV3EthereumAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeAMkrV3 = IERC20(AaveV3EthereumAssets.MKR_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeAUsdcV3 = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeAUsdtV3 = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeUsdc = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeUsdt = IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertGt(
      IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1e8
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.MKR_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
    assertGt(balanceBeforeUsdc, proposal.AMOUNT_WITHDRAW_USDC());
    assertGt(balanceBeforeUsdt, proposal.AMOUNT_WITHDRAW_USDT());

    uint256 amountUnderlyingUsdc = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 amountUnderlyingUsdt = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      1 ether
    );
    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1e8,
      1e6
    );
    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.LINK_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      0.005 ether
    );
    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.MKR_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      0.002 ether
    );

    // mintToTreasury means there will be residual in favor of Collector
    assertGt(
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeUsdc - proposal.AMOUNT_WITHDRAW_USDC()
    );
    assertGt(
      IERC20(AaveV2EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeUsdt - proposal.AMOUNT_WITHDRAW_USDT()
    );
    //

    assertGt(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAWethV3
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAWbtcV3
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.LINK_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeALinkV3
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.MKR_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAMkrV3
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAUsdcV3 +
        amountUnderlyingUsdc +
        proposal.AMOUNT_WITHDRAW_USDC() -
        proposal.AMOUNT_SWAP_USDC() -
        proposal.USDC_ACI_REIMBURSEMENT()
    );
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAUsdtV3 +
        amountUnderlyingUsdt +
        proposal.AMOUNT_WITHDRAW_USDT() -
        proposal.AMOUNT_SWAP_USDT()
    );
  }

  function test_withdrawAndSwapToETH() public {
    assertGt(
      IERC20(AaveV2EthereumAssets.DPI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.LUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );

    _expectEvents();

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.DPI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      0.6 ether
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.LUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
  }

  function test_withdrawAndSwapToUSDS() public {
    assertGt(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertGt(
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );

    assertGt(
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );

    _expectEvents();

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      0
    );

    assertApproxEqAbs(
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether,
      1_100 ether
    );

    assertEq(
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      1 ether
    );
  }

  function test_swaps() public {
    _expectEvents();

    executePayload(vm, address(proposal));
  }

  function test_deposit() public {
    uint256 balanceBeforeAWethV3 = IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeAWbtcV3 = IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeALinkV3 = IERC20(AaveV3EthereumAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeAMkrV3 = IERC20(AaveV3EthereumAssets.MKR_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeAUsdcV3 = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 balanceBeforeAUsdtV3 = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertGt(
      IERC20(AaveV3EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAWethV3
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAWbtcV3
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.LINK_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeALinkV3
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.MKR_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAMkrV3
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAUsdcV3 - proposal.USDC_ACI_REIMBURSEMENT()
    );
    assertGt(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)),
      balanceBeforeAUsdtV3
    );
  }

  // Helper to expect events in the right order
  function _expectEvents() internal {
    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      proposal.DPI_FEED(),
      AaveV3EthereumAssets.WETH_ORACLE,
      75744180366755815526, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      400
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      proposal.LUSD_FEED(),
      AaveV3EthereumAssets.WETH_ORACLE,
      24649118182425208482743, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      400
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.USDS_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      AaveV3EthereumAssets.USDS_ORACLE,
      2114547046233073600686054, // Hardcoded as dynamic
      address(AaveV3Ethereum.COLLECTOR),
      75
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.AMOUNT_SWAP_USDC(),
      address(AaveV3Ethereum.COLLECTOR),
      75
    );

    vm.expectEmit(true, true, true, true, MiscEthereum.AAVE_SWAPPER);
    emit SwapRequested(
      proposal.MILKMAN(),
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      proposal.GHO_USD_FEED(),
      proposal.AMOUNT_SWAP_USDT(),
      address(AaveV3Ethereum.COLLECTOR),
      75
    );
  }
}
