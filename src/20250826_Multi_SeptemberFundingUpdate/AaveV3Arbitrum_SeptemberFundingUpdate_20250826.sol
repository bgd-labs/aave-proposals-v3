// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title September Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-september-2025-funding-update/22915
 */
contract AaveV3Arbitrum_SeptemberFundingUpdate_20250826 is IProposalGenericExecutor {
  uint256 public constant ARB_AMOUNT = 234_000 ether;

  function execute() external {
    AaveV3Arbitrum.COLLECTOR.approve(
      IERC20(AaveV3ArbitrumAssets.ARB_UNDERLYING),
      MiscArbitrum.APE_SAFE,
      ARB_AMOUNT
    );
  }
}
