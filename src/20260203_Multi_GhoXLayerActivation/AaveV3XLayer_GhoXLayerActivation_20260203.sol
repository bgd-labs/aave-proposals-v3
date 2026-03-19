// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHOLaunch} from '../helpers/gho-launch/AaveV3GHOLaunch.sol';
import {GhoCCIPChains} from '../helpers/gho-launch/constants/GhoCCIPChains.sol';

/**
 * @title Gho X-Layer Launch
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-x-layer-set-aci-as-emissions-manager-for-rewards/23178
 */
contract AaveV3XLayer_GhoXLayerActivation_20260203 is AaveV3GHOLaunch {
  constructor() AaveV3GHOLaunch(GhoCCIPChains.XLAYER()) {}
  function _setupGhoAaveSteward() internal override {
    // Do not setup Aave Core Steward, will be set up with Gho launch on Aave.
  }
}
