// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
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
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_AaveV3ScrollActivation_20240122',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }

  function test_collectorHasWETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Scroll
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.WETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Scroll.COLLECTOR)), 10 ** 18);
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Scroll
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Scroll.COLLECTOR)), 10 ** 6);
  }

  function test_collectorHaswstETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Scroll
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.wstETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Scroll.COLLECTOR)), 10 ** 18);
  }
}
