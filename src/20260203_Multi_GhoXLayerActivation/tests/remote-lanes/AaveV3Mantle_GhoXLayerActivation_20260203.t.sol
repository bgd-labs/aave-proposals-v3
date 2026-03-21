// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLane_1_6_Test_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {AaveV3Mantle_GhoXLayerActivation_20260203} from '../../remote-lanes/AaveV3Mantle_GhoXLayerActivation_20260203.sol';
import {AaveV3Mantle} from 'aave-address-book/AaveV3Mantle.sol';

uint256 constant MANTLE_BLOCK_NUMBER = 92474200;

contract Mantle_XLayer_AaveV3GHOLane_20260105_Test_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.MANTLE(),
      GhoCCIPChains.XLAYER(),
      'mantle',
      MANTLE_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Mantle_GhoXLayerActivation_20260203();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest(
      'AaveV3Mantle_GhoXLayerActivation_20260203',
      AaveV3Mantle.POOL,
      address(proposal),
      false,
      false
    );
  }

  function _assertOnAndOffRamps() internal view override {
    _assertOnRamp_1_6(
      _localOutboundLaneToEth_1_6(),
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
    _assertOffRamp_1_6(
      _localInboundLaneFromEth_1_6(),
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

contract Mantle_XLayer_AaveV3GHOLane_20260105_Test_PostExecution is
  AaveV3GHORemoteLane_1_6_Test_PostExecution
{
  constructor()
    AaveV3GHORemoteLane_1_6_Test_PostExecution(
      GhoCCIPChains.MANTLE(),
      GhoCCIPChains.XLAYER(),
      'mantle',
      MANTLE_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Mantle_GhoXLayerActivation_20260203();
  }

  function _assertOnAndOffRamps() internal view override {
    _assertOnRamp_1_6(
      _localOutboundLaneToEth_1_6(),
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
    _assertOffRamp_1_6(
      _localInboundLaneFromEth_1_6(),
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
