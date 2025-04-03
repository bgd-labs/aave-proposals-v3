// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_AprilFundingUpdate_20250328} from './AaveV3Base_AprilFundingUpdate_20250328.sol';

/**
 * @dev Test for AaveV3Base_AprilFundingUpdate_20250328
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250328_Multi_AprilFundingUpdate/AaveV3Base_AprilFundingUpdate_20250328.t.sol -vv
 */
contract AaveV3Base_AprilFundingUpdate_20250328_Test is ProtocolV3TestBase {
  AaveV3Base_AprilFundingUpdate_20250328 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 28442520);
    proposal = new AaveV3Base_AprilFundingUpdate_20250328();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_AprilFundingUpdate_20250328', AaveV3Base.POOL, address(proposal));
  }

  function test_deposit() public {
    uint256 usdcCollectorBalanceBefore = IERC20(AaveV3BaseAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );
    uint256 wethCollectorBalanceBefore = IERC20(AaveV3BaseAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );
    uint256 cbBTCCollectorBalanceBefore = IERC20(AaveV3BaseAssets.cbBTC_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );
    uint256 cbETHCollectorBalanceBefore = IERC20(AaveV3BaseAssets.cbETH_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );

    assertGt(usdcCollectorBalanceBefore, 0);
    assertGt(wethCollectorBalanceBefore, 0);
    assertGt(cbBTCCollectorBalanceBefore, 0);
    assertGt(cbETHCollectorBalanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 usdcCollectorBalanceAfter = IERC20(AaveV3BaseAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );
    uint256 wethCollectorBalanceAfter = IERC20(AaveV3BaseAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );
    uint256 cbBTCCollectorBalanceAfter = IERC20(AaveV3BaseAssets.cbBTC_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );
    uint256 cbETHCollectorBalanceAfter = IERC20(AaveV3BaseAssets.cbETH_UNDERLYING).balanceOf(
      address(AaveV3Base.COLLECTOR)
    );

    assertEq(usdcCollectorBalanceAfter, 0);
    assertEq(wethCollectorBalanceAfter, 0);
    assertEq(cbBTCCollectorBalanceAfter, 0);
    assertEq(cbETHCollectorBalanceAfter, 0);
  }
}
