// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title DeprecateAaveV3Scroll
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-aave-v3-scroll-instance-deprecation/24432
 */
contract AaveV3Scroll_DeprecateAaveV3Scroll_20260411 is IProposalGenericExecutor {
  function execute() external override {
    // Freeze all reserves
    AaveV3Scroll.POOL_CONFIGURATOR.setReserveFreeze(AaveV3ScrollAssets.WETH_UNDERLYING, true);
    AaveV3Scroll.POOL_CONFIGURATOR.setReserveFreeze(AaveV3ScrollAssets.USDC_UNDERLYING, true);
    AaveV3Scroll.POOL_CONFIGURATOR.setReserveFreeze(AaveV3ScrollAssets.wstETH_UNDERLYING, true);
    AaveV3Scroll.POOL_CONFIGURATOR.setReserveFreeze(AaveV3ScrollAssets.weETH_UNDERLYING, true);
    AaveV3Scroll.POOL_CONFIGURATOR.setReserveFreeze(AaveV3ScrollAssets.SCR_UNDERLYING, true);

    // Increase Reserve Factor from 50% to 85% in all reserves except WETH
    AaveV3Scroll.POOL_CONFIGURATOR.setReserveFactor(AaveV3ScrollAssets.USDC_UNDERLYING, 85_00);
    AaveV3Scroll.POOL_CONFIGURATOR.setReserveFactor(AaveV3ScrollAssets.wstETH_UNDERLYING, 85_00);
    AaveV3Scroll.POOL_CONFIGURATOR.setReserveFactor(AaveV3ScrollAssets.weETH_UNDERLYING, 85_00);
    AaveV3Scroll.POOL_CONFIGURATOR.setReserveFactor(AaveV3ScrollAssets.SCR_UNDERLYING, 85_00);
  }
}
