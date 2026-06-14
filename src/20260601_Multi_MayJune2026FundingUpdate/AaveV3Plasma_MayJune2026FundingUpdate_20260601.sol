// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Plasma, AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title May/June 2026 Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-may-june-2026-funding-update/25000
 */
contract AaveV3Plasma_MayJune2026FundingUpdate_20260601 is IProposalGenericExecutor {
  uint256 public constant AFC_SAFE_A_USDT0_ALLOWANCE = 3_000_000e6; // 3M aUSDT0, 6 decimals

  function execute() external {
    AaveV3Plasma.COLLECTOR.approve(
      IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN),
      MiscPlasma.AFC_SAFE,
      AFC_SAFE_A_USDT0_ALLOWANCE
    );
  }
}
