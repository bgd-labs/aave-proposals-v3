// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LiquidateRsETHArbitrumSetup, LiquidateRsETHConstants} from './LiquidateRsETHArbitrumSetup.sol';

/**
 * @title Liquidate rsETH position - Arbitrum user 6
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/rseth-incident-report-april-20-2026/24580
 */
contract AaveV3Arbitrum_LiquidateRsETHPositionUser6_20260423 is LiquidateRsETHArbitrumSetup {
  function getUser() public pure override returns (address) {
    return LiquidateRsETHConstants.ARB_USER_6;
  }

  function wethScaledDebt() public pure override returns (uint256) {
    return LiquidateRsETHConstants.ARB_USER_6_SCALED_WETH_DEBT;
  }
}
