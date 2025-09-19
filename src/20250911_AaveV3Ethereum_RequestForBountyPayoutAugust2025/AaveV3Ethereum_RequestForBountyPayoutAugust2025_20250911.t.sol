// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911} from './AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911.sol';

/**
 * @dev Test for AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250911_AaveV3Ethereum_RequestForBountyPayoutAugust2025/AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911.t.sol -vv
 */
contract AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911 internal proposal;

  uint256 TOTAL_AMOUNT = 14_300e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23345000);
    proposal = new AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  /**
   * @dev Checking:
   * - Balances post-transfer are correct
   * - Collector has enough funds
   */
  function test_consistentBalances() public {
    AaveV3Ethereum_RequestForBountyPayoutAugust2025_20250911.Bounty[3] memory bounties = proposal
      .getBounties();

    uint256[] memory balancesRecipientsBefore = new uint256[](3);
    uint256 balanceCollectorBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    // Validate the Collector has enough GHO tokens
    assertGe(balanceCollectorBefore, TOTAL_AMOUNT);

    for (uint256 i = 0; i < bounties.length; i++) {
      balancesRecipientsBefore[i] = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        bounties[i].recipient
      );
    }

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < bounties.length; i++) {
      assertApproxEqAbs(
        IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(bounties[i].recipient),
        balancesRecipientsBefore[i] + bounties[i].amount,
        1
      );
    }

    uint256 balanceCollectorAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    assertEq(balanceCollectorAfter, balanceCollectorBefore - TOTAL_AMOUNT);
  }
}
