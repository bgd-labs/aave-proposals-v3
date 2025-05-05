// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_MayFundingUpdate_20250426} from './AaveV3Optimism_MayFundingUpdate_20250426.sol';

/**
 * @dev Test for AaveV3Optimism_MayFundingUpdate_20250426
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20250426_Multi_MayFundingUpdate/AaveV3Optimism_MayFundingUpdate_20250426.t.sol -vv
 */
contract AaveV3Optimism_MayFundingUpdate_20250426_Test is ProtocolV3TestBase {
  AaveV3Optimism_MayFundingUpdate_20250426 internal proposal;

  event Bridge(address indexed token, uint256 amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 135164971);
    proposal = new AaveV3Optimism_MayFundingUpdate_20250426();
  }

  function test_Bridges() public {
    uint256 daiCollectorBalanceBefore = IERC20(AaveV3OptimismAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    uint256 usdtCollectorBalanceBefore = IERC20(AaveV3OptimismAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    uint256 usdcCollectorBalanceBefore = IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    assertGt(daiCollectorBalanceBefore, 0);
    assertGt(usdtCollectorBalanceBefore, 0);
    assertGt(usdcCollectorBalanceBefore, 0);

    vm.expectEmit(true, true, true, true, MiscOptimism.AAVE_OPT_ETH_BRIDGE);
    emit Bridge(AaveV3OptimismAssets.DAI_UNDERLYING, daiCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscOptimism.AAVE_OPT_ETH_BRIDGE);
    emit Bridge(AaveV3OptimismAssets.USDT_UNDERLYING, usdtCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscOptimism.AAVE_OPT_ETH_BRIDGE);
    emit Bridge(AaveV3OptimismAssets.USDC_UNDERLYING, usdcCollectorBalanceBefore);
    executePayload(vm, address(proposal));

    uint256 daiCollectorBalanceAfter = IERC20(AaveV3OptimismAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    uint256 usdtCollectorBalanceAfter = IERC20(AaveV3OptimismAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    uint256 usdcCollectorBalanceAfter = IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    assertEq(daiCollectorBalanceAfter, 0);
    assertEq(usdtCollectorBalanceAfter, 0);
    assertEq(usdcCollectorBalanceAfter, 0);
  }
}
