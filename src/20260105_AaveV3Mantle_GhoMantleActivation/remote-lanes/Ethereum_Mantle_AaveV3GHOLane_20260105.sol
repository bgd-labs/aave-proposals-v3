// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {AaveV3GHOLane} from '../../helpers/gho-launch/AaveV3GHOLane.sol';
import {GhoCCIPChains} from '../../helpers/gho-launch/constants/GhoCCIPChains.sol';

/**
 * @title Ethereum<>Mantle GHO CCIP Lane
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aavedao.eth/proposal/0x2f9378770f1838f0ea8d483239af1530c9fbea98d648e0b11e4647dcb722d119
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/10
 */
contract Ethereum_Mantle_AaveV3GHOLane_20260105 is AaveV3GHOLane {
  constructor() AaveV3GHOLane(GhoCCIPChains.ETHEREUM()) {}

  function lanesToAdd()
    public
    pure
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    return _asArray(_asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.MANTLE()));
  }
}
