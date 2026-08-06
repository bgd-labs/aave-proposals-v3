// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {AaveV3GHOLane} from '../../helpers/gho-launch/AaveV3GHOLane.sol';
import {GhoCCIPChains} from '../../helpers/gho-launch/constants/GhoCCIPChains.sol';
/**
 * @title Base<>Monad GHO CCIP Lane
 * @author TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943
 */
contract AaveV3Base_GhoMonadActivation_20260518 is AaveV3GHOLane {
  constructor() AaveV3GHOLane(GhoCCIPChains.BASE()) {}
  function lanesToAdd()
    public
    pure
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    return _asArray(_asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.MONAD()));
  }
}
