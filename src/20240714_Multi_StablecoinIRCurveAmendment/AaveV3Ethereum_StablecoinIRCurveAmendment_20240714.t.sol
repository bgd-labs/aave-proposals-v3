// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_StablecoinIRCurveAmendment_20240714} from './AaveV3Ethereum_StablecoinIRCurveAmendment_20240714.sol';

/**
 * @dev Test for AaveV3Ethereum_StablecoinIRCurveAmendment_20240714
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Ethereum_StablecoinIRCurveAmendment_20240714.t.sol -vv
 */
contract AaveV3Ethereum_StablecoinIRCurveAmendment_20240714_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StablecoinIRCurveAmendment_20240714 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20306814);
    proposal = new AaveV3Ethereum_StablecoinIRCurveAmendment_20240714();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_StablecoinIRCurveAmendment_20240714',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
