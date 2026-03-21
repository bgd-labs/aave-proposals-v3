// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLane_1_6_Test_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {AaveV3Gnosis_GhoXLayerActivation_20260203} from '../../remote-lanes/AaveV3Gnosis_GhoXLayerActivation_20260203.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

uint256 constant GNOSIS_BLOCK_NUMBER = 45066125;

contract Gnosis_XLayer_AaveV3GHOLane_20260105_Test_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.GNOSIS(),
      GhoCCIPChains.XLAYER(),
      'gnosis',
      GNOSIS_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Gnosis_GhoXLayerActivation_20260203();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest('AaveV3Gnosis_GhoXLayerActivation_20260203', AaveV3Gnosis.POOL, address(proposal));
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

contract Gnosis_XLayer_AaveV3GHOLane_20260105_Test_PostExecution is
  AaveV3GHORemoteLane_1_6_Test_PostExecution
{
  constructor()
    AaveV3GHORemoteLane_1_6_Test_PostExecution(
      GhoCCIPChains.GNOSIS(),
      GhoCCIPChains.XLAYER(),
      'gnosis',
      GNOSIS_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Gnosis_GhoXLayerActivation_20260203();
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
