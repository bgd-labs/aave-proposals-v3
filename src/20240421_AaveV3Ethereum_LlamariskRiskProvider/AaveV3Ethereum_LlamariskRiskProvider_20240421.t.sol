// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum_LlamariskRiskProvider_20240421} from './AaveV3Ethereum_LlamariskRiskProvider_20240421.sol';

/**
 * @dev Test for AaveV3Ethereum_LlamariskRiskProvider_20240421
 * command: make test-contract filter=AaveV3Ethereum_LlamariskRiskProvider_20240421
 */
contract AaveV3Ethereum_LlamariskRiskProvider_20240421_Test is ProtocolV3TestBase {
  AaveV3Ethereum_LlamariskRiskProvider_20240421 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19705748);
    proposal = new AaveV3Ethereum_LlamariskRiskProvider_20240421();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_LlamariskRiskProvider_20240421',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_validateStreamsConfig() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 currentCollectorStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId() - 1;

    _validateGhoStreamConfig(currentCollectorStreamId);
  }

  function test_withdrawFromStream() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 currentCollectorStreamId = AaveV3Ethereum.COLLECTOR.getNextStreamId() - 1;

    uint256 timeWarp = 180 days + 1;
    vm.warp(block.timestamp + timeWarp);

    _validateGhoStreamWithdrawal(currentCollectorStreamId);
  }

  function _validateGhoStreamConfig(uint256 streamId) internal {
    (
      address sender,
      address recipient,
      uint256 amount,
      address token,
      uint256 startTime,
      uint256 endTime,
      uint256 toClaim,

    ) = AaveV3Ethereum.COLLECTOR.getStream(streamId);

    assertEq(sender, address(AaveV3Ethereum.COLLECTOR));
    assertEq(recipient, proposal.LLAMARISK_RECIPIENT());
    assertEq(amount, proposal.ACTUAL_GHO_STREAM());
    assertEq(token, AaveV3EthereumAssets.GHO_UNDERLYING);
    assertEq(endTime - startTime, proposal.STREAM_DURATION());
    assertEq(toClaim, proposal.ACTUAL_GHO_STREAM());
  }

  function _validateGhoStreamWithdrawal(uint256 streamId) internal {
    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.LLAMARISK_RECIPIENT()
    );

    vm.startPrank(proposal.LLAMARISK_RECIPIENT());

    AaveV3Ethereum.COLLECTOR.withdrawFromStream(streamId, proposal.ACTUAL_GHO_STREAM());

    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
      proposal.LLAMARISK_RECIPIENT()
    );
    assertEq(balanceAfter, balanceBefore + proposal.ACTUAL_GHO_STREAM());
    vm.stopPrank();
  }
}
