// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513} from './AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513.sol';

/**
 * @dev Test for AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260507_AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream/AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513.t.sol -vv
 */
contract AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513_Test is
  ProtocolV3TestBase
{
  address internal constant CHAOS_LABS_RECIPIENT = 0xbC540e0729B732fb14afA240aA5A047aE9ba7dF0;

  AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25088476);
    proposal = new AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_OffboardingPlanForChaosLabsPart3CancelStream_20260513',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  /**
   * @dev Documents the stream being cancelled at fork block: the recipient is
   *      the address publicly identified as the Chaos Labs receiver, and the
   *      stream is active with a non-zero rate.
   */
  function test_preExecution_streamMatchesExpected() public view {
    uint256 streamId = proposal.PREVIOUS_STREAM();
    (address sender, address recipient, , , , , , uint256 ratePerSecond) = AaveV3EthereumLido
      .COLLECTOR
      .getStream(streamId);
    assertEq(streamId, 100073);
    assertEq(recipient, CHAOS_LABS_RECIPIENT);
    assertEq(sender, address(AaveV3EthereumLido.COLLECTOR));
    assertGt(ratePerSecond, 0);
  }

  /**
   * @dev After execution the stream must no longer exist; further reads of
   *      its id revert (Aave Collector deletes the entry on cancel).
   */
  function test_streamCanceled() public {
    uint256 streamId = proposal.PREVIOUS_STREAM();

    // sanity: stream exists pre-exec
    AaveV3EthereumLido.COLLECTOR.getStream(streamId);

    executePayload(vm, address(proposal));

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(streamId);
  }
}
