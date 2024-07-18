// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_StablecoinIRCurveAmendment_20240714} from './AaveV2Ethereum_StablecoinIRCurveAmendment_20240714.sol';

/**
 * @dev Test for AaveV2Ethereum_StablecoinIRCurveAmendment_20240714
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240714_Multi_StablecoinIRCurveAmendment/AaveV2Ethereum_StablecoinIRCurveAmendment_20240714.t.sol -vv
 */
contract AaveV2Ethereum_StablecoinIRCurveAmendment_20240714_Test is ProtocolV2TestBase {
  AaveV2Ethereum_StablecoinIRCurveAmendment_20240714 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20306796);
    proposal = new AaveV2Ethereum_StablecoinIRCurveAmendment_20240714();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_StablecoinIRCurveAmendment_20240714',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }
}
