// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLaneTest_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {Avalanche_Ink_AaveV3GHOLane_20250814} from '../../remote-lanes/Avalanche_Ink_AaveV3GHOLane_20250814.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

uint256 constant AVALANCHE_BLOCK_NUMBER = 68979823;

contract Avalanche_Ink_AaveV3GHOLane_20250814_Test_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.AVALANCHE(),
      GhoCCIPChains.INK(),
      'avalanche',
      AVALANCHE_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Avalanche_Ink_AaveV3GHOLane_20250814();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest('Avalanche_Ink_AaveV3GHOLane_20250814', AaveV3Avalanche.POOL, address(proposal));
  }
}

contract Avalanche_Ink_AaveV3GHOLane_20250814_Test_PostExecution is
  AaveV3GHORemoteLaneTest_PostExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.AVALANCHE(),
      GhoCCIPChains.INK(),
      'avalanche',
      AVALANCHE_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Avalanche_Ink_AaveV3GHOLane_20250814();
  }
}
