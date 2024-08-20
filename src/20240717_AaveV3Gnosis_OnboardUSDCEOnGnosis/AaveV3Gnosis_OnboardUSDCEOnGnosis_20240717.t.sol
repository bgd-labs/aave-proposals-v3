// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717} from './AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717.sol';

/**
 * @dev Test for AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20240717_AaveV3Gnosis_OnboardUSDCEOnGnosis/AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717.t.sol -vv
 */
contract AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717_Test is ProtocolV3TestBase {
  AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 35231842);
    proposal = new AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Gnosis_OnboardUSDCEOnGnosis_20240717', AaveV3Gnosis.POOL, address(proposal));
  }

  function test_collectorHasUSDCeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Gnosis
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDCe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Gnosis.COLLECTOR)), 1e6);
  }
}
