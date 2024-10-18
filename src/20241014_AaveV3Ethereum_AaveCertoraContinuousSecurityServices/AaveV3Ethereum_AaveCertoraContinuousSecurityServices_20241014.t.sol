// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorInterface} from 'aave-v3-origin/contracts/dependencies/chainlink/AggregatorInterface.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {IERC20Metadata} from 'solidity-utils/contracts/oz-common/interfaces/IERC20Metadata.sol';
import {IStreamable} from 'aave-address-book/common/IStreamable.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014} from './AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014.sol';

/**
 * @dev Test for AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241014_AaveV3Ethereum_AaveCertoraContinuousSecurityServices/AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014.t.sol -vv
 */
contract AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20965854);
    proposal = new AaveV3Ethereum_AaveCertoraContinuousSecurityServices_20241014();
  }

  function test_defaultProposalExecution() public {
    address receiverAddress = proposal.CERTORA_RECEIVER();
    IStreamable reserve = IStreamable(MiscEthereum.ECOSYSTEM_RESERVE);
    uint256 ghoBalanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      receiverAddress
    );
    uint256 aaveBalanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      receiverAddress
    );

    uint256 nextStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId();
    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

    uint256 nextStreamId_reserve = reserve.getNextStreamId();
    vm.expectRevert();
    AaveV3Ethereum.COLLECTOR.getStream(nextStreamId);

    executePayload(vm, address(proposal));

    vm.warp(block.timestamp + 7 days);
    vm.startPrank(receiverAddress);

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(nextStreamId, 1);
    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(receiverAddress),
      ghoBalanceBefore + 1
    );

    reserve.withdrawFromStream(nextStreamId_reserve, 1);
    assertEq(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(receiverAddress),
      aaveBalanceBefore + 1
    );

    vm.warp(proposal.STOP_TIME() + 7 days); // 11 september 2025 is quite far in the future

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(
      nextStreamId,
      AaveV3Ethereum.COLLECTOR.balanceOf(nextStreamId, receiverAddress)
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(receiverAddress),
      ghoBalanceBefore +
        1_150_000 *
        10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals(),
      1 * 10 ** IERC20Metadata(AaveV3EthereumAssets.GHO_UNDERLYING).decimals()
    );

    reserve.withdrawFromStream(
      nextStreamId_reserve,
      reserve.balanceOf(nextStreamId_reserve, receiverAddress)
    );
    assertApproxEqAbs(
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(receiverAddress),
      aaveBalanceBefore +
        (550_000 *
          10 ** IERC20Metadata(AaveV3EthereumAssets.AAVE_UNDERLYING).decimals() *
          10 ** 8) /
        proposal.AAVE_PRICE(),
      1 * 10 ** IERC20Metadata(AaveV3EthereumAssets.AAVE_UNDERLYING).decimals()
    );
    console.log(
      'AAVE received amount',
      IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(receiverAddress) - aaveBalanceBefore
    );
  }
}
