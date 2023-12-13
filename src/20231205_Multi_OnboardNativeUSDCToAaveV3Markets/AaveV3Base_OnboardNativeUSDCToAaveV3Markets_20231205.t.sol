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

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 7850956);
    proposal = new AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_OnboardNativeUSDCToAaveV3Markets_20231205',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_collectorHasUSDCFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveTokensAddresses(
      proposal.USDC()
    );
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Base.COLLECTOR)), 10 ** 6);
  }
}
