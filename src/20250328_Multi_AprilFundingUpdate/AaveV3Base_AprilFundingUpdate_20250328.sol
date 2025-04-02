// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

import {IPoolExposureSteward} from './IPoolExposureSteward.sol';

/**
 * @title April Funding update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-april-funding-update/21590
 */
contract AaveV3Base_AprilFundingUpdate_20250328 is IProposalGenericExecutor {
  function execute() external {
    IPoolExposureSteward(AaveV3Base.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Base.POOL),
      AaveV3BaseAssets.USDC_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Base.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Base.POOL),
      AaveV3BaseAssets.WETH_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Base.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Base.POOL),
      AaveV3BaseAssets.cbBTC_UNDERLYING,
      type(uint256).max
    );
    IPoolExposureSteward(AaveV3Base.POOL_EXPOSURE_STEWARD).depositV3(
      address(AaveV3Base.POOL),
      AaveV3BaseAssets.cbETH_UNDERLYING,
      type(uint256).max
    );
  }
}
