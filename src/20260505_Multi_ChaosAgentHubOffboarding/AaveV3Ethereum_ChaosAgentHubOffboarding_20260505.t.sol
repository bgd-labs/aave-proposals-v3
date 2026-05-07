// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_ChaosAgentHubOffboarding_20260505} from './AaveV3Ethereum_ChaosAgentHubOffboarding_20260505.sol';
import {IAgentHub} from '../interfaces/chaos-agents/IAgentHub.sol';

/**
 * @dev Test for AaveV3Ethereum_ChaosAgentHubOffboarding_20260505
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260505_Multi_ChaosAgentHubOffboarding/AaveV3Ethereum_ChaosAgentHubOffboarding_20260505.t.sol -vv
 */
contract AaveV3Ethereum_ChaosAgentHubOffboarding_20260505_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ChaosAgentHubOffboarding_20260505 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25027892);
    proposal = new AaveV3Ethereum_ChaosAgentHubOffboarding_20260505();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ChaosAgentHubOffboarding_20260505',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_agentsDisabledAndRiskAdminRevoked() public {
    IAgentHub hub = IAgentHub(MiscEthereum.AGENT_HUB);
    uint256 count = hub.getAgentCount();
    require(count > 0, 'no agents registered');

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < count; i++) {
      address agent = hub.getAgentAddress(i);
      assertFalse(hub.isAgentEnabled(i), 'agent still enabled');
      assertFalse(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(agent), 'agent still risk admin on Core');
      assertFalse(
        AaveV3EthereumLido.ACL_MANAGER.isRiskAdmin(agent),
        'agent still risk admin on Lido'
      );
    }
  }

  function test_streamCanceled() public {
    uint256 streamId = proposal.PREVIOUS_STREAM();

    AaveV3EthereumLido.COLLECTOR.getStream(streamId);

    executePayload(vm, address(proposal));

    vm.expectRevert();
    AaveV3EthereumLido.COLLECTOR.getStream(streamId);
  }

  function test_payload_execution_on_cancelled_stream() public {
    uint256 streamId = proposal.PREVIOUS_STREAM();

    (, address recipient, , , , , , ) = AaveV3EthereumLido.COLLECTOR.getStream(streamId);

    vm.prank(recipient);
    AaveV3EthereumLido.COLLECTOR.cancelStream(streamId);

    executePayload(vm, address(proposal));
  }
}
