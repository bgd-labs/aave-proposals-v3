// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203} from './AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203.sol';

/**
 * @dev Test for AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203
 * command: FOUNDRY_PROFILE=scroll forge test --match-path=src/20241203_AaveV3Scroll_OnboardSCRToAaveV3Scroll/AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203.t.sol -vv
 */
contract AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203_Test is ProtocolV3TestBase {
  AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 11609572);
    proposal = new AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203();

    // Simulate SEED funds
    address SCR_WHALE = 0x212499E4E77484E565E1965Ea220D30B1c469233;
    vm.startPrank(SCR_WHALE);
    IERC20(proposal.SCR()).transfer(GovernanceV3Scroll.EXECUTOR_LVL_1, proposal.SCR_SEED_AMOUNT());
    vm.stopPrank();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }

  function test_collectorHasSCRFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Scroll
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.SCR());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Scroll.COLLECTOR)), 100 * 10 ** 18);
  }

  function test_SCRAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aSCR, , ) = AaveV3Scroll.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.SCR()
    );
    assertEq(
      IEmissionManager(AaveV3Scroll.EMISSION_MANAGER).getEmissionAdmin(proposal.SCR()),
      proposal.SCR_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Scroll.EMISSION_MANAGER).getEmissionAdmin(aSCR),
      proposal.SCR_ADMIN()
    );
  }
}
