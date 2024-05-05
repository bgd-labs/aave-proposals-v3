// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409} from './AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409.sol';

/**
 * @dev Test for AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409
 * command: make test-contract filter=AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409
 */
contract AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 200346777);
    proposal = new AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_collectorHasweETHFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    (address aTokenAddress, , ) = AaveV3Arbitrum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.weETH());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Arbitrum.COLLECTOR)), 10 ** 16);
  }
}
