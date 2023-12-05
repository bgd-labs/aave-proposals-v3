// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127} from './AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127.sol';

/**
 * @dev Test for AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127
 * command: make test-contract filter=AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127
 */
contract AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127_Test is ProtocolV3TestBase {
  AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127 internal proposal;
  address internal wstETH_WHALE = 0xC9B826BAD20872EB29f9b1D8af4BefE8460b50c6;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 7361627);
    proposal = new AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    startHoax(wstETH_WHALE);
    IERC20(proposal.wstETH()).transfer(GovernanceV3Base.EXECUTOR_LVL_1,0.01 ether);
    defaultTest(
      'AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_collectorHaswstETHFunds() public {
    startHoax(wstETH_WHALE);
    IERC20(proposal.wstETH()).transfer(GovernanceV3Base.EXECUTOR_LVL_1,0.01 ether);
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.wstETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Base.COLLECTOR)), 0.01 ether);
  }
}
