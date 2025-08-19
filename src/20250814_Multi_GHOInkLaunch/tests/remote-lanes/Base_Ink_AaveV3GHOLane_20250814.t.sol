// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PostExecution} from '../../abstraction/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../abstraction/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../abstraction/AaveV3GHOLane.sol';
import {Base_Ink_AaveV3GHOLane_20250814} from '../../remote-lanes/Base_Ink_AaveV3GHOLane_20250814.sol';
import {GHOInkLaunchConstants} from '../../GHOInkLaunchConstants.sol';

contract Base_Ink_AaveV3GHOLane_20250814_Test is AaveV3GHORemoteLaneTest_PostExecution {
  constructor()
    AaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.BASE(),
      GhoCCIPChains.INK(),
      'base',
      GHOInkLaunchConstants.BASE_BLOCK_NUMBER
    )
  {}

  function _expectedSupportedChains()
    internal
    view
    virtual
    override
    returns (GhoCCIPChains.ChainInfo[] memory)
  {
    GhoCCIPChains.ChainInfo[] memory expectedSupportedChains = new GhoCCIPChains.ChainInfo[](5);
    expectedSupportedChains[0] = GhoCCIPChains.ETHEREUM();
    expectedSupportedChains[1] = GhoCCIPChains.ARBITRUM();
    expectedSupportedChains[2] = GhoCCIPChains.AVALANCHE();
    expectedSupportedChains[3] = GhoCCIPChains.GNOSIS();
    expectedSupportedChains[4] = GhoCCIPChains.INK();
    return expectedSupportedChains;
  }

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Base_Ink_AaveV3GHOLane_20250814();
  }
}
