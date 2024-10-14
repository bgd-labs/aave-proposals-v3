// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013} from './AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013.sol';

/**
 * @dev Test for AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241013_AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider/AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013.t.sol -vv
 */
contract AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20958953);
    proposal = new AaveV3Ethereum_RenewLlamaRiskAsRiskServiceProvider_20241013();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    address receiverAddress = proposal.LLAMA_RISK_RECEIVER();
    uint256 ghoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      receiverAddress
    );

    uint256 nextStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 21 days); // 28 october is quite far in the future
    vm.startPrank(receiverAddress);

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextStreamId, 1);
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(receiverAddress),
      ghoBalanceBefore + 1
    );

    vm.warp(block.timestamp + 303 days); // 28 april 2025 is quite far in the future

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextStreamId,
      AaveV3Ethereum.COLLECTOR.balanceOf(nextStreamId, receiverAddress)
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(receiverAddress),
      ghoBalanceBefore +
        400_000 *
        10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals(),
      1 * 10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals()
    );
  }
}
