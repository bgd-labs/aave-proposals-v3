// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702} from './AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702.sol';

/**
 * @dev Test for AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240702_AaveV3Ethereum_RequestForBountyPayoutJune2024/AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702.t.sol -vv
 */
contract AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702 internal proposal;

  uint256 TOTAL_AMOUNT = 1_100e18;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20217051);
    proposal = new AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702',
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
    AaveV3Ethereum_RequestForBountyPayoutJune2024_20240702.Bounty[2] memory bounties = proposal
      .getBounties();

    uint256[] memory balancesRecipientsBefore = new uint256[](2);
    uint256 balanceCollectorBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    // Validate the Collector has enough aUSDC v2
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

    // Checking worst case scenario of 2 wei imprecision, but probabilistically pretty rare
    assertApproxEqAbs(balanceCollectorAfter, balanceCollectorBefore - TOTAL_AMOUNT, 3);
  }
}
