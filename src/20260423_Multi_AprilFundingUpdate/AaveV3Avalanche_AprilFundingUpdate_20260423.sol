// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title April Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-april-2026-funding-update/24447
 */
contract AaveV3Avalanche_AprilFundingUpdate_20260423 is IProposalGenericExecutor {
  uint256 public constant USDT_V3_ALLOWANCE = 1_550_000e6;
  uint256 public constant USDT_V2_ALLOWANCE = 650_000e6;

  uint256 public constant USDC_V3_ALLOWANCE = 3_500_000e6;
  uint256 public constant USDC_V2_ALLOWANCE = 2_250_000e6;

  uint256 public constant DAI_ALLOWANCE = 2_750_000 ether;
  uint256 public constant WETH_ALLOWANCE = 335 ether;
  uint256 public constant aEthWETH_ALLOWANCE = 8 ether;

  uint256 public constant WAVAX_ALLOWANCE = 118_000 ether;
  uint256 public constant BTC_ALLOWANCE = 4e8;

  function execute() external {
    AaveV3Avalanche.COLLECTOR.approve(
      IERC20(AaveV3AvalancheAssets.USDt_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      USDT_V3_ALLOWANCE
    );

    AaveV2Avalanche.COLLECTOR.approve(
      IERC20(AaveV2AvalancheAssets.USDTe_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      USDT_V2_ALLOWANCE
    );

    AaveV3Avalanche.COLLECTOR.approve(
      IERC20(AaveV3AvalancheAssets.USDC_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      USDC_V3_ALLOWANCE
    );

    AaveV2Avalanche.COLLECTOR.approve(
      IERC20(AaveV2AvalancheAssets.USDCe_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      USDC_V2_ALLOWANCE
    );

    AaveV3Avalanche.COLLECTOR.approve(
      IERC20(AaveV3AvalancheAssets.DAIe_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      DAI_ALLOWANCE
    );

    AaveV3Avalanche.COLLECTOR.approve(
      IERC20(AaveV3AvalancheAssets.WETHe_UNDERLYING),
      MiscAvalanche.AFC_SAFE,
      WETH_ALLOWANCE
    );

    AaveV3Avalanche.COLLECTOR.approve(
      IERC20(AaveV3AvalancheAssets.WETHe_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      aEthWETH_ALLOWANCE
    );

    AaveV3Avalanche.COLLECTOR.approve(
      IERC20(AaveV3AvalancheAssets.WAVAX_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      WAVAX_ALLOWANCE
    );

    AaveV3Avalanche.COLLECTOR.approve(
      IERC20(AaveV3AvalancheAssets.BTCb_A_TOKEN),
      MiscAvalanche.AFC_SAFE,
      BTC_ALLOWANCE
    );
  }
}
