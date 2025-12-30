// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ReimburseLinkForRobot_20251201} from './AaveV3Ethereum_ReimburseLinkForRobot_20251201.sol';

/**
 * @dev Test for AaveV3Ethereum_ReimburseLinkForRobot_20251201
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Ethereum_ReimburseLinkForRobot_20251201.t.sol -vv
 */
contract AaveV3Ethereum_ReimburseLinkForRobot_20251201_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ReimburseLinkForRobot_20251201 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23990197);
    proposal = new AaveV3Ethereum_ReimburseLinkForRobot_20251201();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ReimburseLinkForRobot_20251201',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_BgdReceivedLinkToken() public {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(
      proposal.BGD_RECEIVER()
    );
    GovV3Helpers.executePayload(vm, address(proposal));
    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(
      proposal.BGD_RECEIVER()
    );

    assertEq(balanceAfter - balanceBefore, 120 ether);
  }
}
