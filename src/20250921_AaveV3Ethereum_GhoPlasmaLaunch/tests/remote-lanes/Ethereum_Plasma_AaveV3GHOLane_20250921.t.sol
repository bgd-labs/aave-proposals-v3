// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3GHOEthereumRemoteLaneTest_PreExecution, AaveV3GHOEthereumRemoteLaneTest_PostExecution} from '../../../helpers/gho-launch/tests/AaveV3GHOEthereumRemoteLaneTest.sol';
import {GhoCCIPChains} from '../../../helpers/gho-launch/constants/GhoCCIPChains.sol';
import {AaveV3GHOLane} from '../../../helpers/gho-launch/AaveV3GHOLane.sol';
import {Ethereum_Plasma_AaveV3GHOLane_20250921} from '../../remote-lanes/Ethereum_Plasma_AaveV3GHOLane_20250921.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

uint256 constant ETHEREUM_BLOCK_NUMBER = 23465270;

contract Ethereum_Plasma_AaveV3GHOLane_20250921_Test_PreExecution is
  AaveV3GHOEthereumRemoteLaneTest_PreExecution
{
  constructor()
    AaveV3GHOEthereumRemoteLaneTest_PreExecution(GhoCCIPChains.PLASMA(), ETHEREUM_BLOCK_NUMBER)
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Ethereum_Plasma_AaveV3GHOLane_20250921();
  }

  function test_defaultProposalExecution() public virtual {
    defaultTest('Ethereum_Plasma_AaveV3GHOLane_20250921', AaveV3Ethereum.POOL, address(proposal));
  }
}

contract Ethereum_Plasma_AaveV3GHOLane_20250921_Test is
  AaveV3GHOEthereumRemoteLaneTest_PostExecution
{
  constructor()
    AaveV3GHOEthereumRemoteLaneTest_PostExecution(GhoCCIPChains.PLASMA(), ETHEREUM_BLOCK_NUMBER)
  {}

  function _deployAaveV3GHOLaneProposal() internal virtual override returns (AaveV3GHOLane) {
    return new Ethereum_Plasma_AaveV3GHOLane_20250921();
  }
}
