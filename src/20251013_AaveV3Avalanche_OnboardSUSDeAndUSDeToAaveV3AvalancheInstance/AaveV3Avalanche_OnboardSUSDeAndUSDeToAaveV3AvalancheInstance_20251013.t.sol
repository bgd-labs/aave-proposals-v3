// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013} from './AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013.sol';

/**
 * @dev Test for AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251013_AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance/AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013.t.sol -vv
 */
contract AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013_Test is
  ProtocolV3TestBase
{
  AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 70289869);
    proposal = new AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_OnboardSUSDeAndUSDeToAaveV3AvalancheInstance_20251013',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Avalanche.POOL.getReserveAToken(proposal.USDe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Avalanche.DUST_BIN)), 10 ** 18);
  }

  function test_USDeAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aUSDe = AaveV3Avalanche.POOL.getReserveAToken(proposal.USDe());
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(proposal.USDe()),
      proposal.USDe_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(aUSDe),
      proposal.USDe_LM_ADMIN()
    );
  }

  function test_dustBinHassUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Avalanche.POOL.getReserveAToken(proposal.sUSDe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Avalanche.DUST_BIN)), 10 ** 18);
  }

  function test_sUSDeAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address asUSDe = AaveV3Avalanche.POOL.getReserveAToken(proposal.sUSDe());
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(proposal.sUSDe()),
      proposal.sUSDe_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Avalanche.EMISSION_MANAGER).getEmissionAdmin(asUSDe),
      proposal.sUSDe_LM_ADMIN()
    );
  }
}
