// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221} from './AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221.sol';

/**
 * @dev Test for AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241221_Multi_OnboardEzETHToArbitrumAndBaseInstances/AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221.t.sol -vv
 */
contract AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 292661143);
    proposal = new AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_OnboardEzETHToArbitrumAndBaseInstances_20241221',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_collectorHasezETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Arbitrum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.ezETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Arbitrum.COLLECTOR)), 3 * 10 ** 16);
  }

  function test_ezETHAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aezETH, , ) = AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.ezETH()
    );
    assertEq(
      IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).getEmissionAdmin(proposal.ezETH()),
      proposal.ezETH_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Arbitrum.EMISSION_MANAGER).getEmissionAdmin(aezETH),
      proposal.ezETH_LM_ADMIN()
    );
  }
}
