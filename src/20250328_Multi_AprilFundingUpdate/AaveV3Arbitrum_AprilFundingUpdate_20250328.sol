// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title April Funding update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-funding-update/21590
 */
contract AaveV3Arbitrum_AprilFundingUpdate_20250328 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  function execute() external {
    AaveV3Arbitrum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.USDCn_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Arbitrum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.WETH_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Arbitrum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.USDT_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Arbitrum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.WBTC_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Arbitrum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.ARB_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Arbitrum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.wstETH_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Arbitrum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.GHO_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Arbitrum.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.LINK_UNDERLYING,
        amount: type(uint256).max
      })
    );
  }
}
