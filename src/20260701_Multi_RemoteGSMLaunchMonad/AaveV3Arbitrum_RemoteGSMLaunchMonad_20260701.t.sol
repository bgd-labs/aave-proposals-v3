// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {CCIPChainSelectors} from 'src/helpers/gho-launch/constants/CCIPChainSelectors.sol';

import {AaveV3Arbitrum_RemoteGSMLaunchMonad_20260701} from './AaveV3Arbitrum_RemoteGSMLaunchMonad_20260701.sol';
import {RemoteGSMLaunchMonadFacilitatorProposalBaseTest} from './setup/RemoteGSMLaunchMonadFacilitatorProposalBaseTest.t.sol';

/**
 * @dev Test for AaveV3Arbitrum_RemoteGSMLaunchMonad_20260701
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260701_Multi_RemoteGSMLaunchMonad/AaveV3Arbitrum_RemoteGSMLaunchMonad_20260701.t.sol -vv
 */
contract AaveV3Arbitrum_RemoteGSMLaunchMonad_20260701_Test is
  RemoteGSMLaunchMonadFacilitatorProposalBaseTest
{
  function CURRENT_CHAIN_SELECTOR() public pure override returns (uint64) {
    return CCIPChainSelectors.ARBITRUM;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 485940600);
    proposal = new AaveV3Arbitrum_RemoteGSMLaunchMonad_20260701();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_RemoteGSMLaunchMonad_20260701',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
