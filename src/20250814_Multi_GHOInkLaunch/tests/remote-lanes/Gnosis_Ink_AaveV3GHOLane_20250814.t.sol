// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {Gnosis_Ink_AaveV3GHOLane_20250814} from '../../remote-lanes/Gnosis_Ink_AaveV3GHOLane_20250814.sol';

contract Gnosis_Ink_AaveV3GHOLane_20250814_Test is AaveV3GHORemoteLaneTest_PostExecution {
  constructor()
    AaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.GNOSIS(),
      GhoCCIPChains.INK(),
      'gnosis',
      41726320
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Gnosis_Ink_AaveV3GHOLane_20250814();
  }
}
