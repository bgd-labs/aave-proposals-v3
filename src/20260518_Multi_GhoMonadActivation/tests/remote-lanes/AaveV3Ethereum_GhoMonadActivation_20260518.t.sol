// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHOEthereumRemoteLaneTest_PreExecution, AaveV3GHOEthereumRemoteLane_1_6_Test_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHOEthereumRemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {AaveV3Ethereum_GhoMonadActivation_20260518} from '../../remote-lanes/AaveV3Ethereum_GhoMonadActivation_20260518.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

uint256 constant ETHEREUM_BLOCK_NUMBER = 25374562;

contract Ethereum_Monad_AaveV3GHOLane_20260105_Test_PreExecution is
  AaveV3GHOEthereumRemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHOEthereumRemoteLaneTest_PreExecution(GhoCCIPChains.MONAD(), ETHEREUM_BLOCK_NUMBER)
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ethereum_GhoMonadActivation_20260518();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest(
      'AaveV3Ethereum_GhoMonadActivation_20260518',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function _assertOnAndOffRamps() internal view virtual override {
    _assertOnRamp_1_6(
      _localOutboundLaneToRemote_1_6(),
      LOCAL_CHAIN_SELECTOR,
      REMOTE_CHAIN_SELECTOR,
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

contract Ethereum_Monad_AaveV3GHOLane_20260105_Test_PostExecution is
  AaveV3GHOEthereumRemoteLane_1_6_Test_PostExecution
{
  constructor()
    AaveV3GHOEthereumRemoteLane_1_6_Test_PostExecution(GhoCCIPChains.MONAD(), ETHEREUM_BLOCK_NUMBER)
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new AaveV3Ethereum_GhoMonadActivation_20260518();
  }

  function _assertOnAndOffRamps() internal view virtual override {
    _assertOnRamp_1_6(
      _localOutboundLaneToRemote_1_6(),
      LOCAL_CHAIN_SELECTOR,
      REMOTE_CHAIN_SELECTOR,
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
