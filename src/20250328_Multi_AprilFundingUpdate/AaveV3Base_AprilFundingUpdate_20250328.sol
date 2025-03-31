// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title April Funding update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-funding-update/21590
 */
contract AaveV3Base_AprilFundingUpdate_20250328 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  function execute() external {
    AaveV3Base.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Base.POOL),
        underlying: AaveV3BaseAssets.USDC_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Base.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Base.POOL),
        underlying: AaveV3BaseAssets.WETH_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Base.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Base.POOL),
        underlying: AaveV3BaseAssets.cbBTC_UNDERLYING,
        amount: type(uint256).max
      })
    );
    AaveV3Base.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Base.POOL),
        underlying: AaveV3BaseAssets.cbETH_UNDERLYING,
        amount: type(uint256).max
      })
    );
  }
}
