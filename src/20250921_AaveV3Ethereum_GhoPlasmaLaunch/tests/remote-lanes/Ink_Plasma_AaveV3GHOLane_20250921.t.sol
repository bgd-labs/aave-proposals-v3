// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLaneTest_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {Ink_Plasma_AaveV3GHOLane_20250921} from '../../remote-lanes/Ink_Plasma_AaveV3GHOLane_20250921.sol';
import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

uint256 constant INK_BLOCK_NUMBER = 42241190;

contract Ink_Plasma_AaveV3GHOLane_20250921_Test_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.INK(),
      GhoCCIPChains.PLASMA(),
      'ink',
      INK_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Ink_Plasma_AaveV3GHOLane_20250921();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest('Ink_Plasma_AaveV3GHOLane_20250921', AaveV3InkWhitelabel.POOL, address(proposal));
  }
}

contract Ink_Plasma_AaveV3GHOLane_20250921_Test is AaveV3GHORemoteLaneTest_PostExecution {
  constructor()
    AaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.INK(),
      GhoCCIPChains.PLASMA(),
      'ink',
      INK_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Ink_Plasma_AaveV3GHOLane_20250921();
  }
}
