// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';
import {AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026} from './AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026.sol';

/**
 * @dev Test for AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251026_AaveV3EthereumLido_SecurityServicesForAaveV4Certora/AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026.t.sol -vv
 */
contract AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026 internal proposal;
  address constant aGHO_WHALE = 0x2cE01c87Fec1b71A9041c52CaED46Fc5f4807285;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23663673);
    proposal = new AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026();
    vm.prank(aGHO_WHALE);
    IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).transfer(
      address(AaveV3EthereumLido.COLLECTOR),
      10_000_000 * 10 ** 18
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_SecurityServicesForAaveV4Certora_20251026',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_GHOStream() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%

    uint256 ghoBalancesBeforeUsers = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      proposal.CERTORA()
    );

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + proposal.STREAM_DURATION() + 1 days);

    uint256 aGHOInterest = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
      proposal.CERTORA()
    ) - ghoBalancesBeforeUsers;
    // Stream transfers
    uint256 finalBalanceToWithdraw = AaveV3EthereumLido.COLLECTOR.balanceOf(
      nextStreamId,
      proposal.CERTORA()
    );

    assertApproxEqRel(
      finalBalanceToWithdraw,
      proposal.AGHO_AMOUNT(),
      maxDeltaStreamBalance,
      'GHO Stream final balance is not correct'
    );

    vm.prank(proposal.CERTORA());
    AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId, finalBalanceToWithdraw);
    assertApproxEqRel(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(proposal.CERTORA()),
      ghoBalancesBeforeUsers + proposal.AGHO_AMOUNT() + aGHOInterest,
      maxDeltaStreamBalance,
      'GHO Stream final withdraw is not correct'
    );
  }
}
