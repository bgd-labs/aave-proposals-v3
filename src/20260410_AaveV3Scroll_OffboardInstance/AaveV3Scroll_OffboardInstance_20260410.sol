// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';

/**
 * @title Offboard Aave V3 Scroll Instance
 * @author Aave Labs
 * - Snapshot: direct-to-aip
 * - Discussion: todo
 */
contract AaveV3Scroll_OffboardInstance_20260410 is IProposalGenericExecutor {
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
