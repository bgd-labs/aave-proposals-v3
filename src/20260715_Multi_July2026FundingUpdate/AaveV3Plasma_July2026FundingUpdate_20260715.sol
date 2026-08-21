// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {PercentageMath} from 'aave-v3-origin/contracts/protocol/libraries/math/PercentageMath.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title July 2026 Funding Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x2f86020fc038694a5c4738e3982e4fa92eb315aaa4d3ce2fa2be2a5808a9280b
 * - Discussion: https://governance.aave.com/t/direct-to-aip-july-2026-funding-update/25277
 */
contract AaveV3Plasma_July2026FundingUpdate_20260715 is IProposalGenericExecutor {
  using PercentageMath for uint256;

  uint256 public constant USDT_ALLOWANCE = 3_000_000e6;

  // https://plasmascan.to/address/0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e
  address public constant AHAB_SAFE = 0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e;

  /// @dev Allowances are set to 100.10% of the balance, the extra 0.10% covering interest accrued
  ///      between execution and the AFC pulling the balance.
  uint256 public constant ALLOWANCE_BUFFER_PERCENT = 100_10;

  function execute() external {
    _smallAllowances();
    _replaceAfcSafeUSDTAllowanceWithAhabSafeAllowance();
  }

  function _smallAllowances() internal {
    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.PT_sUSDE_9APR2026_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      IERC20(AaveV3PlasmaAssets.PT_sUSDE_9APR2026_A_TOKEN)
        .balanceOf(address(AaveV3Plasma.COLLECTOR))
        .percentMul(ALLOWANCE_BUFFER_PERCENT)
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.PT_USDe_15JAN2026_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      IERC20(AaveV3PlasmaAssets.PT_USDe_15JAN2026_A_TOKEN)
        .balanceOf(address(AaveV3Plasma.COLLECTOR))
        .percentMul(ALLOWANCE_BUFFER_PERCENT)
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.PT_sUSDE_18JUN2026_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      IERC20(AaveV3PlasmaAssets.PT_sUSDE_18JUN2026_A_TOKEN)
        .balanceOf(address(AaveV3Plasma.COLLECTOR))
        .percentMul(ALLOWANCE_BUFFER_PERCENT)
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.PT_sUSDE_15JAN2026_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      IERC20(AaveV3PlasmaAssets.PT_sUSDE_15JAN2026_A_TOKEN)
        .balanceOf(address(AaveV3Plasma.COLLECTOR))
        .percentMul(ALLOWANCE_BUFFER_PERCENT)
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.PT_USDe_9APR2026_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      IERC20(AaveV3PlasmaAssets.PT_USDe_9APR2026_A_TOKEN)
        .balanceOf(address(AaveV3Plasma.COLLECTOR))
        .percentMul(ALLOWANCE_BUFFER_PERCENT)
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.PT_USDe_18JUN2026_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      IERC20(AaveV3PlasmaAssets.PT_USDe_18JUN2026_A_TOKEN)
        .balanceOf(address(AaveV3Plasma.COLLECTOR))
        .percentMul(ALLOWANCE_BUFFER_PERCENT)
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.WETH_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      IERC20(AaveV3PlasmaAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Plasma.COLLECTOR)).percentMul(
        ALLOWANCE_BUFFER_PERCENT
      )
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.weETH_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      IERC20(AaveV3PlasmaAssets.weETH_A_TOKEN)
        .balanceOf(address(AaveV3Plasma.COLLECTOR))
        .percentMul(ALLOWANCE_BUFFER_PERCENT)
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.sUSDe_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      IERC20(AaveV3PlasmaAssets.sUSDe_A_TOKEN)
        .balanceOf(address(AaveV3Plasma.COLLECTOR))
        .percentMul(ALLOWANCE_BUFFER_PERCENT)
    );
  }

  function _replaceAfcSafeUSDTAllowanceWithAhabSafeAllowance() internal {
    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      0
    );

    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN),
      AHAB_SAFE,
      USDT_ALLOWANCE
    );
  }
}
