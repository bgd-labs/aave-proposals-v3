// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title September Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915
 */
contract AaveV2Avalanche_SeptemberFundingUpdate_20250826 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Avalanche.COLLECTOR.approve(
      IERC20(AaveV2AvalancheAssets.USDCe_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      IERC20(AaveV2AvalancheAssets.USDCe_A_TOKEN).balanceOf(address(AaveV2Avalanche.COLLECTOR))
    );

    AaveV2Avalanche.COLLECTOR.approve(
      IERC20(AaveV2AvalancheAssets.USDTe_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      IERC20(AaveV2AvalancheAssets.USDTe_A_TOKEN).balanceOf(address(AaveV2Avalanche.COLLECTOR))
    );

    AaveV2Avalanche.COLLECTOR.approve(
      IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      IERC20(AaveV2AvalancheAssets.DAIe_A_TOKEN).balanceOf(address(AaveV2Avalanche.COLLECTOR))
    );
  }
}
