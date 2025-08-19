// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {AaveV3GHOLane} from '../abstraction/AaveV3GHOLane.sol';
import {GhoCCIPChains} from '../abstraction/constants/GhoCCIPChains.sol';

/**
 * @title Base<>Ink GHO CCIP Lane
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664
 */
contract Base_Ink_AaveV3GHOLane_20250814 is AaveV3GHOLane {
  constructor() AaveV3GHOLane(GhoCCIPChains.BASE()) {}

  function lanesToAdd()
    public
    pure
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    return _asArray(_asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.INK()));
  }
}
