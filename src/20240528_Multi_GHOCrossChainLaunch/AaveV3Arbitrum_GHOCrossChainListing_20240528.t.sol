// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IGhoToken} from 'gho-core/gho/interfaces/IGhoToken.sol';

import {AaveV3Arbitrum_GHOCrossChainListing_20240528} from './AaveV3Arbitrum_GHOCrossChainListing_20240528.sol';
import {AaveV3Arbitrum_GHOCrossChainLaunch_20240528, Utils} from './AaveV3Arbitrum_GHOCrossChainLaunch_20240528.sol';

/**
 * @dev Test for AaveV3Arbitrum_GHOCrossChainLaunch_20240528
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240528_Multi_GHOCrossChainLaunch/AaveV3Arbitrum_GHOCrossChainListing_20240528.t.sol -vv
 */
contract AaveV3Arbitrum_GHOCrossChainListing_20240528_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_GHOCrossChainListing_20240528 internal proposal;
  AaveV3Arbitrum_GHOCrossChainLaunch_20240528 internal beforeProposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 220652440);
    proposal = new AaveV3Arbitrum_GHOCrossChainListing_20240528();
    beforeProposal = new AaveV3Arbitrum_GHOCrossChainLaunch_20240528();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    // Cross-chain proposal happens first
    GovV3Helpers.executePayload(vm, address(beforeProposal));
    assertEq(beforeProposal.GHO(), proposal.GHO());

    // Payload receives GHO seed amount
    vm.startPrank(GovernanceV3Arbitrum.EXECUTOR_LVL_1);
    IGhoToken(proposal.GHO()).addFacilitator(
      address(this),
      'Faucet',
      uint128(proposal.GHO_SEED_AMOUNT())
    );
    vm.stopPrank();
    IGhoToken(proposal.GHO()).mint(GovernanceV3Arbitrum.EXECUTOR_LVL_1, proposal.GHO_SEED_AMOUNT());

    defaultTest(
      'AaveV3Arbitrum_GHOCrossChainListing_20240528',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );

    (address aTokenAddress, , ) = AaveV3Arbitrum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveTokensAddresses(proposal.GHO());
    assertGe(IERC20(aTokenAddress).balanceOf(address(0)), proposal.GHO_SEED_AMOUNT());
  }

  function testFail_defaultProposalExecutionNoSeed() public {
    // Cross-chain proposal happens first
    GovV3Helpers.executePayload(vm, address(beforeProposal));
    assertEq(beforeProposal.GHO(), proposal.GHO());

    vm.expectRevert();
    GovV3Helpers.executePayload(vm, address(proposal));
  }
}
