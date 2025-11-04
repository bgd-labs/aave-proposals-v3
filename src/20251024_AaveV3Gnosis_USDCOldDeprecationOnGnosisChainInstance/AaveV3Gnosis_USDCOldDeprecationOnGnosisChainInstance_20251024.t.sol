// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024} from './AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024.sol';

/**
 * @dev Test for AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251024_AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance/AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024.t.sol -vv
 */
contract AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024_Test is ProtocolV3TestBase {
  AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 42786362);
    proposal = new AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_USDCOldDeprecationOnGnosisChainInstance_20251024',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
