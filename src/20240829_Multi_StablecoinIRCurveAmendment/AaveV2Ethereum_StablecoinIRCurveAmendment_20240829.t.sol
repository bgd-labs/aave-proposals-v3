// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_StablecoinIRCurveAmendment_20240829} from './AaveV2Ethereum_StablecoinIRCurveAmendment_20240829.sol';

/**
 * @dev Test for AaveV2Ethereum_StablecoinIRCurveAmendment_20240829
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240829_Multi_StablecoinIRCurveAmendment/AaveV2Ethereum_StablecoinIRCurveAmendment_20240829.t.sol -vv
 */
contract AaveV2Ethereum_StablecoinIRCurveAmendment_20240829_Test is ProtocolV2TestBase {
  AaveV2Ethereum_StablecoinIRCurveAmendment_20240829 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20633700);
    proposal = new AaveV2Ethereum_StablecoinIRCurveAmendment_20240829();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_StablecoinIRCurveAmendment_20240829',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }
}
