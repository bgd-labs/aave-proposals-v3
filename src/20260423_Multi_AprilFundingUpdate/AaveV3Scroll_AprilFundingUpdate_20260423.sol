// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title April Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447
 */
contract AaveV3Scroll_AprilFundingUpdate_20260423 is IProposalGenericExecutor {
  uint256 public constant WETH_ALLOWANCE = 175 ether;
  uint256 public constant USDC_ALLOWANCE = 101_000e6;

  function execute() external {
    AaveV3Scroll.COLLECTOR.approve(
      IERC20(AaveV3ScrollAssets.WETH_A_TOKEN),
      MiscScroll.AFC_SAFE,
      WETH_ALLOWANCE
    );

    AaveV3Scroll.COLLECTOR.approve(
      IERC20(AaveV3ScrollAssets.USDC_A_TOKEN),
      MiscScroll.AFC_SAFE,
      USDC_ALLOWANCE
    );
  }
}
