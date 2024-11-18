// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105} from './AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105.sol';

/**
 * @dev Test for AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241105_AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet/AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105.t.sol -vv
 */
contract AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21123714);
    proposal = new AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RemoveFraxFromIsolationModeOnAaveV3Mainnet_20241105',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
