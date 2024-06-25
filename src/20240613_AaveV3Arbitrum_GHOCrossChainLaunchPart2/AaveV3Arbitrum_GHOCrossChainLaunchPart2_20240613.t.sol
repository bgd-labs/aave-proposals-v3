// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613} from './AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240613_AaveV3Arbitrum_GHOCrossChainLaunchPart2/AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613.t.sol -vv
 */
contract AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 225178100);
    proposal = new AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    // Mock Executor receives GHO, also makes sure total supply >= supply cap so e2e tests pass
    deal(proposal.GHO(), GovernanceV3Arbitrum.EXECUTOR_LVL_1, 1_000_000e18, true);

    defaultTest(
      'AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );

    (address aTokenAddress, , ) = AaveV3Arbitrum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.GHO());
    assertGe(IERC20(aTokenAddress).balanceOf(address(0)), proposal.GHO_SEED_AMOUNT());
  }

  function test_defaultProposalExecutionExactSeed() public {
    // Mock Executor receives GHO seed amount
    deal(proposal.GHO(), GovernanceV3Arbitrum.EXECUTOR_LVL_1, proposal.GHO_SEED_AMOUNT());

    GovV3Helpers.executePayload(vm, address(proposal));

    (address aTokenAddress, , ) = AaveV3Arbitrum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.GHO());
    assertGe(IERC20(aTokenAddress).balanceOf(address(0)), proposal.GHO_SEED_AMOUNT());
  }

  function testFail_defaultProposalExecutionNoSeed() public {
    GovV3Helpers.executePayload(vm, address(proposal));
  }
}
