// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122} from './AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122.sol';

/**
 * @dev Test for AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122
 * command: make test-contract filter=AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122
 */
contract AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122_Test is ProtocolV3TestBase {
  AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 112522548);
    proposal = new AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_OnboardNativeUSDCToAaveV3Optimism_20231122',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_collectorHasUSDCNFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Optimism
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.USDCN());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Optimism.COLLECTOR)), 10 ** 6);
  }
}
