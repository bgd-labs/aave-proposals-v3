// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title February Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-february-funding-update/20712
 */
contract AaveV3Avalanche_FebruaryFundingUpdate_20250120 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  uint256 public constant DAI_TO_WITHDRAW = 1_000_000 ether;

  function execute() external {
    _withdraw();
    _deposit();
  }

  function _withdraw() internal {
    AaveV3Avalanche.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Avalanche.POOL),
        underlying: AaveV2AvalancheAssets.WETHe_UNDERLYING,
        amount: IERC20(AaveV2AvalancheAssets.WETHe_A_TOKEN).balanceOf(
          address(AaveV3Avalanche.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Avalanche.COLLECTOR)
    );

    AaveV3Avalanche.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Avalanche.POOL),
        underlying: AaveV2AvalancheAssets.DAIe_UNDERLYING,
        amount: DAI_TO_WITHDRAW
      }),
      address(AaveV3Avalanche.COLLECTOR)
    );

    AaveV3Avalanche.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Avalanche.POOL),
        underlying: AaveV2AvalancheAssets.WAVAX_UNDERLYING,
        amount: IERC20(AaveV2AvalancheAssets.WAVAX_A_TOKEN).balanceOf(
          address(AaveV3Avalanche.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Avalanche.COLLECTOR)
    );
  }

  function _deposit() internal {
    AaveV3Avalanche.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Avalanche.POOL),
        underlying: AaveV3AvalancheAssets.WETHe_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Avalanche.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Avalanche.POOL),
        underlying: AaveV3AvalancheAssets.DAIe_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Avalanche.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Avalanche.POOL),
        underlying: AaveV3AvalancheAssets.WAVAX_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Avalanche.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Avalanche.POOL),
        underlying: AaveV3AvalancheAssets.USDt_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Avalanche.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Avalanche.POOL),
        underlying: AaveV3AvalancheAssets.USDC_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Avalanche.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Avalanche.POOL),
        underlying: AaveV3AvalancheAssets.BTCb_UNDERLYING,
        amount: type(uint256).max
      })
    );
  }
}
