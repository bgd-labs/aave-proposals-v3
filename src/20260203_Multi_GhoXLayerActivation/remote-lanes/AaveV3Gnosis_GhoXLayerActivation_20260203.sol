// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {AaveV3GHOLane} from '../../helpers/gho-launch/AaveV3GHOLane.sol';
import {GhoCCIPChains} from '../../helpers/gho-launch/constants/GhoCCIPChains.sol';
/**
 * @title Gnosis<>X-Layer GHO CCIP Lane
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-x-layer-set-aci-as-emissions-manager-for-rewards/23178
 */
contract AaveV3Gnosis_GhoXLayerActivation_20260203 is AaveV3GHOLane {
  constructor() AaveV3GHOLane(GhoCCIPChains.GNOSIS()) {}
  function lanesToAdd()
    public
    pure
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    return _asArray(_asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.XLAYER()));
  }
}
