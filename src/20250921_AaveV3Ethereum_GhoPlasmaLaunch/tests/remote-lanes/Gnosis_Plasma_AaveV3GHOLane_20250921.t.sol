// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHORemoteLaneTest_PreExecution, AaveV3GHORemoteLaneTest_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHORemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {Gnosis_Plasma_AaveV3GHOLane_20250921} from '../../remote-lanes/Gnosis_Plasma_AaveV3GHOLane_20250921.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

uint256 constant GNOSIS_BLOCK_NUMBER = 42361100;

contract Gnosis_Plasma_AaveV3GHOLane_20250921_Test_PreExecution is
  AaveV3GHORemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHORemoteLaneTest_PreExecution(
      GhoCCIPChains.GNOSIS(),
      GhoCCIPChains.PLASMA(),
      'gnosis',
      GNOSIS_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Gnosis_Plasma_AaveV3GHOLane_20250921();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest('Gnosis_Plasma_AaveV3GHOLane_20250921', AaveV3Gnosis.POOL, address(proposal));
  }
}

contract Gnosis_Plasma_AaveV3GHOLane_20250921_Test is AaveV3GHORemoteLaneTest_PostExecution {
  constructor()
    AaveV3GHORemoteLaneTest_PostExecution(
      GhoCCIPChains.GNOSIS(),
      GhoCCIPChains.PLASMA(),
      'gnosis',
      GNOSIS_BLOCK_NUMBER
    )
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Gnosis_Plasma_AaveV3GHOLane_20250921();
  }
}
