// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLaneTest_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {Gnosis_Ink_AaveV3GHOLane_20250814} from '../../remote-lanes/Gnosis_Ink_AaveV3GHOLane_20250814.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

uint256 constant GNOSIS_BLOCK_NUMBER = 42203538;

contract Gnosis_Ink_AaveV3GHOLane_20250814_Test_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.GNOSIS(),
      GhoCCIPChains.INK(),
      'gnosis',
      GNOSIS_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Gnosis_Ink_AaveV3GHOLane_20250814();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest('Gnosis_Ink_AaveV3GHOLane_20250814', AaveV3Gnosis.POOL, address(proposal));
  }
}

contract Gnosis_Ink_AaveV3GHOLane_20250814_Test is AaveV3GHORemoteLaneTest_PostExecution {
  constructor()
    AaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.GNOSIS(),
      GhoCCIPChains.INK(),
      'gnosis',
      GNOSIS_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Gnosis_Ink_AaveV3GHOLane_20250814();
  }
}
