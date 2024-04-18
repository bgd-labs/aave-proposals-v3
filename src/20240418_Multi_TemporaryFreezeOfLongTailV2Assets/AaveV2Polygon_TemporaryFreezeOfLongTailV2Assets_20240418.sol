// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Temporary Freeze of Long-Tail V2 Assets
 * @author Chaos Labs
 * - Discussion: https://governance.aave.com/t/arfc-temporary-freeze-of-long-tail-v2-assets/17403
 */
contract AaveV2Polygon_TemporaryFreezeOfLongTailV2Assets_20240418 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Polygon.POOL_CONFIGURATOR.freezeReserve(AaveV2PolygonAssets.AAVE_UNDERLYING);
  }
}
