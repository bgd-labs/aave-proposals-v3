// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {ReimbursePayload} from './ReimbursePayload.sol';

/**
 * @dev Test for ReimbursePayload
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260331_Multi_UpgradeAaveInstancesToV37Part1/ReimbursePayload.t.sol -vv
 */
contract ReimbursePayload_Test is ProtocolV3TestBase {
  ReimbursePayload internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24780007);
    proposal = new ReimbursePayload();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('ReimbursePayload', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_balanceBeforeAfter() public {
    uint256 ghoBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.CERTORA());
    uint256 usdtBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(proposal.BGD());

    executePayload(vm, address(proposal));

    uint256 ghoAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(proposal.CERTORA());
    uint256 usdtAfter = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(proposal.BGD());

    assertEq(ghoAfter - ghoBefore, 12_240e18, 'GHO post-proposal balance mismatch');
    assertApproxEqAbs(usdtAfter - usdtBefore, 62_422e6, 2);
  }
}
