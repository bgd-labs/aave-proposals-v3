// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223} from './AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223.sol';

/**
 * @dev Test for AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241223_Multi_USDSInterestRateCurveUpdate/AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223.t.sol -vv
 */
contract AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223_Test is ProtocolV3TestBase {
  AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21464361);
    proposal = new AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_USDSInterestRateCurveUpdate_20241223',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
