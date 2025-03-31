// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {ArbSysMock} from 'aave-helpers/tests/bridges/arbitrum/ArbSysMock.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_AprilFundingUpdate_20250328} from './AaveV3Arbitrum_AprilFundingUpdate_20250328.sol';

/**
 * @dev Test for AaveV3Arbitrum_AprilFundingUpdate_20250328
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20250328_Multi_AprilFundingUpdate/AaveV3Arbitrum_AprilFundingUpdate_20250328.t.sol -vv
 */
contract AaveV3Arbitrum_AprilFundingUpdate_20250328_Test is ProtocolV3TestBase {
  event Bridge(address indexed token, uint256 amount);

  AaveV3Arbitrum_AprilFundingUpdate_20250328 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 320457503);
    proposal = new AaveV3Arbitrum_AprilFundingUpdate_20250328();

    ArbSysMock arbsys = new ArbSysMock();
    vm.etch(address(0x0000000000000000000000000000000000000064), address(arbsys).code);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_AprilFundingUpdate_20250328',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_deposit() public {
    uint256 usdcnCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.USDCn_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 wethCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 usdtCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 wBTCCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 arbCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 wstETHCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.wstETH_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 ghoCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 linkCollectorBalanceBefore = IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    assertGt(usdcnCollectorBalanceBefore, 0);
    assertGt(wethCollectorBalanceBefore, 0);
    assertGt(usdtCollectorBalanceBefore, 0);
    assertGt(wBTCCollectorBalanceBefore, 0);
    assertGt(arbCollectorBalanceBefore, 0);
    assertGt(wstETHCollectorBalanceBefore, 0);
    assertGt(ghoCollectorBalanceBefore, 0);
    assertGt(linkCollectorBalanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 usdcnCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.USDCn_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 wethCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 usdtCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 wBTCCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 arbCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 wstETHCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.wstETH_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 ghoCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );
    uint256 linkCollectorBalanceAfter = IERC20(AaveV3ArbitrumAssets.LINK_UNDERLYING).balanceOf(
      address(AaveV3Arbitrum.COLLECTOR)
    );

    assertEq(usdcnCollectorBalanceAfter, 0);
    assertEq(wethCollectorBalanceAfter, 0);
    assertEq(usdtCollectorBalanceAfter, 0);
    assertEq(wBTCCollectorBalanceAfter, 0);
    assertEq(arbCollectorBalanceAfter, 0);
    assertEq(wstETHCollectorBalanceAfter, 0);
    assertEq(ghoCollectorBalanceAfter, 0);
    assertEq(linkCollectorBalanceAfter, 0);
  }
}
