// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3BNB_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912} from './AaveV3BNB_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912.sol';

/**
 * @dev Test for AaveV3BNB_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20240912_Multi_AddAdapterAsFlashBorrowerAndRevokePrevious/AaveV3BNB_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912.t.sol -vv
 */
contract AaveV3BNB_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912_Test is ProtocolV3TestBase {
  AaveV3BNB_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 42190471);
    proposal = new AaveV3BNB_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3BNB_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912',
      AaveV3BNB.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3BNB.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
    assertEq(isFlashBorrower, true);
    bool isFlashBorrowerPrevious = AaveV3BNB.ACL_MANAGER.isFlashBorrower(
      AaveV3BNB.DEBT_SWAP_ADAPTER
    );
    assertEq(isFlashBorrowerPrevious, false);
  }

  function test_isTokensRescued() external {
    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3BNBAssets.USDT_UNDERLYING).balanceOf(AaveV3BNB.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected USDT_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3BNBAssets.BTCB_UNDERLYING).balanceOf(AaveV3BNB.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected BTCB_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3BNBAssets.ETH_UNDERLYING).balanceOf(AaveV3BNB.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected ETH_UNDERLYING remaining'
    );
    assertEq(
      IERC20(AaveV3BNBAssets.USDC_UNDERLYING).balanceOf(AaveV3BNB.DEBT_SWAP_ADAPTER),
      0,
      'Unexpected USDC_UNDERLYING remaining'
    );
  }
}
