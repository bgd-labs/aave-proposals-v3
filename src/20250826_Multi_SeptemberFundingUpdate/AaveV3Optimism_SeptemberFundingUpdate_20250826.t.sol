// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {MiscOptimism} from 'aave-address-book/MiscOptimism.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_SeptemberFundingUpdate_20250826} from './AaveV3Optimism_SeptemberFundingUpdate_20250826.sol';

/**
 * @dev Test for AaveV3Optimism_SeptemberFundingUpdate_20250826
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250826_Multi_SeptemberFundingUpdate/AaveV3Optimism_SeptemberFundingUpdate_20250826.t.sol -vv
 */
contract AaveV3Optimism_SeptemberFundingUpdate_20250826_Test is ProtocolV3TestBase {
  event Bridge(address indexed token, uint256 amount);

  AaveV3Optimism_SeptemberFundingUpdate_20250826 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 140325310);
    proposal = new AaveV3Optimism_SeptemberFundingUpdate_20250826();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_SeptemberFundingUpdate_20250826',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3OptimismAssets.USDCn_UNDERLYING).allowance(
        address(AaveV3Optimism.COLLECTOR),
        MiscOptimism.AFC_SAFE
      ),
      0
    );

    assertEq(
      IERC20(AaveV3OptimismAssets.sUSD_UNDERLYING).allowance(
        address(AaveV3Optimism.COLLECTOR),
        MiscOptimism.AFC_SAFE
      ),
      0
    );

    uint256 usdcBalanceBefore = IERC20(AaveV3OptimismAssets.USDCn_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    uint256 susdBalanceBefore = IERC20(AaveV3OptimismAssets.sUSD_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3OptimismAssets.USDCn_UNDERLYING).allowance(
        address(AaveV3Optimism.COLLECTOR),
        MiscOptimism.AFC_SAFE
      ),
      usdcBalanceBefore
    );

    assertEq(
      IERC20(AaveV3OptimismAssets.sUSD_UNDERLYING).allowance(
        address(AaveV3Optimism.COLLECTOR),
        MiscOptimism.AFC_SAFE
      ),
      susdBalanceBefore
    );

    vm.startPrank(MiscOptimism.AFC_SAFE);
    IERC20(AaveV3OptimismAssets.USDCn_UNDERLYING).transferFrom(
      address(AaveV3Optimism.COLLECTOR),
      MiscOptimism.AFC_SAFE,
      usdcBalanceBefore
    );

    IERC20(AaveV3OptimismAssets.sUSD_UNDERLYING).transferFrom(
      address(AaveV3Optimism.COLLECTOR),
      MiscOptimism.AFC_SAFE,
      susdBalanceBefore
    );
  }

  function test_bridges() public {
    uint256 usdtCollectorBalanceBefore = IERC20(AaveV3OptimismAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    uint256 usdcCollectorBalanceBefore = IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    uint256 wbtcCollectorBalanceBefore = IERC20(AaveV3OptimismAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    assertGt(usdtCollectorBalanceBefore, 0);
    assertGt(usdcCollectorBalanceBefore, 0);
    assertGt(wbtcCollectorBalanceBefore, 0);

    vm.expectEmit(true, true, true, true, MiscOptimism.AAVE_OPT_ETH_BRIDGE);
    emit Bridge(AaveV3OptimismAssets.USDT_UNDERLYING, usdtCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscOptimism.AAVE_OPT_ETH_BRIDGE);
    emit Bridge(AaveV3OptimismAssets.USDC_UNDERLYING, usdcCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscOptimism.AAVE_OPT_ETH_BRIDGE);
    emit Bridge(AaveV3OptimismAssets.WBTC_UNDERLYING, wbtcCollectorBalanceBefore);

    executePayload(vm, address(proposal));

    uint256 usdtCollectorBalanceAfter = IERC20(AaveV3OptimismAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    uint256 usdcCollectorBalanceAfter = IERC20(AaveV3OptimismAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    uint256 wbtcCollectorBalanceAfter = IERC20(AaveV3OptimismAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Optimism.COLLECTOR)
    );

    assertEq(usdtCollectorBalanceAfter, 0);
    assertEq(usdcCollectorBalanceAfter, 0);
    assertEq(wbtcCollectorBalanceAfter, 0);
  }
}
