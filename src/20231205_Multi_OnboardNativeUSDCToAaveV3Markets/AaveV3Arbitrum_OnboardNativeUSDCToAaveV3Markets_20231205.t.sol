// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205} from './AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205.sol';

/**
 * @dev Test for AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205
 * command: make test-contract filter=AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205
 */
contract AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 157897379);
    proposal = new AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_OnboardNativeUSDCToAaveV3Markets_20231205',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
