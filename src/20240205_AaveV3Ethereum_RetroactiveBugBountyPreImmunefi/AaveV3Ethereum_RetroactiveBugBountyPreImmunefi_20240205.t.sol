// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205} from './AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205.sol';

/**
 * @dev Test for AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205
 * command: make test-contract filter=AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205
 */
contract AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19162484);
    proposal = new AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_consistentBalances() public {
    AaveV3Ethereum_RetroactiveBugBountyPreImmunefi_20240205.Bounty[3] memory bounties = proposal
      .getBounties();

    uint256 TOTAL_AMOUNT = 86_500e6;

    uint256[] memory balancesRecipientsBefore = new uint256[](3);
    uint256 balanceCollectorBefore = IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    // Validate the Collector has enough aUSDC v3
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
