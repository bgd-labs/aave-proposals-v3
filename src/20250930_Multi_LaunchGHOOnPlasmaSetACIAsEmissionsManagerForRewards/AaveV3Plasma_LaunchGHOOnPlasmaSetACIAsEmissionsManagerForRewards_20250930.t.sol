// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930} from './AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.sol';

/**
 * @dev Test for AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250930_Multi_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards/AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930.t.sol -vv
 */
contract AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930_Test is
  ProtocolV3TestBase
{
  AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 2343679);
    proposal = new AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_LaunchGHOOnPlasmaSetACIAsEmissionsManagerForRewards_20250930',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasGHOFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(proposal.GHO());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 10 ** 18);
  }

  function test_GHOAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aGHO = AaveV3Plasma.POOL.getReserveAToken(proposal.GHO());
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(proposal.GHO()),
      proposal.GHO_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(aGHO),
      proposal.GHO_LM_ADMIN()
    );
  }
}
