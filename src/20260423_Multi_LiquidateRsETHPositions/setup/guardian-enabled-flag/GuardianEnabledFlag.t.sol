// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';

import {IGuardianEnabledFlag} from 'src/interfaces/IGuardianEnabledFlag.sol';
import {GuardianEnabledFlag} from './GuardianEnabledFlag.sol';

contract GuardianEnabledFlagTest is Test {
  GuardianEnabledFlag internal flag;
  address internal guardian = makeAddr('guardian');
  address internal randomUser = makeAddr('randomUser');

  function setUp() public {
    flag = new GuardianEnabledFlag(guardian);
  }

  function test_constructor_setsGuardian() public view {
    assertEq(flag.GUARDIAN(), guardian);
  }

  function test_constructor_initialEnabledIsFalse() public view {
    assertFalse(flag.enabled());
  }

  function test_constructor_revertsWhenGuardianIsZero() public {
    vm.expectRevert('ZERO_GUARDIAN');
    new GuardianEnabledFlag(address(0));
  }

  function test_setEnabled_flipsEnabledToTrueAndEmits() public {
    vm.expectEmit(address(flag));
    emit IGuardianEnabledFlag.SetEnabled(guardian, true);
    vm.prank(guardian);
    flag.setEnabled(true);
    assertTrue(flag.enabled());
  }

  function test_setEnabled_flipsEnabledToFalseAndEmits() public {
    vm.expectEmit(address(flag));
    emit IGuardianEnabledFlag.SetEnabled(guardian, true);
    vm.prank(guardian);
    flag.setEnabled(true);

    vm.expectEmit(address(flag));
    emit IGuardianEnabledFlag.SetEnabled(guardian, false);
    vm.prank(guardian);
    flag.setEnabled(false);

    assertFalse(flag.enabled());
  }

  function test_setEnabled_revertsWhenNotGuardian() public {
    vm.prank(randomUser);
    vm.expectRevert('Only guardian');
    flag.setEnabled(true);

    vm.prank(randomUser);
    vm.expectRevert('Only guardian');
    flag.setEnabled(false);
  }

  function test_setEnabled_isIdempotentAndEmitsEachTime() public {
    vm.expectEmit(address(flag));
    emit IGuardianEnabledFlag.SetEnabled(guardian, true);
    vm.prank(guardian);
    flag.setEnabled(true);
    assertTrue(flag.enabled());

    vm.expectEmit(address(flag));
    emit IGuardianEnabledFlag.SetEnabled(guardian, true);
    vm.prank(guardian);
    flag.setEnabled(true);
    assertTrue(flag.enabled());
  }

  function test_setEnabled_disableIsIdempotentAndEmitsEachTime() public {
    vm.expectEmit(address(flag));
    emit IGuardianEnabledFlag.SetEnabled(guardian, false);
    vm.prank(guardian);
    flag.setEnabled(false);
    assertFalse(flag.enabled());

    vm.expectEmit(address(flag));
    emit IGuardianEnabledFlag.SetEnabled(guardian, false);
    vm.prank(guardian);
    flag.setEnabled(false);
    assertFalse(flag.enabled());
  }
}
