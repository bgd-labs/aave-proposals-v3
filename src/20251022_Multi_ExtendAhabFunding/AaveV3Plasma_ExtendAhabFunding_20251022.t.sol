// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_ExtendAhabFunding_20251022} from './AaveV3Plasma_ExtendAhabFunding_20251022.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3PlasmaAssets} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @dev Test for AaveV3Plasma_ExtendAhabFunding_20251022
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251022_Multi_ExtendAhabFunding/AaveV3Plasma_ExtendAhabFunding_20251022.t.sol -vv
 */
contract AaveV3Plasma_ExtendAhabFunding_20251022_Test is ProtocolV3TestBase {
  AaveV3Plasma_ExtendAhabFunding_20251022 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 4230876);
    proposal = new AaveV3Plasma_ExtendAhabFunding_20251022();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Plasma_ExtendAhabFunding_20251022', AaveV3Plasma.POOL, address(proposal));
  }

  function test_allowancesBeforeAfter() public {
    uint256 usdt0AllowanceBefore = IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 usdeAllowanceBefore = IERC20(AaveV3PlasmaAssets.USDe_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );

    assertEq(usdt0AllowanceBefore, 0, 'USDT0 allowance should be 0 before');
    assertEq(usdeAllowanceBefore, 0, 'USDe allowance should be 0 before');

    executePayload(vm, address(proposal));

    uint256 usdt0AllowanceAfter = IERC20(AaveV3PlasmaAssets.USDT0_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );
    uint256 usdeAllowanceAfter = IERC20(AaveV3PlasmaAssets.USDe_A_TOKEN).allowance(
      address(AaveV3Plasma.COLLECTOR),
      MiscEthereum.AHAB_SAFE
    );

    assertEq(usdt0AllowanceAfter, 3_000_000 ether, 'USDT0 allowance mismatch');
    assertEq(usdeAllowanceAfter, 2_000_000 ether, 'USDe allowance mismatch');
  }
}
