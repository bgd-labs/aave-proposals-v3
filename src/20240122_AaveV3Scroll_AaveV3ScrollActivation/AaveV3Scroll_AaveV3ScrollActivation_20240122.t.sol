// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {MiscScroll} from 'aave-address-book/MiscScroll.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Scroll_AaveV3ScrollActivation_20240122} from './AaveV3Scroll_AaveV3ScrollActivation_20240122.sol';

/**
 * @dev Test for AaveV3Scroll_AaveV3ScrollActivation_20240122
 * command: make test-contract filter=AaveV3Scroll_AaveV3ScrollActivation_20240122
 */
contract AaveV3Scroll_AaveV3ScrollActivation_20240122_Test is ProtocolV3TestBase {
  AaveV3Scroll_AaveV3ScrollActivation_20240122 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 2669127);
    proposal = new AaveV3Scroll_AaveV3ScrollActivation_20240122();

    // TOOD: remove after revoking permission
    vm.startPrank(0x6ec33534BE07d45cc4E02Fbd127F8ed2aE919a6b);
    IOwnable(GovernanceV3Scroll.EXECUTOR_LVL_1).transferOwnership(
      address(GovernanceV3Scroll.PAYLOADS_CONTROLLER)
    );
    vm.stopPrank();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution_scroll() public {
    defaultTest(
      'AaveV3Scroll_AaveV3ScrollActivation_20240122',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }

  function test_AdminPermissions() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    assertTrue(AaveV3Scroll.ACL_MANAGER.isRiskAdmin(AaveV3Scroll.CAPS_PLUS_RISK_STEWARD));
    assertTrue(AaveV3Scroll.ACL_MANAGER.isRiskAdmin(AaveV3Scroll.FREEZING_STEWARD));
    assertTrue(AaveV3Scroll.ACL_MANAGER.isPoolAdmin(MiscScroll.PROTOCOL_GUARDIAN));
  }

  function test_SeedWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Scroll
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.WETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Scroll.COLLECTOR)),
      proposal.WETH_SEED_AMOUNT()
    );
  }

  function test_SeedUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Scroll
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDC());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Scroll.COLLECTOR)),
      proposal.USDC_SEED_AMOUNT()
    );
  }

  function test_SeedwstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Scroll
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.wstETH());
    assertGe(
      IERC20(aTokenAddress).balanceOf(address(AaveV3Scroll.COLLECTOR)),
      proposal.wstETH_SEED_AMOUNT()
    );
  }
}

interface IOwnable {
  function transferOwnership(address newOwner) external;
}
