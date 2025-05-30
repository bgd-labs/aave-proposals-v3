// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title May Funding Part B
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x4dfc398fabb63305900572dff38b2ff8e104b0710077f6b7e48049de173d186b
 * - Discussion: https://governance.aave.com/t/arfc-may-2025-funding-update/21906/5
 */
contract AaveV3Base_MayFundingPartB_20250524 is IProposalGenericExecutor {
  /// https://basescan.org/address/0x22740deBa78d5a0c24C58C740e3715ec29de1bFa
  address public constant AFC_SAFE = 0x22740deBa78d5a0c24C58C740e3715ec29de1bFa;

  function execute() external {
    AaveV3Base.COLLECTOR.approve(
      IERC20(AaveV3BaseAssets.USDC_A_TOKEN),
      AFC_SAFE,
      IERC20(AaveV3BaseAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Base.COLLECTOR))
    );

    AaveV3Base.COLLECTOR.approve(
      IERC20(AaveV3BaseAssets.cbBTC_A_TOKEN),
      AFC_SAFE,
      IERC20(AaveV3BaseAssets.cbBTC_A_TOKEN).balanceOf(address(AaveV3Base.COLLECTOR))
    );

    AaveV3Base.COLLECTOR.approve(
      IERC20(AaveV3BaseAssets.USDbC_A_TOKEN),
      AFC_SAFE,
      IERC20(AaveV3BaseAssets.USDbC_A_TOKEN).balanceOf(address(AaveV3Base.COLLECTOR))
    );
  }
}
