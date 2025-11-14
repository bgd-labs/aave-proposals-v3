// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_XPLOnboarding_20251031} from './AaveV3Plasma_XPLOnboarding_20251031.sol';

/**
 * @dev Test for AaveV3Plasma_XPLOnboarding_20251031
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251031_AaveV3Plasma_XPLOnboarding/AaveV3Plasma_XPLOnboarding_20251031.t.sol -vv
 */
contract AaveV3Plasma_XPLOnboarding_20251031_Test is ProtocolV3TestBase {
  AaveV3Plasma_XPLOnboarding_20251031 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 4993382);
    proposal = new AaveV3Plasma_XPLOnboarding_20251031();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Plasma_XPLOnboarding_20251031', AaveV3Plasma.POOL, address(proposal));
  }

  function test_dustBinHasWXPLFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(proposal.WXPL());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 10 ** 18);
  }

  function test_WXPLAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aWXPL = AaveV3Plasma.POOL.getReserveAToken(proposal.WXPL());
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(proposal.WXPL()),
      proposal.WXPL_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(aWXPL),
      proposal.WXPL_LM_ADMIN()
    );
  }
}
