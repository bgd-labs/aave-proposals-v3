// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PostExecution} from '../../abstraction/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../abstraction/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../abstraction/AaveV3GHOLane.sol';
import {Arbitrum_Ink_AaveV3GHOLane_20250814} from '../../remote-lanes/Arbitrum_Ink_AaveV3GHOLane_20250814.sol';
import {GHOInkLaunchConstants} from '../../GHOInkLaunchConstants.sol';

contract Arbitrum_Ink_AaveV3GHOLane_20250814_Test is AaveV3GHORemoteLaneTest_PostExecution {
  constructor()
    AaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.ARBITRUM(),
      GhoCCIPChains.INK(),
      'arbitrum',
      GHOInkLaunchConstants.ARB_BLOCK_NUMBER
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
    expectedSupportedChains[1] = GhoCCIPChains.BASE();
    expectedSupportedChains[2] = GhoCCIPChains.AVALANCHE();
    expectedSupportedChains[3] = GhoCCIPChains.GNOSIS();
    expectedSupportedChains[4] = GhoCCIPChains.INK();
    return expectedSupportedChains;
  }

  // Overriden because it has two pools for Ethereum chain selector
  function _assertAgainstSupportedChain(
    GhoCCIPChains.ChainInfo memory supportedChain
  ) internal view virtual override {
    if (supportedChain.chainSelector == GhoCCIPChains.ETHEREUM().chainSelector) {
      assertEq(
        LOCAL_TOKEN_POOL.getRemoteToken(supportedChain.chainSelector),
        abi.encode(supportedChain.ghoToken),
        'Remote token mismatch for supported chain'
      );

      assertEq(
        LOCAL_TOKEN_POOL.getRemotePools(supportedChain.chainSelector).length,
        2,
        'Amount of remote pools mismatch for supported chain'
      );

      assertEq(
        LOCAL_TOKEN_POOL.getRemotePools(supportedChain.chainSelector)[1],
        abi.encode(supportedChain.ghoCCIPTokenPool),
        'Remote pool mismatch for supported chain'
      );
    } else {
      super._assertAgainstSupportedChain(supportedChain);
    }
  }

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Arbitrum_Ink_AaveV3GHOLane_20250814();
  }
}
