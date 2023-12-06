// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205} from './AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205.sol';

/**
 * @dev Test for AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205
 * command: make test-contract filter=AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205
 */
contract AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205_Test is ProtocolV3TestBase {
  AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205 internal proposal;
  address internal USDC_WHALE = 0xf491d040110384DBcf7F241fFE2A546513fD873d;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 113108279);
    proposal = new AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    startHoax(USDC_WHALE);
    IERC20(proposal.nUSDC()).transfer(GovernanceV3Optimism.EXECUTOR_LVL_1, 10 ** 6);
    defaultTest(
      'AaveV3Optimism_OnboardNativeUSDCToAaveV3Markets_20231205',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_collectorHasnUSDCFunds() public {
    startHoax(USDC_WHALE);
    IERC20(proposal.nUSDC()).transfer(GovernanceV3Optimism.EXECUTOR_LVL_1, 10 ** 6);
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Optimism
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.nUSDC());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Optimism.COLLECTOR)), 10 ** 6);
  }
}
