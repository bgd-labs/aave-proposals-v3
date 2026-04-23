// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title April Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447
 */
contract AaveV3Arbitrum_AprilFundingUpdate_20260423 is IProposalGenericExecutor {
  uint256 public constant WETH_ALLOWANCE = 1_350 ether;
  uint256 public constant weETH_ALLOWANCE = 65 ether;

  function execute() external {
    AaveV3Arbitrum.COLLECTOR.approve(
      IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN),
      MiscArbitrum.AFC_SAFE,
      WETH_ALLOWANCE
    );

    AaveV3Arbitrum.COLLECTOR.approve(
      IERC20(AaveV3ArbitrumAssets.weETH_A_TOKEN),
      MiscArbitrum.AFC_SAFE,
      weETH_ALLOWANCE
    );
  }
}
