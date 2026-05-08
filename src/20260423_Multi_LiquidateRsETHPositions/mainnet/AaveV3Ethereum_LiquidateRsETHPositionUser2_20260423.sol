// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LiquidateRsETHEthereumSetup, LiquidateRsETHConstants} from './LiquidateRsETHEthereumSetup.sol';

/**
 * @title Liquidate rsETH position - Ethereum user 2
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/rseth-incident-report-april-20-2026/24580
 */
contract AaveV3Ethereum_LiquidateRsETHPositionUser2_20260423 is LiquidateRsETHEthereumSetup {
  function getUser() public pure override returns (address) {
    return LiquidateRsETHConstants.ETH_USER_2;
  }

  function wethScaledDebt() public pure override returns (uint256) {
    return LiquidateRsETHConstants.ETH_USER_2_SCALED_WETH_DEBT;
  }
}
