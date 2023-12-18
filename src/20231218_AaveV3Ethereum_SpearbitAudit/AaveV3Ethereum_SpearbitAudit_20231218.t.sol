// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovV3Helpers, GovV3StorageHelpers, GovernanceV3Ethereum} from 'aave-helpers/GovV3Helpers.sol';
import {GovHelpers, AaveGovernanceV2} from 'aave-helpers/GovHelpers.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_SpearbitAudit_20231218} from './AaveV3Ethereum_SpearbitAudit_20231218.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {DeploymentHelper} from './SpearbitAudit_20231218.s.sol';

/**
 * @dev Test for AaveV3Ethereum_SpearbitAudit_20231218
 * command: make test-contract filter=AaveV3Ethereum_SpearbitAudit_20231218
 */
contract AaveV3Ethereum_SpearbitAudit_20231218_Test is ProtocolV3TestBase {
  AaveV3Ethereum_SpearbitAudit_20231218 internal proposal;

  function _executeV2Proposal(uint256 proposalId) internal {
    uint256 executionTime = AaveGovernanceV2.GOV.getProposalById(proposalId).executionTime;
    vm.warp(executionTime + 1);
    AaveGovernanceV2.GOV.execute(proposalId);
  }

  function _executeV3Proposal(Vm vm, uint256 proposalId) internal {
    GovV3StorageHelpers.readyProposal(vm, proposalId);
    GovernanceV3Ethereum.GOVERNANCE.executeProposal(proposalId);
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18812072);
    proposal = new AaveV3Ethereum_SpearbitAudit_20231218();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    _executeV2Proposal(395); // long 395
    GovHelpers.passVoteAndExecute(vm, 415); // short 415
    GovV3Helpers.executePayload(vm, 26); // mediator call

    uint256 daiBalanceBefore = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 usdcBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 BGDaDAIBalanceBefore = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(proposal.BGD())
    );
    uint256 cantinaUSDCBalanceBefore = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(proposal.CANTINA())
    );

    uint40 payloadId = DeploymentHelper.createPayloads();
    deal(MiscEthereum.ECOSYSTEM_RESERVE, 1 ether);
    vm.startPrank(MiscEthereum.ECOSYSTEM_RESERVE);
    uint256 proposalId = DeploymentHelper.createProposal(vm);
    vm.stopPrank();
    _executeV3Proposal(vm, proposalId);
    GovV3Helpers.executePayload(vm, payloadId);

    uint256 usdcBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    uint256 daiBalanceAfter = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    assertApproxEqAbs(daiBalanceBefore - daiBalanceAfter, 42_000 ether, 1);
    assertApproxEqAbs(usdcBalanceBefore - usdcBalanceAfter, 109_200e6, 1);

    uint256 BGDaDAIBalanceAfter = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(proposal.BGD())
    );
    uint256 cantinaUSDCBalanceAfter = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(proposal.CANTINA())
    );
    assertApproxEqAbs(BGDaDAIBalanceAfter - BGDaDAIBalanceBefore, 42_000 ether, 1);
    assertApproxEqAbs(cantinaUSDCBalanceAfter - cantinaUSDCBalanceBefore, 109_200e6, 1);
  }
}
