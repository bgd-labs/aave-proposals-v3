// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_July2025FundingUpdate_20250721} from './AaveV3Arbitrum_July2025FundingUpdate_20250721.sol';

/**
 * @dev Test for AaveV3Arbitrum_July2025FundingUpdate_20250721
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250721_Multi_July2025FundingUpdate/AaveV3Arbitrum_July2025FundingUpdate_20250721.t.sol -vv
 */
contract AaveV3Arbitrum_July2025FundingUpdate_20250721_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_July2025FundingUpdate_20250721 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 360052873);
    proposal = new AaveV3Arbitrum_July2025FundingUpdate_20250721();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_July2025FundingUpdate_20250721',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
