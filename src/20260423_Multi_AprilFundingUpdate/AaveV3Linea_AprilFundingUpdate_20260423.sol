// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Linea, AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';
import {MiscLinea} from 'aave-address-book/MiscLinea.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title April Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447
 */
contract AaveV3Linea_AprilFundingUpdate_20260423 is IProposalGenericExecutor {
  uint256 public constant WETH_ALLOWANCE = 190 ether;
  uint256 public constant USDC_ALLOWANCE = 220_000e6;
  uint256 public constant USDT_ALLOWANCE = 140_000e6;

  function execute() external {
    AaveV3Linea.COLLECTOR.approve(
      IERC20(AaveV3LineaAssets.WETH_A_TOKEN),
      MiscLinea.AFC_SAFE,
      WETH_ALLOWANCE
    );

    AaveV3Linea.COLLECTOR.approve(
      IERC20(AaveV3LineaAssets.USDC_A_TOKEN),
      MiscLinea.AFC_SAFE,
      USDC_ALLOWANCE
    );

    AaveV3Linea.COLLECTOR.approve(
      IERC20(AaveV3LineaAssets.USDT_A_TOKEN),
      MiscLinea.AFC_SAFE,
      USDT_ALLOWANCE
    );
  }
}
