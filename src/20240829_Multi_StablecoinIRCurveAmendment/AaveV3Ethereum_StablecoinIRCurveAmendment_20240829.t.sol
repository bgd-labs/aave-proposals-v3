// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_StablecoinIRCurveAmendment_20240829} from './AaveV3Ethereum_StablecoinIRCurveAmendment_20240829.sol';

/**
 * @dev Test for AaveV3Ethereum_StablecoinIRCurveAmendment_20240829
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Ethereum_StablecoinIRCurveAmendment_20240829.t.sol -vv
 */
contract AaveV3Ethereum_StablecoinIRCurveAmendment_20240829_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StablecoinIRCurveAmendment_20240829 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20633810);
    proposal = new AaveV3Ethereum_StablecoinIRCurveAmendment_20240829();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_StablecoinIRCurveAmendment_20240829',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
