// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IUpgradeableBurnMintTokenPool_1_5_1} from 'src/interfaces/ccip/tokenPool/IUpgradeableBurnMintTokenPool.sol';
import {AaveV3GHOLaunch} from './abstraction/AaveV3GHOLaunch.sol';
import {GhoCCIPChains} from './abstraction/constants/GhoCCIPChains.sol';

/**
 * @title GHO Ink Launch
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xf066b8a7b1c0f3d4edff72a047809e3e1f57578d2335fd769e23561a25efb795
 */
contract AaveV3Ink_GHOInkLaunch_20250814 is AaveV3GHOLaunch {
  constructor() AaveV3GHOLaunch(GhoCCIPChains.INK()) {}

  function lanesToAdd()
    public
    pure
    override
    returns (IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[] memory)
  {
    IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[]
      memory chainsToAdd = new IUpgradeableBurnMintTokenPool_1_5_1.ChainUpdate[](5);

    chainsToAdd[0] = _asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.ETHEREUM());
    chainsToAdd[1] = _asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.ARBITRUM());
    chainsToAdd[2] = _asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.BASE());
    chainsToAdd[3] = _asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.AVALANCHE());
    chainsToAdd[4] = _asChainUpdateWithDefaultRateLimiterConfig(GhoCCIPChains.GNOSIS());

    return chainsToAdd;
  }

  function _setupGhoAaveSteward() internal override {
    // Do not setup Aave Core Steward, it will be done through the Aave V3 Ink activation proposal.
  }
}
