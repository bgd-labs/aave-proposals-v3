// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731} from './AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731.sol';

/**
 * @dev Test for AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731
 * command: FOUNDRY_PROFILE=scroll forge test --match-path=src/20240731_AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll/AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731.t.sol -vv
 */
contract AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731_Test is ProtocolV3TestBase {
  AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 7953400);
    proposal = new AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }

  function test_collectorHasweETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Scroll
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.weETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Scroll.COLLECTOR)), 5e15);
  }
}
