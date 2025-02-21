// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218} from './AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218.sol';

/**
 * @dev Test for AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250218_Multi_UpdateAAVETokenLTVLiquidationPercentages/AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218.t.sol -vv
 */
contract AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21876392);
    proposal = new AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_UpdateAAVETokenLTVLiquidationPercentages_20250218',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
