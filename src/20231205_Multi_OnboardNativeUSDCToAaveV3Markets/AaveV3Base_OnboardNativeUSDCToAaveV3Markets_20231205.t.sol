// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205} from './AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205.sol';

/**
 * @dev Test for AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205
 * command: make test-contract filter=AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205
 */
contract AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205_Test is ProtocolV3TestBase {
  AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205 internal proposal;
  address internal USDC_WHALE = 0x20FE51A9229EEf2cF8Ad9E89d91CAb9312cF3b7A;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 7513307);
    proposal = new AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    startHoax(USDC_WHALE);
    IERC20(proposal.USDC()).transfer(GovernanceV3Base.EXECUTOR_LVL_1, 10 ** 6);
    defaultTest(
      'AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_collectorHasUSDCFunds() public {
    startHoax(USDC_WHALE);
    IERC20(proposal.USDC()).transfer(GovernanceV3Base.EXECUTOR_LVL_1, 10 ** 6);
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDC()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Base.COLLECTOR)), 10 ** 6);
  }
}
