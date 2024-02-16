// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208} from './AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208.sol';

/**
 * @dev Test for AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208
 * command: make test-contract filter=AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208
 */
contract AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208_Test is
  ProtocolV3TestBase
{
  AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 36183713);
    proposal = new AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3BNB_SetAaveChanInitiativeAsEmissionManagerForFdUSDOnBNBChainAaveV3_20240208',
      AaveV3BNB.POOL,
      address(proposal)
    );
  }
}
