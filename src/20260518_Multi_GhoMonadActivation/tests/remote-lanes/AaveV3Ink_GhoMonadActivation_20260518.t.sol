// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLane_1_6_Test_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {AaveV3Ink_GhoMonadActivation_20260518} from '../../remote-lanes/AaveV3Ink_GhoMonadActivation_20260518.sol';
import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

uint256 constant INK_BLOCK_NUMBER = 48649995;

contract Ink_Monad_AaveV3GHOLane_20260105_Test_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.INK(),
      GhoCCIPChains.MONAD(),
      'ink',
      INK_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ink_GhoMonadActivation_20260518();
  }

  function test_defaultProposalExecution() public virtual {
    executePayload(vm, address(proposal));
  }

  function _assertOnAndOffRamps() internal view override {
    _assertOnRamp_2_0(
      address(_localOutboundLaneToEth_1_6()),
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

contract Ink_Monad_AaveV3GHOLane_20260105_Test is AaveV3GHORemoteLane_1_6_Test_PostExecution {
  constructor()
    AaveV3GHORemoteLane_1_6_Test_PostExecution(
      GhoCCIPChains.INK(),
      GhoCCIPChains.MONAD(),
      'ink',
      INK_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ink_GhoMonadActivation_20260518();
  }

  function _assertOnAndOffRamps() internal view override {
    _assertOnRamp_2_0(
      address(_localOutboundLaneToEth_1_6()),
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
