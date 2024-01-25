// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {CommonTestBase} from 'aave-helpers/CommonTestBase.sol';
import {AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125} from './AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125.sol';

/**
 * @dev Test for AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125
 * command: make test-contract filter=AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125
 */
contract AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125_Test is CommonTestBase {
  AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125 internal proposal;

  uint256 TOTAL_AMOUNT = 16_000e6;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19081060);
    proposal = new AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125();
  }

  /**
   * @dev Checking:
   * - Balances post-transfer are correct
   * - Collector has enough funds
   */
  function test_consistentBalances() public {
    AaveV3Ethereum_RequestForBountyPayoutJanuary2024_20240125.Bounty[3] memory bounties = proposal
      .getBounties();

    uint256[] memory balancesRecipientsBefore = new uint256[](3);
    uint256 balanceCollectorBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    // Validate the Collector has enough aUSDC v2
    assertGe(balanceCollectorBefore, TOTAL_AMOUNT);

    for (uint256 i = 0; i < bounties.length; i++) {
      balancesRecipientsBefore[i] = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
        bounties[i].recipient
      );
    }

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < bounties.length; i++) {
      assertApproxEqAbs(
        IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(bounties[i].recipient),
        balancesRecipientsBefore[i] + bounties[i].amount,
        1
      );
    }

    uint256 balanceCollectorAfter = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    // Checking worst case scenario of 3 wei imprecision, but probabilistically pretty rare
    assertApproxEqAbs(balanceCollectorAfter, balanceCollectorBefore - TOTAL_AMOUNT, 3);
  }
}
