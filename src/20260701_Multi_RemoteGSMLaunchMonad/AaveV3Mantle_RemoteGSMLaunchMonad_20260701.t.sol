// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Mantle} from 'aave-address-book/AaveV3Mantle.sol';
import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {AaveV3Mantle_RemoteGSMLaunchMonad_20260701} from './AaveV3Mantle_RemoteGSMLaunchMonad_20260701.sol';
import {RemoteGSMLaunchMonadFacilitatorProposalBaseTest} from './setup/RemoteGSMLaunchMonadFacilitatorProposalBaseTest.t.sol';

/**
 * @dev Test for AaveV3Mantle_RemoteGSMLaunchMonad_20260701
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Mantle_RemoteGSMLaunchMonad_20260701.t.sol -vv
 */
contract AaveV3Mantle_RemoteGSMLaunchMonad_20260701_Test is
  RemoteGSMLaunchMonadFacilitatorProposalBaseTest
{
  function CURRENT_CHAIN_SELECTOR() public pure override returns (uint64) {
    return CCIPChainSelectors.MANTLE;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mantle'), 98222900);
    proposal = new AaveV3Mantle_RemoteGSMLaunchMonad_20260701();
  }

  /**
   * @dev executes the generic test suite and config snapshots; e2e is skipped (see below)
   */
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    // e2e is skipped: at this fork block no Mantle reserve satisfies all of ProtocolV3TestBase._getGoodCollateral's
    // gates (active, unfrozen, not paused, usable as collateral, debtCeiling == 0, ltv != 0), so the default e2e
    // supply / borrow path reverts with "No usable collateral found".
    // This payload only touches the GHO CCIP bucket capacity and lane rate-limit config.
    // It does not modify pool reserves, so e2e adds no coverage here.
    defaultTest(
      'AaveV3Mantle_RemoteGSMLaunchMonad_20260701',
      AaveV3Mantle.POOL,
      address(proposal),
      false,
      false
    );
  }
}
