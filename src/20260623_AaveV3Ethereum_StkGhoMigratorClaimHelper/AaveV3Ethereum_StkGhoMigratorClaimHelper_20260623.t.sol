// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {IStakeToken} from 'aave-address-book/common/IStakeToken.sol';
import {IStkGhoMigrator} from '../interfaces/IStkGhoMigrator.sol';

import {GhoEthereum} from 'aave-address-book/GhoEthereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IERC4626} from 'openzeppelin-contracts/contracts/interfaces/IERC4626.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623} from './AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623.sol';

/**
 * @dev Test for AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260623_AaveV3Ethereum_StkGhoMigratorClaimHelper/AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623.t.sol -vv
 */
contract AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25378904);
    proposal = new AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_executePayload() public {
    IStakeToken stkGho = IStakeToken(AaveSafetyModule.STK_GHO);

    assertNotEq(stkGho.getAdmin(stkGho.CLAIM_HELPER_ROLE()), proposal.STK_GHO_MIGRATOR());

    executePayload(vm, address(proposal), AaveV3Ethereum.POOL);

    assertEq(stkGho.getAdmin(stkGho.CLAIM_HELPER_ROLE()), proposal.STK_GHO_MIGRATOR());
    assertEq(stkGho.getPendingAdmin(stkGho.CLAIM_HELPER_ROLE()), address(0));
  }

  function test_e2e_migration() public {
    IStakeToken stkGho = IStakeToken(AaveSafetyModule.STK_GHO);
    IERC20 gho = IERC20(GhoEthereum.GHO_TOKEN);
    IERC4626 sGho = IERC4626(GhoEthereum.SGHO);
    IStkGhoMigrator migrator = IStkGhoMigrator(proposal.STK_GHO_MIGRATOR());

    address user = makeAddr('USER');
    deal(address(gho), user, 100e18);

    vm.startPrank(user);
    gho.approve(address(stkGho), 100e18);
    stkGho.stake(user, 100e18);
    vm.stopPrank();
    vm.warp(block.timestamp + 10 days);

    assertEq(stkGho.balanceOf(user), 100e18);

    executePayload(vm, address(proposal), AaveV3Ethereum.POOL);

    uint256 stkGhoBalance = stkGho.balanceOf(user);
    uint256 sGhoBalanceBefore = sGho.balanceOf(user);
    uint256 expectedSGhoShares = sGho.previewDeposit(stkGhoBalance);

    vm.prank(user);
    migrator.migrate();

    assertEq(stkGho.balanceOf(user), 0);
    assertGt(sGho.balanceOf(user), sGhoBalanceBefore);
    assertEq(gho.balanceOf(address(migrator)), 0);
    assertEq(sGho.balanceOf(user), expectedSGhoShares);
    assertApproxEqAbs(
      sGho.previewRedeem(sGho.balanceOf(user) - sGhoBalanceBefore),
      stkGhoBalance,
      1
    ); //assert redeemable amount matches principal
  }
}
