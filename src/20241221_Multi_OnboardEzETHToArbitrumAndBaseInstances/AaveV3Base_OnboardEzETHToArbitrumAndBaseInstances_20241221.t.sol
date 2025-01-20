// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221} from './AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221.sol';

/**
 * @dev Test for AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221.t.sol -vv
 */
contract AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221_Test is ProtocolV3TestBase {
  AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 24698319);
    proposal = new AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_OnboardEzETHToArbitrumAndBaseInstances_20241221',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_collectorHasezETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.ezETH()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Base.COLLECTOR)), 3 * 10 ** 16);
  }

  function test_ezETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aezETH, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.ezETH()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(proposal.ezETH()),
      proposal.ezETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(aezETH),
      proposal.ezETH_LM_ADMIN()
    );
  }
}
