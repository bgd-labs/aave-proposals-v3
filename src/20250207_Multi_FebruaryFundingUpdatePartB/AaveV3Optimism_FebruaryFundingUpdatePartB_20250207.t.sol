// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_FebruaryFundingUpdatePartB_20250207} from './AaveV3Optimism_FebruaryFundingUpdatePartB_20250207.sol';

/**
 * @dev Test for AaveV3Optimism_FebruaryFundingUpdatePartB_20250207
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Optimism_FebruaryFundingUpdatePartB_20250207.t.sol -vv
 */
contract AaveV3Optimism_FebruaryFundingUpdatePartB_20250207_Test is ProtocolV3TestBase {
  event Bridge(address indexed token, uint256 amount);

  AaveV3Optimism_FebruaryFundingUpdatePartB_20250207 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 132531064);
    proposal = new AaveV3Optimism_FebruaryFundingUpdatePartB_20250207();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_FebruaryFundingUpdatePartB_20250207',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_bridge() public {
    uint256 lusdCollectorBalanceBefore = IERC20(AaveV3OptimismAssets.LUSD_A_TOKEN).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );
    uint256 usdcCollectorBalanceBefore = IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    assertGt(lusdCollectorBalanceBefore, 1 ether);
    assertGt(usdcCollectorBalanceBefore, 100e6);

    vm.expectEmit(true, false, false, true, MiscOptimism.AAVE_OPT_ETH_BRIDGE);
    emit Bridge(AaveV3OptimismAssets.LUSD_UNDERLYING, 920174312000188190642); // dynamically get bridge
    vm.expectEmit(true, false, false, true, MiscOptimism.AAVE_OPT_ETH_BRIDGE);
    emit Bridge(AaveV3OptimismAssets.USDC_UNDERLYING, 78298331205); // dynamically get bridge balance
    executePayload(vm, address(proposal));

    uint256 lusdCollectorBalanceAfter = IERC20(AaveV3OptimismAssets.LUSD_A_TOKEN).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );
    uint256 usdcCollectorBalanceAfter = IERC20(AaveV3OptimismAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    assertApproxEqAbs(lusdCollectorBalanceAfter, 1 ether, 100);
    assertApproxEqAbs(usdcCollectorBalanceAfter, 100e6, 100);
  }
}
