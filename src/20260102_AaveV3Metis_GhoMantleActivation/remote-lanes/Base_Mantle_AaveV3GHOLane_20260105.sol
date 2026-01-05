// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {AaveV3GHOLane} from '../../helpers/gho-launch/AaveV3GHOLane.sol';
import {GhoCCIPChains} from '../../helpers/gho-launch/constants/GhoCCIPChains.sol';

/**
 * @title Base<>Mantle GHO CCIP Lane
 * @author TokenLogic
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract Base_Mantle_AaveV3GHOLane_20250921 is AaveV3GHOLane {
  constructor() AaveV3GHOLane(GhoCCIPChains.BASE()) {}

  function lanesToAdd()
    public
    pure
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    return _asArray(_asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.MANTLE()));
  }
}
