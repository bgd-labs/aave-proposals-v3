// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
/**
 * @title LT/LTV Reductions on Aave V2 Stablecoins
 * @author ChaosLabs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe3a29b7d6d936a22ee340811f842a29e4be654e08972f53f43dde7748c722195
 * - Discussion: https://governance.aave.com/t/arfc-lt-ltv-reductions-on-aave-v2-stablecoins/17508
 */
contract AaveV2Polygon_LTLTVReductionsOnAaveV2Stablecoins_20240510 is IProposalGenericExecutor {
  function execute() external {
    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      75_00,
      84_50,
      105_00
    );
  }
}
