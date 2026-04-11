// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_OffboardInstance_20260410} from './AaveV3Scroll_OffboardInstance_20260410.sol';

/**
 * @dev Test for AaveV3Scroll_OffboardInstance_20260410
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260410_AaveV3Scroll_OffboardInstance/AaveV3Scroll_OffboardInstance_20260410.t.sol -vv
 */
contract AaveV3Scroll_OffboardInstance_20260410_Test is ProtocolV3TestBase {
  AaveV3Scroll_OffboardInstance_20260410 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 33262428);
    proposal = new AaveV3Scroll_OffboardInstance_20260410();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_OffboardInstance_20260410',
      AaveV3Scroll.POOL,
      address(proposal),
      false,
      true
    );
  }

  function test_frozenFlag() public {
    executePayload(vm, address(proposal), AaveV3Scroll.POOL);
    ReserveConfig[] memory configs = _getReservesConfigs(AaveV3Scroll.POOL);
    for (uint256 i = 0; i < configs.length; i++) {
      assertTrue(
        configs[i].isFrozen,
        string.concat('Reserve ', vm.toString(configs[i].underlying), " isn't frozen")
      );
    }
  }

  function test_reserveFactor() public {
    executePayload(vm, address(proposal), AaveV3Scroll.POOL);
    ReserveConfig[] memory configs = _getReservesConfigs(AaveV3Scroll.POOL);
    for (uint256 i = 0; i < configs.length; i++) {
      if (configs[i].underlying == AaveV3ScrollAssets.WETH_UNDERLYING) {
        assertEq(configs[i].reserveFactor, 50_00, 'WETH reserve factor should remain 50%');
      } else {
        assertEq(
          configs[i].reserveFactor,
          85_00,
          string.concat(
            'Reserve ',
            vm.toString(configs[i].underlying),
            ' should have 85% reserve factor'
          )
        );
      }
    }
  }

  function test_ltvZeroAndPendingLtv() public {
    // Record LTV values before proposal execution
    ReserveConfig[] memory configsBefore = _getReservesConfigs(AaveV3Scroll.POOL);
    uint256 wethLtv = _findReserveConfig(configsBefore, AaveV3ScrollAssets.WETH_UNDERLYING).ltv;
    uint256 usdcLtv = _findReserveConfig(configsBefore, AaveV3ScrollAssets.USDC_UNDERLYING).ltv;
    uint256 wstethLtv = _findReserveConfig(configsBefore, AaveV3ScrollAssets.wstETH_UNDERLYING).ltv;
    uint256 weethLtv = _findReserveConfig(configsBefore, AaveV3ScrollAssets.weETH_UNDERLYING).ltv;

    executePayload(vm, address(proposal), AaveV3Scroll.POOL);

    // LTV should be 0 for all reserves after freezing
    ReserveConfig[] memory configsAfter = _getReservesConfigs(AaveV3Scroll.POOL);
    for (uint256 i = 0; i < configsAfter.length; i++) {
      assertEq(configsAfter[i].ltv, 0, string.concat(configsAfter[i].symbol, ' LTV should be 0'));
    }

    // Pending LTV should match the original LTV for assets that had non-zero LTV
    assertEq(
      AaveV3Scroll.POOL_CONFIGURATOR.getPendingLtv(AaveV3ScrollAssets.WETH_UNDERLYING),
      wethLtv,
      'WETH pending LTV mismatch'
    );
    assertEq(
      AaveV3Scroll.POOL_CONFIGURATOR.getPendingLtv(AaveV3ScrollAssets.USDC_UNDERLYING),
      usdcLtv,
      'USDC pending LTV mismatch'
    );
    assertEq(
      AaveV3Scroll.POOL_CONFIGURATOR.getPendingLtv(AaveV3ScrollAssets.wstETH_UNDERLYING),
      wstethLtv,
      'wstETH pending LTV mismatch'
    );
    assertEq(
      AaveV3Scroll.POOL_CONFIGURATOR.getPendingLtv(AaveV3ScrollAssets.weETH_UNDERLYING),
      weethLtv,
      'weETH pending LTV mismatch'
    );
  }

  function test_usersCanRepayAndWithdrawPostExecution() public {
    ReserveConfig[] memory configs = _getReservesConfigs(AaveV3Scroll.POOL);
    address user = makeAddr('USER');

    // Supply all reserves
    uint256[5] memory supplyAmounts = [uint256(100 ether), 10_000e6, 1 ether, 1 ether, 100e18];
    address[5] memory underlyings = [
      AaveV3ScrollAssets.WETH_UNDERLYING,
      AaveV3ScrollAssets.USDC_UNDERLYING,
      AaveV3ScrollAssets.wstETH_UNDERLYING,
      AaveV3ScrollAssets.weETH_UNDERLYING,
      AaveV3ScrollAssets.SCR_UNDERLYING
    ];

    vm.startPrank(user);
    for (uint256 i = 0; i < 5; ++i) {
      deal2(underlyings[i], user, supplyAmounts[i]);
      IERC20(underlyings[i]).approve(address(AaveV3Scroll.POOL), supplyAmounts[i]);
      AaveV3Scroll.POOL.supply(underlyings[i], supplyAmounts[i], user, 0);
    }

    // Borrow from every borrowable reserve
    uint256 borrowableCount;
    for (uint256 i = 0; i < configs.length; ++i) {
      if (!configs[i].borrowingEnabled) continue;
      uint256 borrowAmount = 10 ** configs[i].decimals; // borrow 1 unit
      AaveV3Scroll.POOL.borrow(configs[i].underlying, borrowAmount, 2, 0, user);
      ++borrowableCount;
    }
    vm.stopPrank();
    assertGt(borrowableCount, 0, 'Should have at least one borrowable reserve');

    executePayload(vm, address(proposal), AaveV3Scroll.POOL);

    // Repay all borrows
    ReserveConfig[] memory configsAfter = _getReservesConfigs(AaveV3Scroll.POOL);
    vm.startPrank(user);

    for (uint256 i = 0; i < configsAfter.length; ++i) {
      uint256 debt = IERC20(configsAfter[i].variableDebtToken).balanceOf(user);
      if (debt > 0) {
        deal2(configsAfter[i].underlying, user, debt * 2);
        IERC20(configsAfter[i].underlying).approve(address(AaveV3Scroll.POOL), type(uint256).max);
        AaveV3Scroll.POOL.repay(configsAfter[i].underlying, type(uint256).max, 2, user);
        assertEq(
          IERC20(configsAfter[i].variableDebtToken).balanceOf(user),
          0,
          string.concat(configsAfter[i].symbol, ': debt should be 0 after repay')
        );
      }
    }

    // Withdraw all supplies
    for (uint256 i = 0; i < configsAfter.length; ++i) {
      uint256 aTokenBalance = IERC20(configsAfter[i].aToken).balanceOf(user);
      assertGt(
        aTokenBalance,
        0,
        string.concat(configsAfter[i].symbol, ': should have aToken balance')
      );
      AaveV3Scroll.POOL.withdraw(configsAfter[i].underlying, type(uint256).max, user);
      assertGt(
        IERC20(configsAfter[i].underlying).balanceOf(user),
        0,
        string.concat(configsAfter[i].symbol, ': should have underlying after withdraw')
      );
    }

    vm.stopPrank();
  }
}
