// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911} from './AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

/**
 * @dev Test for AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240911_Multi_AddAdapterAsFlashBorrowerAndRevokePrevious/AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911.t.sol -vv
 */
contract AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911_Test is
  ProtocolV3TestBase
{
  AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 252479788);
    proposal = new AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Arbitrum.ACL_MANAGER.isFlashBorrower(
      proposal.NEW_FLASH_BORROWER()
    );
    assertEq(isFlashBorrower, true);

    bool isFlashBorrowerPrevious = AaveV3Arbitrum.ACL_MANAGER.isFlashBorrower(
      AaveV3Arbitrum.DEBT_SWAP_ADAPTER
    );
    assertEq(isFlashBorrowerPrevious, false);
  }

  function test_isTokensRescued() external {
    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3ArbitrumAssets.DAI_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected DAI_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.DAI_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected DAI_A_TOKEN remaining'
    );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.DAI_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected DAI_V_TOKEN remaining'
    // );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.DAI_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected DAI_S_TOKEN remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.DAI_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected DAI_STATA_TOKEN remaining'
    );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LINK_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LINK_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LINK_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LINK_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LINK_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LINK_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LINK_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LINK_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LINK_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDC_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDC_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDC_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDC_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDC_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDC_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDC_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDC_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WBTC_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WBTC_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WBTC_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WBTC_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WBTC_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WBTC_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WBTC_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WBTC_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WBTC_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WBTC_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WETH_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WETH_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WETH_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WETH_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WETH_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WETH_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WETH_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.WETH_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected WETH_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDT_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDT_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDT_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDT_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDT_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDT_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDT_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDT_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDT_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDT_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.AAVE_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected AAVE_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.AAVE_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected AAVE_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.AAVE_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected AAVE_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.AAVE_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected AAVE_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.AAVE_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected AAVE_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.EURS_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected EURS_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.EURS_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected EURS_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.EURS_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected EURS_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.EURS_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected EURS_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.EURS_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected EURS_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.wstETH_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected wstETH_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.wstETH_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected wstETH_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.wstETH_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected wstETH_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.wstETH_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected wstETH_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.wstETH_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected wstETH_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.MAI_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected MAI_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.MAI_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected MAI_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.MAI_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected MAI_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.MAI_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected MAI_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.MAI_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected MAI_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.rETH_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected rETH_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.rETH_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected rETH_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.rETH_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected rETH_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.rETH_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected rETH_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.rETH_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected rETH_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LUSD_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LUSD_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LUSD_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LUSD_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LUSD_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LUSD_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LUSD_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LUSD_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.LUSD_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected LUSD_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDCn_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDCn_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDCn_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDCn_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDCn_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDCn_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDCn_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDCn_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.USDCn_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected USDCn_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.FRAX_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected FRAX_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.FRAX_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected FRAX_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.FRAX_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected FRAX_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.FRAX_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected FRAX_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.FRAX_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected FRAX_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected ARB_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.ARB_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected ARB_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.ARB_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected ARB_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.ARB_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected ARB_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.ARB_STATA_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected ARB_STATA_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.weETH_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected weETH_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.weETH_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected weETH_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.weETH_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected weETH_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.weETH_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected weETH_S_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.GHO_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected GHO_UNDERLYING remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.GHO_A_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected GHO_A_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.GHO_V_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected GHO_V_TOKEN remaining'
    // );
    // assertEq(
    //   IERC20(AaveV3ArbitrumAssets.GHO_S_TOKEN).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
    //   0,
    //   'Unexpected GHO_S_TOKEN remaining'
    // );
  }
}
