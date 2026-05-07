// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {MiscPlasma} from 'aave-address-book/MiscPlasma.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_ChaosAgentHubOffboarding_20260505} from './AaveV3Plasma_ChaosAgentHubOffboarding_20260505.sol';
import {IAgentHub} from '../interfaces/chaos-agents/IAgentHub.sol';

/**
 * @dev Test for AaveV3Plasma_ChaosAgentHubOffboarding_20260505
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260505_Multi_ChaosAgentHubOffboarding/AaveV3Plasma_ChaosAgentHubOffboarding_20260505.t.sol -vv
 */
contract AaveV3Plasma_ChaosAgentHubOffboarding_20260505_Test is ProtocolV3TestBase {
  AaveV3Plasma_ChaosAgentHubOffboarding_20260505 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 21142710);
    proposal = new AaveV3Plasma_ChaosAgentHubOffboarding_20260505();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_ChaosAgentHubOffboarding_20260505',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_agentsDisabledAndRiskAdminRevoked() public {
    IAgentHub hub = IAgentHub(MiscPlasma.AGENT_HUB);
    uint256 count = hub.getAgentCount();
    require(count > 0, 'no agents registered');

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < count; i++) {
      address agent = hub.getAgentAddress(i);
      assertFalse(hub.isAgentEnabled(i), 'agent still enabled');
      assertFalse(AaveV3Plasma.ACL_MANAGER.isRiskAdmin(agent), 'agent still risk admin');
    }
  }
}
