// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLaneTest_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {Avalanche_Plasma_AaveV3GHOLane_20250921} from '../../remote-lanes/Avalanche_Plasma_AaveV3GHOLane_20250921.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

uint256 constant AVALANCHE_BLOCK_NUMBER = 69461596;

contract Avalanche_Plasma_AaveV3GHOLane_20250921_Test_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.AVALANCHE(),
      GhoCCIPChains.PLASMA(),
      'avalanche',
      AVALANCHE_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Avalanche_Plasma_AaveV3GHOLane_20250921();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest('Avalanche_Plasma_AaveV3GHOLane_20250921', AaveV3Avalanche.POOL, address(proposal));
  }
}

contract Avalanche_Plasma_AaveV3GHOLane_20250921_Test_PostExecution is
  AaveV3GHORemoteLaneTest_PostExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.AVALANCHE(),
      GhoCCIPChains.PLASMA(),
      'avalanche',
      AVALANCHE_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Avalanche_Plasma_AaveV3GHOLane_20250921();
  }
}
