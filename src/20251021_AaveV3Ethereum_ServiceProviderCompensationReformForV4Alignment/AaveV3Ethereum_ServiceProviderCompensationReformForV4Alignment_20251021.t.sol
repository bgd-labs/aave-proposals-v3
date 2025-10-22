// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';
import {AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021} from './AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021.sol';

import {ReformData} from './ReformData.sol';

/**
 * @dev Test for AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251021_AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment/AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021.t.sol -vv
 */
contract AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021 internal proposal;
  address constant aGHO_WHALE = 0x2cE01c87Fec1b71A9041c52CaED46Fc5f4807285;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23627170);
    proposal = new AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021();
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
      'AaveV3Ethereum_ServiceProviderCompensationReformForV4Alignment_20251021',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_GHOStream() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%

    uint256[] memory ghoBalancesBeforeUsers = new uint256[](4);

    ReformData.ReformDataStructure[] memory reformData = ReformData.getReformData();

    for (uint256 i = 0; i < reformData.length; i++) {
      ghoBalancesBeforeUsers[i] = IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(
        reformData[i].recipient
      );
    }

    uint256 nextStreamId = AaveV3EthereumLido.COLLECTOR.getNextStreamId();

    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    // test cancelation
    for (uint256 i = 0; i < reformData.length; i++) {
      vm.expectRevert();
      AaveV3Ethereum.COLLECTOR.getStream(reformData[i].toCancel);
    }

    vm.warp(block.timestamp + ReformData.STREAM_DURATION + 1 days);

    // transfer from previous stream cancelation count as "interest"
    uint256[] memory aGHOInterest = new uint256[](4);
    for (uint256 i = 0; i < reformData.length; i++) {
      aGHOInterest[i] =
        IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(reformData[i].recipient) -
        ghoBalancesBeforeUsers[i];
    }
    // Stream transfers
    for (uint256 i = 0; i < reformData.length; i++) {
      uint256 finalBalanceToWithdraw = AaveV3EthereumLido.COLLECTOR.balanceOf(
        nextStreamId + i,
        reformData[i].recipient
      );

      assertApproxEqRel(
        finalBalanceToWithdraw,
        reformData[i].amount,
        maxDeltaStreamBalance,
        'GHO Stream final balance is not correct'
      );

      vm.prank(reformData[i].recipient);
      AaveV3EthereumLido.COLLECTOR.withdrawFromStream(nextStreamId + i, finalBalanceToWithdraw);
      assertApproxEqRel(
        IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN).balanceOf(reformData[i].recipient),
        ghoBalancesBeforeUsers[i] + reformData[i].amount + aGHOInterest[i],
        maxDeltaStreamBalance,
        'GHO Stream final withdraw is not correct'
      );
    }
  }

  function test_AAVEStream() public {
    // 0.001% tolerance due to stream computation inaccuracy
    uint256 maxDeltaStreamBalance = 0.00001e18; // 0.001%

    ReformData.ReformDataStructure memory reformData = ReformData.getReformDataAAVE();

    uint256 nextStreamId = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE).getNextStreamId();

    vm.expectRevert();
    IStreamable(MiscEthereum.ECOSYSTEM_RESERVE).getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.expectRevert();
    IStreamable(MiscEthereum.ECOSYSTEM_RESERVE).getStream(reformData.toCancel);

    // any sooner and we miss the transfered aave from stream cancellation
    uint256 aaveBalancesBeforeUsers = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      reformData.recipient
    );

    vm.warp(block.timestamp + ReformData.STREAM_DURATION + 1 days);

    // Stream transfers
    uint256 finalBalanceToWithdraw = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE).balanceOf(
      nextStreamId,
      reformData.recipient
    );

    assertApproxEqRel(
      finalBalanceToWithdraw,
      reformData.amount,
      maxDeltaStreamBalance,
      'GHO Stream final balance is not correct'
    );

    vm.prank(reformData.recipient);
    IStreamable(MiscEthereum.ECOSYSTEM_RESERVE).withdrawFromStream(
      nextStreamId,
      finalBalanceToWithdraw
    );
    assertApproxEqRel(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(reformData.recipient),
      aaveBalancesBeforeUsers + reformData.amount,
      maxDeltaStreamBalance,
      'GHO Stream final withdraw is not correct'
    );
  }
}
