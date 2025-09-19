// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLaneTest_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {Base_Ink_AaveV3GHOLane_20250814} from '../../remote-lanes/Base_Ink_AaveV3GHOLane_20250814.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

uint256 constant BASE_BLOCK_NUMBER = 35752827;

contract Base_Ink_AaveV3GHOLane_20250814_Test_PreExecution is AaveV3GHORemoteLaneTest_PreExecution {
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.BASE(),
      GhoCCIPChains.INK(),
      'base',
      BASE_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Base_Ink_AaveV3GHOLane_20250814();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest('Base_Ink_AaveV3GHOLane_20250814', AaveV3Base.POOL, address(proposal));
  }
}

contract Base_Ink_AaveV3GHOLane_20250814_Test is AaveV3GHORemoteLaneTest_PostExecution {
  constructor()
    AaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.BASE(),
      GhoCCIPChains.INK(),
      'base',
      BASE_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Base_Ink_AaveV3GHOLane_20250814();
  }
}
