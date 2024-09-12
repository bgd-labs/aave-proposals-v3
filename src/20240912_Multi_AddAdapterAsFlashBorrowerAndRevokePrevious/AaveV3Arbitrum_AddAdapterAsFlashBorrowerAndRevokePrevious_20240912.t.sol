// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912} from './AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912.sol';

/**
 * @dev Test for AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240912_Multi_AddAdapterAsFlashBorrowerAndRevokePrevious/AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912.t.sol -vv
 */
contract AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912_Test is
  ProtocolV3TestBase
{
  AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 252760729);
    proposal = new AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912',
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
      IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected LINK_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected USDC_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.WBTC_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected WBTC_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.WETH_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected WETH_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.USDT_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected USDT_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.wstETH_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected wstETH_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.LUSD_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected LUSD_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected ARB_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3ArbitrumAssets.weETH_UNDERLYING).balanceOf(AaveV3Arbitrum.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected weETH_UNDERLYING remaining'
    );
  }
}
