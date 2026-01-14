// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHOLaunch} from '../helpers/gho-launch/AaveV3GHOLaunch.sol';
import {GhoCCIPChains} from '../helpers/gho-launch/constants/GhoCCIPChains.sol';

/**
 * @title Gho Mantle Launch
 * @author @TokenLogic
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/10
 */
contract AaveV3Mantle_GhoMantleActivation_20260105 is AaveV3GHOLaunch {
  constructor() AaveV3GHOLaunch(GhoCCIPChains.MANTLE()) {}

  function _setupGhoAaveSteward() internal override {
    // Do not setup Aave Core Steward, will be set up with Gho launch on Aave.
  }
}
