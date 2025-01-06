// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224} from './AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224.sol';

/**
 * @dev Test for AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20241224_AaveV3Gnosis_AaveV3GnosisInstanceUpdates/AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224.t.sol -vv
 */
contract AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224_Test is ProtocolV3TestBase {
  AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 37810182);
    proposal = new AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_AaveV3GnosisInstanceUpdates_20241224',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
