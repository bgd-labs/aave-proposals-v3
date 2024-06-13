// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_MayFundingUpdate_20240603} from './AaveV3Polygon_MayFundingUpdate_20240603.sol';

/**
 * @dev Test for AaveV3Polygon_MayFundingUpdate_20240603
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20240603_Multi_MayFundingUpdate/AaveV3Polygon_MayFundingUpdate_20240603.t.sol -vv
 */
contract AaveV3Polygon_MayFundingUpdate_20240603_Test is ProtocolV3TestBase {
  AaveV3Polygon_MayFundingUpdate_20240603 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 57725360);
    proposal = new AaveV3Polygon_MayFundingUpdate_20240603();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Polygon_MayFundingUpdate_20240603', AaveV3Polygon.POOL, address(proposal));
  }
}
