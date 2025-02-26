// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_SUSDeBaseOnboarding_20250226} from './AaveV3Base_SUSDeBaseOnboarding_20250226.sol';

/**
 * @dev Test for AaveV3Base_SUSDeBaseOnboarding_20250226
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250226_AaveV3Base_SUSDeBaseOnboarding/AaveV3Base_SUSDeBaseOnboarding_20250226.t.sol -vv
 */
contract AaveV3Base_SUSDeBaseOnboarding_20250226_Test is ProtocolV3TestBase {
  AaveV3Base_SUSDeBaseOnboarding_20250226 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 26891059);
    proposal = new AaveV3Base_SUSDeBaseOnboarding_20250226();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_SUSDeBaseOnboarding_20250226', AaveV3Base.POOL, address(proposal));
  }

  function test_collectorHassUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.sUSDe()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Base.COLLECTOR)), 10 ** 18);
  }

  function test_sUSDeAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address asUSDe, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.sUSDe()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(proposal.sUSDe()),
      proposal.sUSDe_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Base.EMISSION_MANAGER).getEmissionAdmin(asUSDe),
      proposal.sUSDe_ADMIN()
    );
  }
}
