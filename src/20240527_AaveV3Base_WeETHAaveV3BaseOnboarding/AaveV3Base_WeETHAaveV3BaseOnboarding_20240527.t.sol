// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Base_WeETHAaveV3BaseOnboarding_20240527} from './AaveV3Base_WeETHAaveV3BaseOnboarding_20240527.sol';

/**
 * @dev Test for AaveV3Base_WeETHAaveV3BaseOnboarding_20240527
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20240527_AaveV3Base_WeETHAaveV3BaseOnboarding/AaveV3Base_WeETHAaveV3BaseOnboarding_20240527.t.sol -vv
 */
contract AaveV3Base_WeETHAaveV3BaseOnboarding_20240527_Test is ProtocolV3TestBase {
  AaveV3Base_WeETHAaveV3BaseOnboarding_20240527 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 15015803);
    proposal = new AaveV3Base_WeETHAaveV3BaseOnboarding_20240527();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_WeETHAaveV3BaseOnboarding_20240527',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_collectorHasweETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.weETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Base.COLLECTOR)), 1 ** 16);
  }
}
