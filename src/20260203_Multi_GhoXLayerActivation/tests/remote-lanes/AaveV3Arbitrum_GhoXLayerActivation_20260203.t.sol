// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLane_1_6_Test_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {AaveV3Arbitrum_GhoXLayerActivation_20260203} from '../../remote-lanes/AaveV3Arbitrum_GhoXLayerActivation_20260203.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

uint256 constant ARBITRUM_BLOCK_NUMBER = 439062760;

contract Arbitrum_XLayer_AaveV3GHOLane_20260105_Test_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.ARBITRUM(),
      GhoCCIPChains.XLAYER(),
      'arbitrum',
      ARBITRUM_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Arbitrum_GhoXLayerActivation_20260203();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest(
      'AaveV3Arbitrum_GhoXLayerActivation_20260203',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  // Overridden because it has two pools for Ethereum chain selector
  function _assertAgainstSupportedChain(
    GhoCCIPChains.ChainInfo memory supportedChain
  ) internal virtual override {
    if (supportedChain.chainSelector == GhoCCIPChains.ETHEREUM().chainSelector) {
      assertEq(
        LOCAL_TOKEN_POOL.getRemoteToken(supportedChain.chainSelector),
        abi.encode(supportedChain.ghoToken),
        'Remote token mismatch for supported chain'
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

  function _assertOnAndOffRamps() internal view override {
    _assertOnRamp(
      _localOutboundLaneToEth(),
      LOCAL_CHAIN_SELECTOR,
      ETH_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOnRamp_1_6(
      _localOutboundLaneToRemote_1_6(),
      LOCAL_CHAIN_SELECTOR,
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOffRamp(
      _localInboundLaneFromEth(),
      ETH_CHAIN_SELECTOR,
      LOCAL_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOffRamp_1_6(
      _localInboundLaneFromRemote_1_6(),
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
  }
}

contract Arbitrum_XLayer_AaveV3GHOLane_20260105_Test_PostExecution is
  AaveV3GHORemoteLane_1_6_Test_PostExecution
{
  constructor()
    AaveV3GHORemoteLane_1_6_Test_PostExecution(
      GhoCCIPChains.ARBITRUM(),
      GhoCCIPChains.XLAYER(),
      'arbitrum',
      ARBITRUM_BLOCK_NUMBER
    )
  {}

  // Overridden because it has two pools for Ethereum chain selector
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
    return new AaveV3Arbitrum_GhoXLayerActivation_20260203();
  }

  function _assertOnAndOffRamps() internal view override {
    _assertOnRamp(
      _localOutboundLaneToEth(),
      LOCAL_CHAIN_SELECTOR,
      ETH_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOnRamp_1_6(
      _localOutboundLaneToRemote_1_6(),
      LOCAL_CHAIN_SELECTOR,
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOffRamp(
      _localInboundLaneFromEth(),
      ETH_CHAIN_SELECTOR,
      LOCAL_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
    _assertOffRamp_1_6(
      _localInboundLaneFromRemote_1_6(),
      REMOTE_CHAIN_SELECTOR,
      LOCAL_CHAIN_SELECTOR,
      LOCAL_CCIP_ROUTER
    );
  }
}
