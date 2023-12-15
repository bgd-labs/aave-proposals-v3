// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213} from './AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213.sol';

/**
 * @dev Test for AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213
 * command: make test-contract filter=AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213
 */
contract AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213 internal proposal;

  uint256 TOTAL_AMOUNT = 23_600 ether;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18784397);
    proposal = new AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213();
  }

  /**
   * @dev Checking:
   * - Balances post-transfer are correct
   * - Collector has enough funds
   */
  function test_consistentBalances() public {
    AaveV3Ethereum_RequestForBountyPayoutDecember2023_20231213.Bounty[4] memory bounties = proposal
      .getBounties();

    uint256[] memory balancesRecipientsBefore = new uint256[](4);
    uint256 balanceCollectorBefore = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    // Validate the Collector has enough aDAI v3
    assertGe(balanceCollectorBefore, TOTAL_AMOUNT);

    for (uint256 i = 0; i < bounties.length; i++) {
      balancesRecipientsBefore[i] = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
        bounties[i].recipient
      );
    }

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < bounties.length; i++) {
      assertApproxEqAbs(
        IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(bounties[i].recipient),
        balancesRecipientsBefore[i] + bounties[i].amount,
        1
      );
    }

    uint256 balanceCollectorAfter = IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    // Checking worst case scenario of 4 wei imprecision, but probabilistically pretty rare
    assertApproxEqAbs(balanceCollectorAfter, balanceCollectorBefore - TOTAL_AMOUNT, 4);
  }
}
