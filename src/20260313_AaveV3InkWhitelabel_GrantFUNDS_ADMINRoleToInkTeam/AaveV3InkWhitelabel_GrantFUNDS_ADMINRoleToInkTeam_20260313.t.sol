// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam_20260313} from './AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam_20260313.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam_20260313
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260313_AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam/AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam_20260313.t.sol -vv
 */
contract AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam_20260313_Test is ProtocolV3TestBase {
  AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam_20260313 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 39929598);
    proposal = new AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam_20260313();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3InkWhitelabel_GrantFUNDS_ADMINRoleToInkTeam_20260313',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }

  function test_inkTeamHasFundsAdminRole() public {
    address collector = address(AaveV3InkWhitelabel.COLLECTOR);
    bytes32 fundsAdminRole = ICollector(collector).FUNDS_ADMIN_ROLE();
    assertFalse(IAccessControl(collector).hasRole(fundsAdminRole, proposal.INK_TEAM_SAFE()));

    executePayload(vm, address(proposal), AaveV3InkWhitelabel.POOL);

    assertTrue(IAccessControl(collector).hasRole(fundsAdminRole, proposal.INK_TEAM_SAFE()));
  }
}
