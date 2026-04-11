// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_DeprecateAaveV3Scroll_20260411} from './AaveV3Scroll_DeprecateAaveV3Scroll_20260411.sol';

/**
 * @dev Test for AaveV3Scroll_DeprecateAaveV3Scroll_20260411
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260411_AaveV3Scroll_DeprecateAaveV3Scroll/AaveV3Scroll_DeprecateAaveV3Scroll_20260411.t.sol -vv
 */
contract AaveV3Scroll_DeprecateAaveV3Scroll_20260411_Test is ProtocolV3TestBase {
  AaveV3Scroll_DeprecateAaveV3Scroll_20260411 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 33271801);
    proposal = new AaveV3Scroll_DeprecateAaveV3Scroll_20260411();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest({
      reportName: 'AaveV3Scroll_DeprecateAaveV3Scroll_20260411',
      pool: AaveV3Scroll.POOL,
      payload: address(proposal),
      runE2E: false,
      runSeatbelt: false
    });
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
    address withdrawer = 0x90eB541e1a431D8a30ED85A77675D1F001128cb5;
    address repayer = 0xa74e3B7346fDbbC17c2A1Fa7aa5D436cF3730b20;
    address repayerSCR = 0xeA4447A04D21A9b10541C3d973F5C48359Ea1D81;
    address repayerWeETH = 0x2193A7B32fBF841Db107958Da6B1CE7c39503B9E;

    // Verify withdrawer has all collateral deposited
    assertGt(IERC20(AaveV3ScrollAssets.WETH_A_TOKEN).balanceOf(withdrawer), 0, 'No aWETH');
    assertGt(IERC20(AaveV3ScrollAssets.USDC_A_TOKEN).balanceOf(withdrawer), 0, 'No aUSDC');
    assertGt(IERC20(AaveV3ScrollAssets.wstETH_A_TOKEN).balanceOf(withdrawer), 0, 'No awstETH');
    assertGt(IERC20(AaveV3ScrollAssets.weETH_A_TOKEN).balanceOf(withdrawer), 0, 'No aweETH');
    assertGt(IERC20(AaveV3ScrollAssets.SCR_A_TOKEN).balanceOf(withdrawer), 0, 'No aSCR');

    // Verify repayers have corresponding debts
    assertGt(IERC20(AaveV3ScrollAssets.WETH_V_TOKEN).balanceOf(repayer), 0, 'No WETH debt');
    assertGt(IERC20(AaveV3ScrollAssets.USDC_V_TOKEN).balanceOf(repayer), 0, 'No USDC debt');
    assertGt(IERC20(AaveV3ScrollAssets.wstETH_V_TOKEN).balanceOf(repayer), 0, 'No wstETH debt');
    assertGt(IERC20(AaveV3ScrollAssets.SCR_V_TOKEN).balanceOf(repayerSCR), 0, 'No SCR debt');
    assertGt(IERC20(AaveV3ScrollAssets.weETH_V_TOKEN).balanceOf(repayerWeETH), 0, 'No weETH debt');

    executePayload(vm, address(proposal), AaveV3Scroll.POOL);

    // Repay WETH, USDC, wstETH debts
    _repayDebt(repayer, AaveV3ScrollAssets.WETH_UNDERLYING, AaveV3ScrollAssets.WETH_V_TOKEN);
    _repayDebt(repayer, AaveV3ScrollAssets.USDC_UNDERLYING, AaveV3ScrollAssets.USDC_V_TOKEN);
    _repayDebt(repayer, AaveV3ScrollAssets.wstETH_UNDERLYING, AaveV3ScrollAssets.wstETH_V_TOKEN);

    // Repay SCR debt
    _repayDebt(repayerSCR, AaveV3ScrollAssets.SCR_UNDERLYING, AaveV3ScrollAssets.SCR_V_TOKEN);

    // Repay weETH debt
    _repayDebt(repayerWeETH, AaveV3ScrollAssets.weETH_UNDERLYING, AaveV3ScrollAssets.weETH_V_TOKEN);

    // Withdraw all supplies
    _withdraw(withdrawer, AaveV3ScrollAssets.WETH_UNDERLYING, AaveV3ScrollAssets.WETH_A_TOKEN);
    _withdraw(withdrawer, AaveV3ScrollAssets.USDC_UNDERLYING, AaveV3ScrollAssets.USDC_A_TOKEN);
    _withdraw(withdrawer, AaveV3ScrollAssets.wstETH_UNDERLYING, AaveV3ScrollAssets.wstETH_A_TOKEN);
    _withdraw(withdrawer, AaveV3ScrollAssets.weETH_UNDERLYING, AaveV3ScrollAssets.weETH_A_TOKEN);
    _withdraw(withdrawer, AaveV3ScrollAssets.SCR_UNDERLYING, AaveV3ScrollAssets.SCR_A_TOKEN);
  }

  function _repayDebt(address user, address underlying, address vToken) internal {
    uint256 debt = IERC20(vToken).balanceOf(user);
    assertGt(debt, 0, 'No debt to repay');
    deal2(underlying, user, debt);
    vm.startPrank(user);
    IERC20(underlying).approve(address(AaveV3Scroll.POOL), type(uint256).max);
    AaveV3Scroll.POOL.repay(underlying, type(uint256).max, 2, user);
    vm.stopPrank();
    assertEq(IERC20(vToken).balanceOf(user), 0, 'Debt not fully repaid');
  }

  function _withdraw(address user, address underlying, address aToken) internal {
    uint256 balance = IERC20(aToken).balanceOf(user);
    assertGt(balance, 0, 'No aToken balance');
    vm.prank(user);
    AaveV3Scroll.POOL.withdraw(underlying, type(uint256).max, user);
    assertGt(IERC20(underlying).balanceOf(user), 0, 'No underlying after withdraw');
  }
}
