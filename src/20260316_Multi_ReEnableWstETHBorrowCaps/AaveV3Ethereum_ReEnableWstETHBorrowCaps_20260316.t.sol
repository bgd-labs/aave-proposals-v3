// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316} from './AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316.sol';

/**
 * @dev Test for AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260316_Multi_ReEnableWstETHBorrowCaps/AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316.t.sol -vv
 */
contract AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24669521);
    proposal = new AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ReEnableWstETHBorrowCaps_20260316',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_borrowWstETHAfterProposal() public {
    executePayload(vm, address(proposal));

    address user = 0xef992050dfF61225ba6fb6018a106A6e2b2569a3; // user with an hf of 1.04 with ezETH/wstETH e-mode activated
    IPool pool = IPool(address(AaveV3Ethereum.POOL));

    uint256 borrowAmount = 20e18;
    uint256 debtBefore = IERC20(AaveV3EthereumAssets.wstETH_V_TOKEN).balanceOf(user);

    vm.prank(user);
    pool.borrow(AaveV3EthereumAssets.wstETH_UNDERLYING, borrowAmount, 2, 0, user);

    uint256 debtAfter = IERC20(AaveV3EthereumAssets.wstETH_V_TOKEN).balanceOf(user);
    assertGe(
      debtAfter - debtBefore,
      borrowAmount,
      'User debt should increase by at least 20 wstETH'
    );
  }
}
