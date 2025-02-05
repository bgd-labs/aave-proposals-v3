// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title February Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-february-funding-update/20712
 */
contract AaveV3Optimism_FebruaryFundingUpdate_20250120 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  function execute() external {
    AaveV3Optimism.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.USDC_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Optimism.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.USDT_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Optimism.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Optimism.POOL),
        underlying: AaveV3OptimismAssets.WETH_UNDERLYING,
        amount: type(uint256).max
      })
    );
  }
}
