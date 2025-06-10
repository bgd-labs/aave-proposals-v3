// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507} from './AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507.sol';

/**
 * @dev Test for AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250507_AaveV3Base_AddAAVETokenToAaveV3BaseInstance/AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507.t.sol -vv
 */
contract AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507_Test is ProtocolV3TestBase {
  AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 29923469);
    proposal = new AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_AddAAVETokenToAaveV3BaseInstance_20250507',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasAAVEFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Base.POOL.getReserveAToken(proposal.AAVE());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Base.DUST_BIN)), 65 * 10 ** 16);
  }

  function test_AAVEAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aAAVE = AaveV3Base.POOL.getReserveAToken(proposal.AAVE());
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(proposal.AAVE()),
      proposal.AAVE_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(aAAVE),
      proposal.AAVE_LM_ADMIN()
    );
  }
}
