// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHOEthereumRemoteLaneTest_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHOEthereumRemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {Ethereum_Ink_AaveV3GHOLane_20250814} from '../../remote-lanes/Ethereum_Ink_AaveV3GHOLane_20250814.sol';

contract Ethereum_Avalanche_AaveV3GHOLane_20250519_Test is
  AaveV3GHOEthereumRemoteLaneTest_PostExecution
{
  constructor() AaveV3GHOEthereumRemoteLaneTest_PostExecution(GhoCCIPChains.INK(), 23193620) {}

  function _expectedSupportedChains()
    internal
    view
    virtual
    override
    returns (GhoCCIPChains.ChainInfo[] memory)
  {
    GhoCCIPChains.ChainInfo[] memory expectedSupportedChains = new GhoCCIPChains.ChainInfo[](5);
    expectedSupportedChains[0] = GhoCCIPChains.ARBITRUM();
    expectedSupportedChains[1] = GhoCCIPChains.BASE();
    expectedSupportedChains[2] = GhoCCIPChains.AVALANCHE();
    expectedSupportedChains[3] = GhoCCIPChains.GNOSIS();
    expectedSupportedChains[4] = GhoCCIPChains.INK();
    return expectedSupportedChains;
  }

  // Overriden because it has two pools for Arbitrum chain selector
  function _assertAgainstSupportedChain(
    GhoCCIPChains.ChainInfo memory supportedChain
  ) internal view virtual override {
    if (supportedChain.chainSelector == GhoCCIPChains.ARBITRUM().chainSelector) {
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
    return new Ethereum_Ink_AaveV3GHOLane_20250814();
  }
}
