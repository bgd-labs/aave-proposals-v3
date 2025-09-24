// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHOLaunch} from '../helpers/gho-launch/AaveV3GHOLaunch.sol';
import {GhoCCIPChains} from '../helpers/gho-launch/constants/GhoCCIPChains.sol';

/**
 * @title Gho Plasma Launch
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994
 */
contract AaveV3_GhoPlasmaLaunch_20250921 is AaveV3GHOLaunch {
  constructor() AaveV3GHOLaunch(GhoCCIPChains.PLASMA()) {}

  function _setupGhoAaveSteward() internal override {
    // Do not setup Aave Core Steward, already created.
  }

  function _setupGhoBucketSteward() internal override {
    // Do not setup Aave Gho Bucket Steward, already created.
  }

  function _setupGhoCCIPSteward() internal override {
    // Do not setup Aave Gho Ccip Steward, already created.
  }
}
