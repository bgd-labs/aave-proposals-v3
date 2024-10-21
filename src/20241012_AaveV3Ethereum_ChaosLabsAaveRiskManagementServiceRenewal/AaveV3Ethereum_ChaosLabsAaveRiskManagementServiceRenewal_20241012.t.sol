// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ChaosLabsAaveRiskManagementServiceRenewal_20241012} from './AaveV3Ethereum_ChaosLabsAaveRiskManagementServiceRenewal_20241012.sol';

/**
 * @dev Test for AaveV3Ethereum_ChaosLabsAaveRiskManagementServiceRenewal_20241012
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241012_AaveV3Ethereum_ChaosLabsAaveRiskManagementServiceRenewal/AaveV3Ethereum_ChaosLabsAaveRiskManagementServiceRenewal_20241012.t.sol -vv
 */
contract AaveV3Ethereum_ChaosLabsAaveRiskManagementServiceRenewal_20241012_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_ChaosLabsAaveRiskManagementServiceRenewal_20241012 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20952046);
    proposal = new AaveV3Ethereum_ChaosLabsAaveRiskManagementServiceRenewal_20241012();
  }

  function test_defaultProposalExecution() public {
    address receiverAddress = proposal.CHAOS_LABS_RECEIVER();
    uint256 ghoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      receiverAddress
    );
    uint256 aUsdtBalanceBefore = IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(
      receiverAddress
    );

    uint256 nextStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 35 days); // November 13 is in a long time
    vm.startPrank(receiverAddress);

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextStreamId, 1);
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(receiverAddress),
      ghoBalanceBefore + 1
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextStreamId + 1, 1);
    assertEq(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(receiverAddress),
      aUsdtBalanceBefore + 1
    );

    vm.warp(block.timestamp + 400 days); // November 13 2025 is in a long time

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextStreamId,
      AaveV3Ethereum.COLLECTOR.balanceOf(nextStreamId, receiverAddress)
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(receiverAddress),
      ghoBalanceBefore +
        1_000_000 *
        10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals(),
      1 * 10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals()
    );

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextStreamId + 1,
      AaveV3Ethereum.COLLECTOR.balanceOf(nextStreamId + 1, receiverAddress)
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN).balanceOf(receiverAddress),
      aUsdtBalanceBefore +
        1_000_000 *
        10 ** IERC20Metadata(AaveV3EthereumAssets.USDT_A_TOKEN).decimals(),
      25 * 10 ** IERC20Metadata(AaveV3EthereumAssets.USDT_A_TOKEN).decimals() //due to rounding and low decimals error is of ~25 $
    );
  }
}
