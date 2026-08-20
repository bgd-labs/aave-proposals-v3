// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Sonic, AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Sonic_July2026FundingUpdate_20260715} from './AaveV3Sonic_July2026FundingUpdate_20260715.sol';

/**
 * @dev Test for AaveV3Sonic_July2026FundingUpdate_20260715
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260715_Multi_July2026FundingUpdate/AaveV3Sonic_July2026FundingUpdate_20260715.t.sol -vv
 */
contract AaveV3Sonic_July2026FundingUpdate_20260715_Test is ProtocolV3TestBase {
  AaveV3Sonic_July2026FundingUpdate_20260715 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('sonic'), 75979570);
    proposal = new AaveV3Sonic_July2026FundingUpdate_20260715();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Sonic_July2026FundingUpdate_20260715', AaveV3Sonic.POOL, address(proposal));
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_reserveConfigChanges() public {
    address[] memory updatedAssets = new address[](0);

    reserveConfigChangesTest(AaveV3Sonic.POOL, address(proposal), updatedAssets);
  }

  function test_approvals_wS() public {
    uint256 allowanceBefore = IERC20(AaveV3SonicAssets.wS_A_TOKEN).allowance(
      address(AaveV3Sonic.COLLECTOR),
      proposal.ACI_INCENTIVES()
    );
    assertGt(allowanceBefore, 0);

    executePayload(vm, address(proposal));

    uint256 allowanceAfter = IERC20(AaveV3SonicAssets.wS_A_TOKEN).allowance(
      address(AaveV3Sonic.COLLECTOR),
      proposal.ACI_INCENTIVES()
    );
    assertEq(allowanceAfter, 0);
  }
}
