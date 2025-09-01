// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {AaveV3GHOLane} from '../../helpers/gho-launch/AaveV3GHOLane.sol';
import {GhoCCIPChains} from '../../helpers/gho-launch/constants/GhoCCIPChains.sol';

/**
 * @title Avalanche<>Ink GHO CCIP Lane
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xf066b8a7b1c0f3d4edff72a047809e3e1f57578d2335fd769e23561a25efb795
 */
contract Avalanche_Ink_AaveV3GHOLane_20250814 is AaveV3GHOLane {
  constructor() AaveV3GHOLane(GhoCCIPChains.AVALANCHE()) {}

  function lanesToAdd()
    public
    pure
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    return _asArray(_asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.INK()));
  }
}
