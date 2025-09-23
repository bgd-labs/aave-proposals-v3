// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHOLaunch} from '../helpers/gho-launch/AaveV3GHOLaunch.sol';
import {GhoCCIPChains} from '../helpers/gho-launch/constants/GhoCCIPChains.sol';

/**
 * @title GHO Ink Launch
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/arfc-launch-gho-on-ink-set-aci-as-emissions-manager-for-rewards/22664
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0xf066b8a7b1c0f3d4edff72a047809e3e1f57578d2335fd769e23561a25efb795
 */
contract AaveV3Ink_GHOInkLaunch_20250814 is AaveV3GHOLaunch {
  constructor() AaveV3GHOLaunch(GhoCCIPChains.INK()) {}

  function _setupGhoAaveSteward() internal override {
    // Do not setup Aave Core Steward, it will be done through the Aave V3 Ink activation proposal.
  }
}
